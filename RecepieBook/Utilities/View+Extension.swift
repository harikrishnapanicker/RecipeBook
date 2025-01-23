//
//  View+Extension.swift
//  RecepieBook
//
//  Created by HarikrishnaPanicker on 10/10/24.
//

import SwiftUI

struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier( HiddenNavigationBar() )
    }
}

//class DB {
//    
//    var userData: UserModel?
//    
//    static let shared = DB()
//    
//    private init (){}
//}
