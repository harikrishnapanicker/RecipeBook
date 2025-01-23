//
//  RecepieView.swift
//  RecepieBook
//
//  Created by HarikrishnaPanicker on 09/10/24.
//

import SwiftUI


struct RecepieView: View {
    @StateObject var viewModel: RecepieViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showingSheet = false
    @State private var zoomed = false
    @Binding var history: String
    @State var showHistory: Bool = false
    @Binding var warmTheme: Bool

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: warmTheme ? Gradient(colors: [Color.yellow, Color.red]) : Gradient(colors: [Color.blue, Color.green]), startPoint: .top, endPoint: .trailing)
                    .ignoresSafeArea()
                ScrollView{
                    VStack {
                        AsyncImage(url: URL(string: viewModel.recepie?.image ?? "")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: zoomed ? .fill : .fit)
                        } placeholder: {
                            Image("placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                        .clipShape(.buttonBorder)
                        //                    .aspectRatio(contentMode: zoomed ? .fill : .fit)
                        .frame(width: 200, height: 200, alignment: .top)
                        .onTapGesture {
                            withAnimation {
                                zoomed.toggle()
                            }
                        }
                        DynamicIcons(viewModel: viewModel)
                        Details(viewModel: viewModel, showHistory: $showHistory, warmTheme: $warmTheme)
                        CommentsListView(viewModel: viewModel)
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                showingSheet.toggle()
                            }) {
                                Text("Add Comment")
                                    .font(.system(size: 15, weight: .black, design: .rounded))
                                    .foregroundColor(.yellow)
                                    .shadow(radius: 2)
                                    .clipped()
                                    .padding(.trailing, 20)
                            }}
                    }
                }
            }
            .sheet(isPresented: $showingSheet) {
                CommentsView(viewModel: CommentsViewModel(selectedItem: viewModel.selectedItem, userData: viewModel.user))
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text(viewModel.recepie?.name ?? "Getting Ready")
                        .font(.system(size: 20, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        history = showHistory ? viewModel.recepie?.name ?? history : history
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
    RecepieView(viewModel: RecepieViewModel(selectedItem: DishModel(id: 1, name: "Something", image: "placeholder"), user: UserModel(userID: "1", userName: "Anonymous", userIcon: "dp1")), history: .constant(""), warmTheme: .constant(false))
}

struct CommentsListView: View {
    @StateObject var viewModel: RecepieViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Comments")
                    .font(.system(size: 20, weight: .black, design: .rounded))
                    .foregroundColor(.yellow)
                    .shadow(radius: 2)
                    .clipped()
                    .padding(.leading, 10)
                    .padding(.top, 10)
                Spacer()
            }
            
            List(viewModel.comments, id: \.comment) { data in
                VStack {
                    HStack {
                        Image(data.user.userIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20, alignment: .center)
                            .padding(.leading, 10)
                        Text(data.user.userName)
                            .font(.system(size: 15, weight: .black, design: .rounded))
                            .foregroundColor(.gray)
                            .clipped()
                            .padding(.leading, 5)
                        Spacer()
                    }
                    HStack {
                        Text(data.comment)
                            .font(.system(size: 15, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(radius: 2)
                            .clipped()
                        .padding(.leading, 5)
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
            
        }
    }
}

struct DynamicIcons: View {
    @StateObject var viewModel: RecepieViewModel

    var body: some View {
        HStack {
            Spacer()
            ZStack {
                Image("CookingTime")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .overlay(GeometryReader { gp in
                        Text(viewModel.cookingTIme())
                            .font(.system(size: 12, weight: .black, design: .rounded))
                            .foregroundColor(.yellow)
                            .shadow(radius: 2)
                            .position(x: gp.size.width / 2, y: gp.size.height / 1.7)
                    })
            }
            Spacer()
            ZStack {
                Image("PrepTime")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .overlay(GeometryReader { gp in
                        Text(viewModel.prepTime())
                            .font(.system(size: 12, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(radius: 2)
                            .position(x: gp.size.width / 2, y: gp.size.height / 2.1)
                        
                    })
            }
            Spacer()
            ZStack {
                Image("Servings")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .overlay(GeometryReader { gp in
                        Text(viewModel.servings())
                            .font(.system(size: 15, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(radius: 2)
                            .position(x: gp.size.width / 2, y: gp.size.height / 2)
                        
                    })
            }
            Spacer()
            ZStack {
                Image("calorie")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .overlay(GeometryReader { gp in
                        Text(viewModel.calorie())
                            .font(.system(size: 12, weight: .black, design: .rounded))
                            .foregroundColor(.black)
                            .position(x: gp.size.width / 2, y: gp.size.height / 1.5)
                        
                    })
            }
            Spacer()
        }
        .clipped()
    }
}

struct Details: View {
    @StateObject var viewModel: RecepieViewModel
    @Binding var showHistory: Bool
    @Binding var warmTheme: Bool

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Toggle("Show History", isOn:$showHistory)
                        .padding(.trailing, 20.0)
                }
                HStack {
                    Spacer()
                    Toggle("Warm Theme", isOn: $warmTheme)
                        .padding(.trailing, 20.0)
                }
            }
            HStack {
                Text("Incredients")
                    .font(.system(size: 20, weight: .black, design: .rounded))
                    .foregroundColor(.yellow)
                    .shadow(radius: 2)
                    .clipped()
                    .padding(.leading, 10)
                    .padding(.top, 10)
                Spacer()
                Label("Spicy", systemImage: "flame.fill")
                    .padding(.trailing, 10.0)
                    .font(.headline.lowercaseSmallCaps())
                    .foregroundColor(.red)
                    .shadow(radius: 5)
            }
            HStack {
                Text(viewModel.ingredients())
                    .font(.system(size: 15, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(radius: 2)
                    .lineLimit(.max)
                    .clipped()
                    .padding(.leading, 10)
                    .padding(.top, 5)
                Spacer()
            }
            
            HStack {
                Text("Instructions")
                    .font(.system(size: 20, weight: .black, design: .rounded))
                    .foregroundColor(.yellow)
                    .shadow(radius: 2)
                    .clipped()
                    .padding(.leading, 10)
                    .padding(.top, 5)
                Spacer()
            }
            
            HStack {
                Text(viewModel.instructions())
                    .font(.system(size: 15, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(radius: 2)
                    .lineLimit(.max)
                    .clipped()
                    .padding(.leading, 10)
                    .padding(.top, 5)
                Spacer()
            }
        }
    }
}
