//
//  CommentsViewModel.swift
//  RecepieBook
//
//  Created by HarikrishnaPanicker on 11/10/24.
//

import Foundation

class CommentsViewModel: ObservableObject {
    var selectedItem: DishModel
    var userData: UserModel
    var comment: CommentModel
    
    init(selectedItem: DishModel, userData: UserModel) {
        self.selectedItem = selectedItem
        self.userData = userData
        self.comment = CommentModel(user: userData, comment: "", dishId: selectedItem.id)
    }
    
    func save() {
        RealtimeData.shared.save(comment: comment)
    }
}
