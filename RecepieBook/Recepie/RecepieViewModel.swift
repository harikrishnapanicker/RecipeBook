//
//  RecepieViewModel.swift
//  RecepieBook
//
//  Created by HarikrishnaPanicker on 09/10/24.
//

import Foundation

@MainActor
class RecepieViewModel: ObservableObject {
    @Published var recepie: RecepieModel?
    var selectedItem: DishModel
    var user: UserModel
    @Published var comments = [CommentModel]()

    init(selectedItem: DishModel, user: UserModel) {
        self.selectedItem = selectedItem
        self.user = user
        Task {
            do {
                recepie = try await fetchRecepie()
            }
        }
        fetchComments()
    }
    
    func fetchRecepie() async throws -> RecepieModel {
        let link = "https://dummyjson.com/recipes/" + "\(selectedItem.id)"
        let url = URL(string: link)
        let request = URLRequest(url: url!)
        let (data, response) = try await URLSession.shared.data(for: request)
        if let res = response as? HTTPURLResponse {
            if res.statusCode != 200 {
                throw RecepieError.APIFailed
            }
        }
        let recepieData = try JSONDecoder().decode(RecepieModel.self, from: data)
        return recepieData
    }
    
    func fetchComments() {
        RealtimeData.shared.fetchComments(dishId: selectedItem.id) { [weak self] comments, _ in
            if let _comments = comments {
                self?.comments = _comments
            }
        }
    }
    
    func ingredients() -> String {
        return recepie?.ingredients.map({$0 + "\n"}).reduce("", +) ?? ""
    }
    
    func instructions() -> String {
        return recepie?.instructions.reduce("", +) ?? ""
    }
    
    func cookingTIme() -> String {
        return "\(recepie?.cookTimeMinutes ?? 0)"
    }
    
    func prepTime() -> String {
        return "\(recepie?.prepTimeMinutes ?? 0)"
    }
    
    func servings() -> String {
        return "\(recepie?.servings ?? 0)"
    }
    
    func calorie() -> String {
        return "\(recepie?.caloriesPerServing ?? 0)"
    }
}
