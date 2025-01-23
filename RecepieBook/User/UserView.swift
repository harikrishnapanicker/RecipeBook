//
//  UserView.swift
//  RecepieBook
//
//  Created by HarikrishnaPanicker on 10/10/24.
//

import SwiftUI

struct UserView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: UserViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .top, endPoint: .trailing)
                    .ignoresSafeArea()
                
                VStack {
                    
                    Image(viewModel.user.userIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200, alignment: .center)
                    TextField("Name", text: $viewModel.user.userName)
                        .font(.system(size: 30, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    HStack {
                        Spacer()
                        Image("dp1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                                viewModel.setUser(dp: "dp1")
                            }
                        Spacer()
                        
                        Image("dp2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                                viewModel.setUser(dp: "dp2")
                            }
                        Spacer()
                        
                        Image("dp3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                                viewModel.setUser(dp: "dp3")
                            }
                        Spacer()
                        
                        Image("dp4")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                                viewModel.setUser(dp: "dp4")
                            }
                        Spacer()
                        
                        Image("dp5")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                                viewModel.setUser(dp: "dp5")
                            }
                        Spacer()
                        
                    }
                    Spacer()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Profile")
                        .font(.system(size: 20, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        viewModel.saveUser()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.yellow)
                            .padding(10)
                    }
                }
            }
        }
    }
}

#Preview {
    UserView(viewModel: UserViewModel(userData: UserModel(userID: "1", userName: "Random User", userIcon: "dp1")))
}
