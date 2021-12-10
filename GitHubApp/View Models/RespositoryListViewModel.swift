//
//  RespositoryListViewModel.swift
//  GitHubApp
//
//  Created by Mohammad Azam on 5/16/21.
//

import Foundation
import Apollo

typealias Node = GetRepositoriesByUserNameQuery.Data.User.Repository.Node

enum RepositoriesDisplay {
    case latest
    case top
}

class RepositoryListViewModel: ObservableObject {
    
    @Published var repositories: [RepositoryViewModel] = []
    @Published var repositoriesDisplay: RepositoriesDisplay = .latest
    
    func getTopRepositoryForUser(username: String) {
        
        Network.shared.apollo.fetch(query: GetTopRepositoriesForUserQuery(username: username)) { result in
            switch result {
            case .success(let graphQLResult):
                guard let data = graphQLResult.data,
                      let user = data.user,
                      let nodes = user.repositories.nodes
                else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.repositories = nodes.compactMap { $0 }.map(RepositoryViewModel.init)
                }
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    func getLatestRepositoriesForUser(username: String) {
        Network.shared.apollo.fetch(query: GetRepositoriesByUserNameQuery(username: username), cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let graphQLResult):
                //                print("success")
                guard let data = graphQLResult.data,
                      let user = data.user,
                      let nodes = user.repositories.nodes
                else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.repositories = nodes.compactMap { $0 }.map(RepositoryViewModel.init)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct RepositoryViewModel {
    
    let node: RepositoryNode
    
    var hasRating: Bool {
        node.stargazerCount > 0
    }
    var id: GraphQLID {
        node.id
    }
    var name: String {
        node.name
    }
    var description: String {
        node.description ?? ""
    }
    var starCount: Int {
        node.stargazerCount
    }
    
}
