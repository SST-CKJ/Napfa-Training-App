//
//  ContentView.swift
//  Napha Training App
//
//  Created by Kui Jun on 24/5/24.
//

import SwiftUI
import SwiftPersistence


/*struct info: Codable{
    var Age: Int
    var Gender: Bool
    var prev: [Text]
    var target: [Text]
    var schedule: [Text]
}
*/
struct ContentView: View {
    
  /*  @Persistent ("list") var data :[info] = []*/
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
