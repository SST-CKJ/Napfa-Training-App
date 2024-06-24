//
//  Login.swift
//  Napha Training App
//
//  Created by Kui Jun on 24/6/24.
//

import SwiftUI

struct Login: View {
    
    @State var choice = "Login"
    
//    init(){
//        let font = UIFont.systemFont(ofSize: 18)
//        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
//    }
    
    var body: some View {
        ScrollView{
            //Image()
            Text("Sign Up")
                .font(.system(size: 50))
                .bold()
            
            Picker(selection: $choice){
                Text("Login").tag("Login")
                Text("Sign Up").tag("Sign Up")
            } label: {
                Text("Choice")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
    }
}

#Preview {
    Login()
}
