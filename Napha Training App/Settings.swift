//  Settings.swift
//  Napha Training App
//
//  Created by Kui Jun on 4/7/24.

import SwiftUI

struct Settings: View {
    
    //@Binding var info: data
    @StateObject var info: dataViewModel
    @Binding var GoalSheet : Bool
    @Binding var AgeSheet:Bool
    @Binding var SchedSheet: Bool
    @Binding var selectedTimedSettings: [Date]
    @Binding var selectedDaysSettings: [Int]
    @Binding var Sex: Bool
    @Binding var age: Int
    @Binding var ftSettings: Bool
    @State var GoalSheetSettings: Bool = false
    @State var AgeSheetSettings: Bool = false
    @State var SchedSheetSettings: Bool = false
    @State var autoCalcSettings: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment:.leading) {
                HStack {
                    Text("General")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                }
                .padding()
                .background(Color.white)
                
                Divider()
                
                Button(action: {
                    GoalSheetSettings.toggle()
                }) {
                    HStack {
                        Image(systemName: "target")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                        Text("Goal Setting")
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                }
                .fullScreenCover(isPresented: $GoalSheetSettings) {
                    Goal_Page(start: .constant(false), info: dataViewModel(), Sex: $Sex, Age: $age, GoalSheet: $GoalSheet)
                }
                Button(action: {
                    autoCalcSettings.toggle()
                }) {
                    HStack {
                        Image(systemName: "candybarphone")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                        Text("Auto Calculation")
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                }
                .fullScreenCover(isPresented: $autoCalcSettings){
                    AutoCalcView(info: dataViewModel())
                }
    
                Button(action: {
                    AgeSheetSettings.toggle()
                })  {
                    HStack {
                        Image(systemName: "person")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                        Text("Age and Gender")
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                }
                .fullScreenCover(isPresented: $AgeSheetSettings){
                    Age_Gender(start: .constant(false), info: dataViewModel(), ageFirstTime: $ftSettings, ageSheet: $AgeSheet)
                }
                
                Button(action: {
                    SchedSheet.toggle()
                }) {
                    HStack {
                        Image(systemName: "clock")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                        Text("Scheduling")
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                }
                .fullScreenCover(isPresented: $SchedSheet){
                    Scheduling_(start: .constant(false), info: dataViewModel(), selectedDays: $selectedDaysSettings, selectedTimes: $selectedTimedSettings, schedSheet: $SchedSheet)
                }
            }
            .padding(.horizontal)
            .navigationBarHidden(true)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(info: dataViewModel(), GoalSheet:.constant(false), AgeSheet:.constant(false), SchedSheet:.constant(false), selectedTimedSettings:.constant([]), selectedDaysSettings: .constant([]), Sex: .constant(true), age: .constant(0), ftSettings: .constant(true))
    }
}
