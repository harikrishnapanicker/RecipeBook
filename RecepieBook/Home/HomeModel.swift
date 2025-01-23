//
//  HomeModel.swift
//  RecepieBook
//
//  Created by HarikrishnaPanicker on 09/10/24.
//

import Foundation

struct HomeModel: Decodable {
    let recipes: [DishModel]
    let total: Int
    let skip: Int
    let limit: Int
}
