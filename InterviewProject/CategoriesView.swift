//
//  ContentView.swift
//  InterviewProject
//
//  Created by Amir Hayek on 28/11/2023.
//

import SwiftUI

//view model that uses the api client and stores categories and products
class ViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var products: [Product] = []
    
    private let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func loadCategories() async {
        do {
            categories = try await apiClient.getCategories()
        } catch {
            print(error)
        }
    }
    
    func loadProducts(inCategory category: Category) {
        Task {
            products = []
            do {
                products = try await apiClient.getProducts(inCategory: category)
            } catch {
                print(error)
            }
        }
    }
}


struct CategoriesView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
            List(viewModel.categories) { category in
                NavigationLink(
                    category.name,
                    destination: ProductsView(category: category, viewModel: viewModel)
                )
            }.task {
                await viewModel.loadCategories()
            }
    }
}

#Preview {
    CategoriesView(viewModel: ViewModel(apiClient: ApiClient()))
}
