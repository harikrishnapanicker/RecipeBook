//
//  Home.swift
//  RecepieBook
//
//  Created by HarikrishnaPanicker on 09/10/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @State private var searchText: String = ""
    @State private var goToProfile = false
    @State private var history: String = ""
    @State private var warmTheme: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: warmTheme ? Gradient(colors: [Color.yellow, Color.red]) : Gradient(colors: [Color.blue, Color.green]), startPoint: .top, endPoint: .trailing)
                    .ignoresSafeArea()
                VStack {
                    List(viewModel.homeData?.recipes ?? [DishModel](), id: \.id) { data in
                        NavigationLink(value: data) {
                            VStack {
                                
                                Text(data.name)
                                    .font(.system(size: 14, weight: .black, design: .rounded))
                                    .foregroundColor(.white)
                                    .shadow(radius: 2)
                                
                                AsyncImage(url: URL(string: data.image)) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Image("placeholder")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                }
                                .clipShape(.buttonBorder)
                                .shadow(radius: 2)
                                
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowSpacing(20.0)
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowSpacing(20.0)
                    }
                    .scrollContentBackground(.hidden)
                    HStack {
                        Spacer()
                        Label(history, systemImage: "clock")
                    }
                }
                
            }
            .navigationDestination(for: DishModel.self) { data in
                RecepieView(viewModel: RecepieViewModel(selectedItem: data, user: viewModel.user), history: $history, warmTheme: $warmTheme)
            }
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Recepies")
                            .font(.system(size: 30, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                        Spacer()
                        NavigationLink(value: goToProfile) {
                            Image(viewModel.userDP ?? "dp1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
            }.navigationDestination(for: Bool.self) { user in
                UserView(viewModel: UserViewModel(userData: viewModel.user))
            }
            .onAppear() {
                viewModel.fetchUser()
            }

        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
