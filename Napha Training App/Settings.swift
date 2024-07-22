//
//  Settings.swift
//  Napha Training App
//
//  Created by Kui Jun on 4/7/24.
//

import SwiftUI

struct Settings: View {
    
    @Binding var info: data
    @State var GoalSheet = false
    @Binding var selectedTimedSettings: [Date]
    
    var body: some View {
        Button{
            GoalSheet.toggle()
        } label: {
            Label("Goal Setting", systemImage: "target")
        }
        .sheet(isPresented: $GoalSheet){
            Goal_Page(info: $info, selectedTimes: $selectedTimedSettings)
        }
    }
}

#Preview {
    Settings(info: .constant(data(Age: 0, Gender: false, prev: [], target: [], schedule: [], NAPHA_Date: Date.now, Goals: [])), selectedTimedSettings: .constant([]))
}
