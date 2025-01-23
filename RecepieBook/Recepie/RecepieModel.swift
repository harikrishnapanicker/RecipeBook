//
//  RecepieModel.swift
//  RecepieBook
//
//  Created by HarikrishnaPanicker on 10/10/24.
//

import Foundation

struct DishModel: Decodable, Hashable {
    let id: Int
    let name: String
    let image: String
}

struct RecepieModel: Decodable, Hashable {
    let id: Int
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let prepTimeMinutes: Int
    let cookTimeMinutes: Int
    let servings: Int
    let difficulty: String
    let cuisine: String
    let caloriesPerServing: Int
    let tags: [String]
    let userId: Int
    let image: String
    let rating: Double
    let reviewCount: Int
    let mealType: [String]
}
