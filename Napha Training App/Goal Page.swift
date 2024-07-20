//
//  Goal Page.swift
//  Napha Training App
//
//  Created by Kui Jun on 24/6/24.
//

import SwiftUI

struct Goal_Page: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var exercises = ["Sit Ups", "Standing Broad Jump", "Sit & Reach", "Inclined Pull Ups", "Shuttle Run", "2.4km Run"]
    @State private var grades = ["A", "B", "C", "D", "E", "F", "NA"]
    
    @Binding var info: data
    @State var Sex = true
    @State private var prev = ["", "", "", "", "", ""]
    @State private var targ = ["", "", "", "", "", ""]
    @State private var Nil = [false, false,  false, false, false, false]
    @State private var Goals: [[String]] = []
    @State private var age = 12
    @State private var Days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    @State private var selectedDays: Set<Int> = []
    @State private var toThrow: String = ""
    var body: some View {
        NavigationStack{
            ScrollView{
                Text("GOALS")
                    .font(.system(size: 60))
                    .bold()
                    .offset(y: 100)
                Image("TargetBoard")
                    .scaledToFit()
                    .scaleEffect(0.3)
                    .offset(y: -60)
                
                Text("ABOUT ME")
                    .font(.system(size: 20))
                    .foregroundStyle(.gray)
                    .offset(y: -150)
                    .position(x: 100)
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 190, height: 40)
                            .foregroundColor(Color("UIColour"))
                        Stepper(value: $age, in: 12...24, step: 1){
                            Text("Age: \(age)")
                        }
                        .padding(.horizontal, 70)
                    }
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 190, height: 40)
                            .foregroundColor(Color("UIColour"))
                        Picker("Sex",selection: $Sex){
                            Text("Male").tag(true)
                            Text("Female").tag(false)
                        }
                        .offset(x: Sex ? -60 : -50)
                        .accentColor(.black)
                    }
                }
                .padding(.horizontal, 60)
                .offset(y: -150)
                .offset(x: -75)
                
                Text("RESULTS")
                    .font(.system(size: 20))
                    .foregroundStyle(.gray)
                    .offset(y: -130)
                    .position(x: 100)
                
                Grid{
                    
                    let offset = Nil.sorted { $0 && !$1 }[0]
                    
                    GridRow{
                        Text("Previous\nGrade")
                            .font(.system(size: 17))
                            .offset(x: 180)
                            .padding()
                            .fixedSize(horizontal: true, vertical: true)
                            .multilineTextAlignment(.center)
                            .gridColumnAlignment(.center)
                            .lineLimit(2)
                        Text("Target\nGrade")
                            .font(.system(size: 17))
                            .offset(x: 180)
                            .padding()
                            .multilineTextAlignment(.center)
                            .gridColumnAlignment(.leading)
                            .lineLimit(2)
                    }
                    
                    ForEach(exercises.indices, id:\.self){ index in
                        GridRow{
                            Button{
                                withAnimation{
                                    Nil[index].toggle()
                                }
                                targ[index] = Nil[index] ? "": "false"
                                prev[index] = Nil[index] ? "": "false"
                            } label: {
                                Label("", systemImage:
                                        Nil[index] ? "checkmark.square.fill" : "checkmark.square")
                                .font(.system(size: 20))
                            }
                            .offset(x: offset ? 23 : 20)
                            
                            Text(exercises[index])
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(width: 100)
                                .offset(x: offset ? 10 : 0)
                            
                            if Nil[index]{
                                Picker("prev", selection: $prev[index]){
                                    ForEach(grades, id: \.self){ grade in
                                        Text(grade).tag(grade)
                                    }
                                }
                                
                                Picker("targ", selection: $targ[index]){
                                    ForEach(grades, id: \.self){ grade in
                                        Text(grade).tag(grade)
                                    }
                                }
                                .gridCellAnchor(.trailing)
                            }
                            Spacer()
                        }
                        .padding(.vertical, 10)
                    }
                }
                .offset(y: -150)
                
                DatePicker(selection: $info.NAPHA_Date, displayedComponents: .date){
                    Text("Select your Napha Data")
                }
                .padding(.horizontal, 50)
                .offset(y: -150)
                
                Grid{
                    ForEach(Goals.indices, id: \.self){ index in
                        GridRow{
                            TextField(text: $Goals[index][0]){
                                Text("input goal for exercise...")
                            }
                            .textFieldStyle(.roundedBorder)
                            .offset(x: 30)
                            Picker("exercise", selection: $Goals[index][1]){
                                ForEach(exercises, id: \.self){ exercise in
                                    Text(exercise).tag(exercise)
                                }
                            }
                            .offset(x: -30)
                        }
                        .padding(.horizontal, 30)
                        .padding(.vertical, -30)
                    }
                    .padding(.vertical)
                    .offset(y: -140)
                    
                    Button{
                        Goals.append(["", ""])
                    } label: {
                        Text("Create New Goal")
                    }
                    .offset(y: -140)
                }
                
                
                Text("SCHEDULE")
                    .font(.system(size: 20))
                    .foregroundStyle(.gray)
                    .offset(x: -110)
                    .offset(y: -110)
                
                HStack(spacing: 15){
                    ForEach(Days.indices, id: \.self){day in  Text(String(Days[day]).prefix(1))
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 35, height: 35)
                            .background(Circle().fill(selectedDays.contains(day) ? Color.blue : Color.gray)
                                .animation(.easeInOut(duration: 0.3), value: selectedDays))
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)){
                                    if selectedDays.contains(day){
                                        selectedDays.remove(day)
                                    } else {
                                        selectedDays.insert(day)
                                        
                                    }
                                }
                            }
                    }                                           .bold()
                        .offset(y: -90)
                        
                        
                }
                Text("TIMING")
                    .font(.system(size: 20))
                    .foregroundStyle(.gray)
                    .offset(x: -130)
                    .offset(y: -60)
                VStack(spacing: 30){
                    
                    ForEach(Array(selectedDays).sorted(), id:
                                \.self){selectedDay in
                        HStack(alignment: .center){
                            Text(Days[selectedDay].prefix(3))
                                .offset(x: 50)
                                .font(.system(size: 25))
                                .frame(width: 50, alignment: .leading)
                            TextField("00:00", text: $toThrow)
                                .offset(x: 70)
                                .font(.system(size: 30))
                            TextField("00:00", text: $toThrow)
                                .offset(x:40)
                                .font(.system(size: 30))
                        }
                        
                    }
                }

                Button{
                    info.Gender = Sex
                    info.target = targ
                    info.prev = prev
                    info.Goals = Goals
                    info.Age = age
                    
                    dismiss()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.green))
                            .frame(width: 70, height: 50)
                        Text("Done")
                            .foregroundStyle(.white)
                    }
                }
                .offset(y: 0)
            }
        }
    }
}

#Preview {
    Goal_Page(info: .constant(data(Age: 0, Gender: false, prev: [], target: [], schedule: [], NAPHA_Date: Date.now, Goals: [])))
}
