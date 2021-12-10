//
//  Query+Extensions.swift
//  GitHubApp
//
//  Created by Mohammad Azam on 5/17/21.
//

import Foundation
import Apollo

extension GetTopRepositoriesForUserQuery.Data.User.Repository.Node: RepositoryNode { }

extension GetRepositoriesByUserNameQuery.Data.User.Repository.Node: RepositoryNode { }
