//
//  RealtimeData.swift
//  RecepieBook
//
//  Created by HarikrishnaPanicker on 11/10/24.
//

import Foundation
import FirebaseDatabase

class RealtimeData {
    
    static let shared = RealtimeData()
    private let database = Database.database().reference()

}

extension RealtimeData {
    
    // Comments
    
    public func fetchComments(dishId: Int, completion: @escaping ([CommentModel]?, Error?) -> Void) {
        let userRef = database.child("RecepieBook").child("Comments").child("dish").child("\(dishId)").child("Comments")
        userRef.observeSingleEvent(of: .value) { snapshot,_ in
            if let snapshotValue = snapshot.value as? [String: Any] {
                var comments = [CommentModel]()
                for value in snapshotValue {
                    if let data = value.value as? [String: Any] {
                        let commentId = data["comment_id"] as? String ?? ""
                        let comment = data["comment"] as? String ?? ""
                        let user = data["user"]  as? [String: Any] ?? [String: Any]()
                        let userId = user["userID"] as? String ?? ""
                        let userName = user["userName"] as? String ?? ""
                        let userIcon = user["userIcon"] as? String ?? ""
                        let userData = UserModel(userID: userId, userName: userName, userIcon: userIcon)
                        let commentData = CommentModel(user: userData, comment: comment, dishId: dishId)
                        comments.append(commentData)
                    }
                }
                completion(comments, nil)
            } else {
                completion(nil, RecepieError.FirebaseFailed)
            }
        } withCancel: { error in
            completion(nil, error)
        }
    }
    
    public func save(comment: CommentModel) {
        let commentId = UUID().uuidString // Generates a unique UUID string
        let userRef = database.child("RecepieBook").child("Comments").child("dish").child("\(comment.dishId)").child("Comments").child(commentId)
        userRef.setValue([
            "comment_id": commentId,
            "comment": comment.comment,
            "user": [
                "userID": comment.user.userID,
                "userName": comment.user.userName,
                "userIcon": comment.user.userIcon
            ]
        ]) { error, ref in
            if let error = error {
                print("Error adding user: \(error.localizedDescription)")
            } else {
                print("User added successfully!")
            }
        }
    }
    
    // User
    
    public func save(user: UserModel) {
        let userRef = database.child("RecepieBook").child("users").child(user.userID)
        let user = ["user_name": user.userName, "user_icon": user.userIcon]
        userRef.setValue(user) { error, ref in
            if let error = error {
                print("Error writing data: \(error.localizedDescription)")
            } else {
                print("Data written successfully!")
            }
        }
    }
    
    func fetchUser(userId: String, completion: @escaping (UserModel?, Error?) -> Void) {
        let userRef = database.child("RecepieBook").child("users").child(userId)
        userRef.observeSingleEvent(of: .value) { snapshot,_ in
            if let snapshotValue = snapshot.value as? [String: Any] {
                let userName = snapshotValue["user_name"] as? String ?? ""
                let userIcon = snapshotValue["user_icon"] as? String ?? ""

                let user = UserModel(userID: userId, userName: userName, userIcon: userIcon)
                completion(user, nil)
            } else {
                completion(nil, RecepieError.FirebaseFailed)
            }
        } withCancel: { error in
            completion(nil, error)
        }
    }
    
    func updateUser(user: UserModel) {
        let dbRef = database.child("RecepieBook").child("users").child(user.userID)
        let updatedData: [String: Any] = ["user_name": user.userName, "user_icon": user.userIcon]
        dbRef.updateChildValues(updatedData) { error, ref in
            if let error = error {
                print("Firebase update failed with :", error)
            }
        }
    }
}
