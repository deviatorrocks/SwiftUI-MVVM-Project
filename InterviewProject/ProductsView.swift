//
//  ProductsView.swift
//  InterviewProject
//
//  Created by Amir Hayek on 28/11/2023.
//

import SwiftUI

struct ProductsView: View {
    let category: Category
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        List(viewModel.products) { product in
            NavigationLink(product.title, destination: ProductView(product: product))
        }.onAppear {
            viewModel.loadProducts(inCategory: category)
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu(content: {
                    Button(ProductsOrder.sortByTitle.rawValue) {
                        viewModel.products.sort {
                            $0.title < $1.title
                        }
                    }
                    Button(ProductsOrder.priceAscending.rawValue) {
                        viewModel.products.sort {
                            $0.price < $1.price
                        }
                    }
                    Button(ProductsOrder.priceDescending.rawValue) {
                        viewModel.products.sort {
                            $0.price > $1.price
                        }
                    }
                }, label: {Text("Sort")})
            }
        }
    }
}

