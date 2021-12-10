//
//  View+Extensions.swift
//  GitHubApp
//
//  Created by Mohammad Azam on 5/15/21.
//

import Foundation
import SwiftUI

extension View {
    
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
}
