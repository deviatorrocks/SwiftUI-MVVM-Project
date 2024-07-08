//
//  InterviewProjectApp.swift
//  InterviewProject
//
//  Created by Amir Hayek on 28/11/2023.
//

import SwiftUI

@main
struct InterviewProjectApp: App {
    var body: some Scene {
        WindowGroup {
            CategoriesView(viewModel: ViewModel(apiClient: ApiClient()))
        }
    }
}
