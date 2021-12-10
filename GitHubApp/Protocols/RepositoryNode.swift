//
//  RepositoryNode.swift
//  GitHubApp
//
//  Created by Nicholas Kearns on 11/28/21.
//

import Foundation
import Apollo


protocol RepositoryNode {
    var id: GraphQLID { get }
    var name: String { get }
    var description: String? { get }
    var stargazerCount: Int { get }
}
