//
//  CommentsView.swift
//  RecepieBook
//
//  Created by HarikrishnaPanicker on 11/10/24.
//

import SwiftUI

struct CommentsView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: CommentsViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .top, endPoint: .trailing)
                .ignoresSafeArea()
            VStack() {
                HStack {
                    Image(viewModel.userData.userIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20, alignment: .center)
                        .padding(.leading, 10)
                    Text(viewModel.userData.userName)
                        .font(.system(size: 20, weight: .black, design: .rounded))
                        .foregroundColor(.yellow)
                        .shadow(radius: 2)
                        .clipped()
                        .padding(.leading, 5)
                }
                TextField("Comment", text: $viewModel.comment.comment)
                    .font(.system(size: 16, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                            .font(.system(size: 20, weight: .black, design: .rounded))
                            .foregroundColor(.yellow)
                            .shadow(radius: 2)
                            .clipped()
                            .padding(.leading, 20)
                    }
                    Spacer()
                    Button(action: {
                        viewModel.save()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                            .font(.system(size: 20, weight: .black, design: .rounded))
                            .foregroundColor(.yellow)
                            .shadow(radius: 2)
                            .clipped()
                            .padding(.trailing, 20)
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    CommentsView(viewModel: CommentsViewModel(selectedItem: DishModel(id: 1, name: "Some Dish", image: "placeholder"), userData: UserModel(userID: "1", userName: "Random User", userIcon: "dp1")))
}
