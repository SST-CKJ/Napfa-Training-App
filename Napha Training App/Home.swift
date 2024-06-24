//
//  Home.swift
//  Napha Training App
//
//  Created by Kui Jun on 24/6/24.
//

import SwiftUI

struct Home: View {
    
    @Binding var info: data
    @State private var exercises = ["Sit Ups", "Standing Broad Jump", "Sit & Reach", "Inclined Pull Ups", "Shuttle Run", "2.4km Run"]
    @State private var Goalindx = 0
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("NAPFA EXAMINATION IN")
                    .font(.system(size: 20))
                    .bold()
                Text("\(info.NAPHA_Date.formatted(date: .long, time: .omitted))")
                    .font(.system(size: 45))
                    .bold()
                    .contextMenu{
                        Text("\(Calendar.current.dateComponents([.month,.day], from: Date.now, to: info.NAPHA_Date).month ?? 0) months : \(Calendar.current.dateComponents([.month,.day], from: Date.now, to: info.NAPHA_Date).day ?? 0) days")
                    }
                Grid{
                    GridRow{
                        ZStack{
                            RoundedRectangle(cornerRadius: 25.0)
                                .frame(width: 150,height: 200)
                                .foregroundColor(.yellow)
                            Text("Placeholder")
                        }
                        .gridColumnAlignment(.trailing)
                        .offset(x: 60)
                        
                        ZStack{
                            Image("Calendar")
                                .scaledToFit()
                                .scaleEffect(0.55)
                            Text("2")
                                .font(.system(size: 60))
                                .bold()
                        }
                        .gridColumnAlignment(.leading)
                    }
                }
                
                Button{
                    if info.Goals != []{
                        if (Goalindx == info.Goals.count - 1){
                            Goalindx = 0
                        }
                        else{
                            Goalindx += 1
                        }
                    }
                    print(Calendar.current.dateComponents([.month,.day], from: Date.now, to: info.NAPHA_Date))
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 40)
                            .fill(.blue)
                            .padding(.horizontal, 30)
                            .offset(y: 56)
                        
                        Text(info.Goals == [] ? "You dont have any goals yet.\nGo to Settings > Goal Page\nto set some!" :"I will get\n\(info.Goals[Goalindx][0])\nfor \(info.Goals[Goalindx][1])")
                            .font(.system(size: info.Goals == [] ? 20 : 30))
                            .foregroundStyle(.white)
                            .offset(y: 50)
                    }
                }
                .offset(y: -150)
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        
                    } label: {
                        Text("Workout Modifier")
                    }
                }
            }
        }
    }
}

#Preview {
    Home(info: .constant(data(Age: 0, Gender: false, prev: [], target: [], schedule: [], NAPHA_Date: Date.now, Goals: [])))
}
