//
//  Goal Page.swift
//  Napha Training App
//
//  Created by Kui Jun on 24/6/24.
//

import SwiftUI

struct Goal_Page: View {
    
    var body: some View {
        ScrollView{
            Text("GOALS")
                .font(.system(size: 60))
                .bold()
            Image("TargetBoard")
                .scaledToFit()
                .scaleEffect(0.3)
                .offset(y: -150)
        }
    }
}

#Preview {
    Goal_Page()
}
