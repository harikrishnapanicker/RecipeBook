//
//  UserViewModel.swift
//  RecepieBook
//
//  Created by HarikrishnaPanicker on 10/10/24.
//

import Foundation
import FirebaseAuth

class UserViewModel: ObservableObject {
    @Published var user: UserModel
    
    init(userData: UserModel) {
        user = userData
    }
    
    func saveUser() {
        RealtimeData.shared.updateUser(user: user)
    }
    
    func setUser(dp: String) {
        user.userIcon = dp
    }
}
