//
//  Home.swift
//  Napha Training App
//
//  Created by Kui Jun on 24/6/24.
//

import SwiftUI

struct Home: View {
    
    //@State var Naphadate: [Date] = Date.now
    @State var date = ""
    
    var body: some View {
        ScrollView{
            Text("NAPFA EXAMINATION IN")
            Text("\(date)")
                .font(.system(size: 50))
                .bold()
            VStack{
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: 150,height: 200)
                    .position(CGPoint(x: 100, y: 250))
                    .foregroundColor(.yellow)
                Text("Squats")
                
            }
        }
    }
}

#Preview {
    Home()
}
