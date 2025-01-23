//
//  HomeViewModel.swift
//  RecepieBook
//
//  Created by HarikrishnaPanicker on 09/10/24.
//

import Foundation
import FirebaseAuth
import Combine

struct Person: Decodable {
    let name: String
}

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var homeData: HomeModel?
    @Published var selectedItem: DishModel?
    @Published var userDP: String?
    var user: UserModel = UserModel(userID: "1", userName: "Anonymous", userIcon: "dp1")
    
    init(){
        fetchUser()
        Task {
            do {
                homeData = try await fetchData()
            }
        }
    }
    
    func fetchUser() {
        let userID = Auth.auth().currentUser!.uid
        RealtimeData.shared.fetchUser(userId: userID) { [weak self] data, error in
            self?.userDP = data?.userIcon
            if let data {
                self?.user = data
            }
        }
    }
    
    func fetchData() async throws -> HomeModel {
        let url = URL(string: "https://dummyjson.com/recipes?limit=10&skip=0&select=name,image")
        let request = URLRequest(url: url!)
        let (data, response) = try await URLSession.shared.data(for: request)
        if let res = response as? HTTPURLResponse {
            if res.statusCode != 200 {
                throw RecepieError.APIFailed
            }
        }
        let fetchData = try JSONDecoder().decode(HomeModel.self, from:  data)
        return fetchData
    }
    
    func getRecepieVM() -> RecepieViewModel {
        return RecepieViewModel(selectedItem: selectedItem!, user: user)
    }
}

extension URLResponse {
    var statusCode: NSInteger? {
        return (self as? HTTPURLResponse)?.statusCode
    }
}

enum RecepieError: Error {
    case APIFailed
    case FirebaseFailed
}
