//
//  ApiClient.swift
//  InterviewProject
//
//  Created by Amir Hayek on 28/11/2023.
//

import Foundation

struct Category: Decodable, Identifiable {
    var id: String { "name" }
    let name: String
}

struct Product: Identifiable, Decodable {
    let id: Int
    let title: String
    let price: Double
    let rating: Double
    let thumbnail: URL
    let images: [URL]
}

struct ProductsResponse: Decodable {
    let products: [Product]
}

class ApiClient {
    
    enum Endpoint {
        case categories
        case products(category: Category)
        
        var url: URL {
            switch self {
            case .categories:
                return URL(string: "https://dummyjson.com/products/category-list")!
            case .products(let category):
                return URL(string: "https://dummyjson.com/products/category/\(category.name)")!
            }
        }
    }
    
    func getCategories() async throws -> [Category] {
        //Load and return all categories from https://dummyjson.com/products/categories
        
        let (categoriesData, _) = try! await URLSession.shared.data(from: Endpoint.categories.url)
        let categories = try! JSONDecoder().decode([String].self, from: categoriesData).map(Category.init(name:))
        return categories
    }
    
    func getProducts(inCategory category: Category) async throws -> [Product] {
        //Load and return all products from https://dummyjson.com/products/category/{category}
        
        let (productsData, _) = try! await URLSession.shared.data(from: Endpoint.products(category: category).url)
        let products = try! JSONDecoder().decode(ProductsResponse.self, from: productsData).products
        return products
    }
}
