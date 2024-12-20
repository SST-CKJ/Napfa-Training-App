//  Home.swift
//  Napha Training App
//
//  Created by Kui Jun on 24/6/24.
//

import SwiftUI
import UserNotifications


struct Home: View {
    @StateObject var info: dataViewModel
   // @Binding var info: data
    @State var prevWorkout = UserDefaults.standard.string(forKey: "prevWorkout") ?? ""
    @State var combined: Date = Date()
    @State private var exercises = ["Sit Ups", "Standing Broad Jump", "Sit & Reach", "Inclined Pull Ups", "Shuttle Run", "2.4km Run"]
    @State var sent_before = false
    @State private var Goalindx = 0
    @Binding var homeSelectedTimed: [Date]
    @State var DayIndex = Calendar.current.component(.weekday, from: Date())
    @Binding var homeSelectedDays: [Int]
    @State var timeUntilNextWorkout: DateComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: Date())
    @State var daySelected: Bool = false
    @State var selectedDayComponent = Date()
    @State var datesButToday: [Date] = []
    @State var resultFromFunction: Int = 0
    @State var nextWorkoutComponents = Calendar.current.dateComponents([.hour, .minute], from: Date())
    @State var notificationAuthorized: Bool = false
    var todayComponents: DateComponents {
        Calendar.current.dateComponents([.year, .month, .day], from: Date())
    }
    @State var combinedComponents = DateComponents()
    var adjustedDates: [Date] {
        let calendar = Calendar.current
        let todayComponents = self.todayComponents
        
        return homeSelectedTimed.map { date in
            
            
            var newComponents = DateComponents()
            newComponents.year = todayComponents.year
            newComponents.month = todayComponents.month
            newComponents.day = todayComponents.day
            
            return calendar.date(from: newComponents) ?? date
        }
    }

    
    @State var dayNum: Int = (Calendar.current.component(.weekday, from: Date())+5) % 7 + 1
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    @State var zippedTimeDay: [(Int,Date)] = []
    @State var sortedDays: [Int] = []
    @State var sortedTimes: [Date] = []
    @State var nextWorkout: Date = Date()
    
    var body: some View {
        NavigationStack{
            VStack{
                /* ForEach(sortedTimes, id: \.self){ i in
                 Text(dateFormatter.string(from: i))
                 //used for testing, remove later
                 }
                 ForEach(sortedDays, id: \.self){i in
                 Text((String(i+1)))
                 
                 }*/
                Text("NAPFA EXAMINATION IN")
                    .font(.system(size: 20))
                    .bold()

                    .offset(y: 100)
                
                Text("\(info.info_object.NAPFA_Date.formatted(date: .long, time: .omitted))")
                    .font(.system(size: 45))
                    .bold()
                    .offset(y: 100)
                    .contextMenu{
                        Text("\(Calendar.current.dateComponents([.month,.day], from: Date.now, to: info.info_object.NAPFA_Date).month ?? 0) months : \(Calendar.current.dateComponents([.month,.day], from: Date.now, to: info.info_object.NAPFA_Date).day ?? 0) days")
                    }
                Text("Note: This is an MVP")
                    .offset(y:100)
                Grid{
                    GridRow{
                        ZStack{
                            RoundedRectangle(cornerRadius: 25.0)
                                .frame(width: 170,height: 200)
                                .foregroundColor(.yellow)
                            if(prevWorkout == ""){
                                Text("\(prevWorkout == "" ? "You havent worked out yet" : prevWorkout)")
                                    .padding()
                            }
                            else{
                                Image("\(prevWorkout)")
                            }
                        }
                        .gridColumnAlignment(.trailing)
                        .offset(x: 270, y: -100)
                        
                        ZStack{
                            Image("Calendar")
                                .scaledToFit()
                                .scaleEffect(0.25)
                        
                            if let day = timeUntilNextWorkout.day, day > 0 {
                                if day > 1 {
                                    HStack {
                                        Spacer()
                                        Text(String(day) + " days")
                                            .font(.system(size: 30))
                                            .bold()
                                        Spacer()
                                    }
                                    .contextMenu(ContextMenu(menuItems: {
                                        Text(dateFormatter.string(from: combined))
                                    }))
                                } else {
                                    HStack {
                                        Spacer()
                                        Text(String(day) + " day")
                                            .font(.system(size: 30))
                                            .bold()
                                        Spacer()
                                    }
                                    .contextMenu(ContextMenu(menuItems: {
                                        Text(dateFormatter.string(from: combined))
                                    }))
                                }
                            } else if let hours = timeUntilNextWorkout.hour, hours > 0 {
                                if hours > 1 {
                                    HStack {
                                        Spacer()
                                        
                                        Text(String(hours) + " hours")
                                            .font(.system(size: 30))
                                            .bold()
                                        Spacer()
                                    }
                                            .contextMenu(ContextMenu(menuItems: {
                                                Text(dateFormatter.string(from: combined))
                                            }))
                                    
                                } else {
                                    HStack {
                                        Spacer()
                                        
                                        Text(String(hours) + " hour")
                                            .font(.system(size: 30))
                                            .bold()
                                        Spacer()
                                    }
                                            .contextMenu(ContextMenu(menuItems: {
                                                Text(dateFormatter.string(from: combined))
                                            }))
                                }
                            } else if let minute = timeUntilNextWorkout.minute, minute > 0 {
                                HStack {
                                    Spacer()
                                    Text(String(minute) + " minutes")
                                        .font(.system(size: 30))
                                        .bold()
                                    Spacer()
                                }
                                    .contextMenu(ContextMenu(menuItems: {
                                        Text(dateFormatter.string(from: combined))
                                    }))
                            } else {
                                Text("Your \nworkout is \nnow!")
                                    .offset(y: 10)
                                    .font(.system(size: 30))
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .contextMenu(ContextMenu(menuItems: {
                                        Text(dateFormatter.string(from: combined))
                                    }))
                            }
                        }
                        .gridColumnAlignment(.leading)
                        .offset(y: -100)
                    }
                }
                // Logic to check minutes first (more errors)
//                if let minute = timeUntilNextWorkout.minute, minute > 0 {
//                    HStack {
//                        Spacer()
//                        Text(String(minute) + " minutes")
//                            .font(.system(size: 30))
//                            .bold()
//                        Spacer()
//                    }
//                    .contextMenu(ContextMenu(menuItems: {
//                        Text(dateFormatter.string(from: combined))
//                    }))
//                }  else if let hours = timeUntilNextWorkout.hour, hours > 0 {
//                    if hours > 1 {
//                        HStack {
//                            Spacer()
//                            
//                            Text(String(hours) + " hours")
//                                .font(.system(size: 30))
//                                .bold()
//                            Spacer()
//                        }
//                        .contextMenu(ContextMenu(menuItems: {
//                            Text(dateFormatter.string(from: combined))
//                        }))
//                        
//                    } else {
//                        HStack {
//                            Spacer()
//                            
//                            Text(String(hours) + " hour")
//                                .font(.system(size: 30))
//                                .bold()
//                            Spacer()
//                        }
//                        .contextMenu(ContextMenu(menuItems: {
//                            Text(dateFormatter.string(from: combined))
//                        }))
//                    }
//                } else if let day = timeUntilNextWorkout.day, day > 0 {
//                        if day > 1 {
//                            HStack {
//                                Spacer()
//                                Text(String(day) + " days")
//                                    .font(.system(size: 30))
//                                    .bold()
//                                Spacer()
//                            }
//                            .contextMenu(ContextMenu(menuItems: {
//                                Text(dateFormatter.string(from: combined))
//                            }))
//                        } else {
//                            HStack {
//                                Spacer()
//                                Text(String(day) + " day")
//                                    .font(.system(size: 30))
//                                    .bold()
//                                Spacer()
//                            }
//                            .contextMenu(ContextMenu(menuItems: {
//                                Text(dateFormatter.string(from: combined))
//                            }))
//                            
//                        }
//                    } else {
//                        Text("Your \nworkout is \nnow!")
//                            .offset(y: 10)
//                            .font(.system(size: 30))
//                            .bold()
//                            .multilineTextAlignment(.center)
//                            .contextMenu(ContextMenu(menuItems: {
//                                Text(dateFormatter.string(from: combined))
//                            }))
//                    }
//            } .gridColumnAlignment(.leading)
//                    .offset(y: -100)

                Button{
                    if info.info_object.Goals != []{
                        if (Goalindx == info.info_object.Goals.count - 1){
                            Goalindx = 0
                        }
                        else{
                            Goalindx += 1
                        }
                    }
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 40)
                            .fill(.blue)
                         
                            .frame(width: 350, height: 120)
                            .offset(y: 56)
                            
                        Text(info.info_object.Goals == [] ? "You dont have any goals yet.\nGo to Settings > Goal Page\nto set some!" :"I will get\n\(info.info_object.Goals[Goalindx][0])\nfor \(info.info_object.Goals[Goalindx][1])")
                            .font(.system(size: info.info_object.Goals == [] ? 20 : 20))
                            .foregroundStyle(.white)
                            .offset(y: 50)
                    }
                }
                .offset(y: -450)
                
            }
            .offset(y: 100)
        }
        .onAppear{
            if let storedDate = UserDefaults.standard.object(forKey: "nextWorkout") as? Date {
                nextWorkout = storedDate
            }
            print(nextWorkout)

            
            

           
            
            /*daySelected = false
             for i in homeSelectedDays{
             if daySelected == false {
             if Int(Calendar.current.weekdaySymbols[DayIndex]) == Int(i) {
             selectedDayComponent =  homeSelectedTimed[homeSelectedDays.firstIndex(of: Int(i))!]
             
             }
             }*/
            
            zippedTimeDay = zip(homeSelectedDays,homeSelectedTimed).sorted{ $0.0 < $1.0}
            print("homeSelectedDays:",homeSelectedDays,"homeSelectedTimed:",homeSelectedTimed)
            sortedDays = zippedTimeDay.map { $0.0 }
            sortedTimes = zippedTimeDay.map { $0.1 }
            dayNum = (Calendar.current.component(.weekday, from: Date())+5) % 7
            print("the day number is:",dayNum)
            print("zipeed: \(zippedTimeDay)")
            print("current date",Date())
            if sortedTimes.isEmpty == false {
                if sortedDays.contains(dayNum) {
                    print("Next workout is today")
                    //Checking if workout has already occured today
                    print()
                    if sortedTimes[sortedDays.firstIndex(of: dayNum)!] > Date() {
                        print("time of next workout",sortedTimes[sortedDays.firstIndex(of: dayNum)!])
                        print("next workout has occured already")

                        resultFromFunction = sortedDays.firstIndex(of: dayNum)!
                    } else {
                        print("next workout not yet")
                        resultFromFunction = sortedDays.firstIndex(of: dayNum)!+1
                        print("time of next workout",sortedTimes[sortedDays.firstIndex(of: dayNum)!])
                        
                        //Error here I think
                    }
                    
                } else {
                    var newSortedDays: [Int] = sortedDays.map { $0 }
                    newSortedDays.append(dayNum)
                    newSortedDays.sort()
                    if newSortedDays.last == dayNum {
                        resultFromFunction = 0
                        
                    } else {
                        resultFromFunction = newSortedDays.firstIndex(of: dayNum)!
                    }
                }
            }
            print("sortedTimes HAHA",sortedTimes)
            if sortedTimes.isEmpty == false {
                nextWorkout = sortedTimes[resultFromFunction]
                //Note: result from function denotes the position of the time for nextWorkout
                 nextWorkoutComponents = Calendar.current.dateComponents([.hour, .minute], from: nextWorkout)
                
                let todayComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
                let comparingComponents = Calendar.current.dateComponents([.hour, .minute, .year, .month, .day], from: Date())
                
                combinedComponents = DateComponents()
                combinedComponents.hour = nextWorkoutComponents.hour
                combinedComponents.minute = nextWorkoutComponents.minute
                combinedComponents.day = todayComponents.day
                let dayOffset = sortedDays[resultFromFunction] - dayNum
                combinedComponents.day = todayComponents.day! + dayOffset
                combinedComponents.day! = todayComponents.day! + dayOffset
                
                combinedComponents.month = todayComponents.month
                combinedComponents.year = todayComponents.year
                combined = Calendar.current.date(from: combinedComponents)!
                
                if (Date()>combined){
                    print("going route 1")
                    nextWorkoutComponents.year = todayComponents.year
                    nextWorkoutComponents.month = todayComponents.month
                    combinedComponents.day = todayComponents.day! + sortedDays[resultFromFunction]+7 - dayNum
                    combined = Calendar.current.date(from: combinedComponents)!
                    nextWorkout = Calendar.current.date(from: nextWorkoutComponents)!
                } else {
                    print("going route 2")
                    
                    nextWorkoutComponents.year = todayComponents.year
                    nextWorkoutComponents.month = todayComponents.month
                    nextWorkoutComponents.day = todayComponents.day! + sortedDays[resultFromFunction]+1 - dayNum
                    nextWorkout = Calendar.current.date(from: nextWorkoutComponents)!
                    
                }
                
                print("selected Days: \(homeSelectedDays)")
            }
            timeUntilNextWorkout = Calendar.current.dateComponents([.day, .hour, .minute], from: Date(), to: nextWorkout)
            print("nextWorkout \(nextWorkout)")
                UserDefaults.standard.setValue(nextWorkout, forKey: "nextWorkout")
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted {
                       let content = UNMutableNotificationContent()
                       content.title = "Time for your workout"
                       content.subtitle = "Exercise now!"
                       content.sound = UNNotificationSound.default
                       
                       // 1 hour before
                       var oneHourBeforeComponents = nextWorkoutComponents
                        oneHourBeforeComponents.hour! -= 1
                       let oneHourBeforeTrigger = UNCalendarNotificationTrigger(dateMatching: oneHourBeforeComponents, repeats: true)
                       let oneHourBeforeRequest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: oneHourBeforeTrigger)
                       
                       // 10 minutes before
                       var tenMinutesBeforeComponents = nextWorkoutComponents
                        tenMinutesBeforeComponents.minute! -= 10
                       let tenMinutesBeforeTrigger = UNCalendarNotificationTrigger(dateMatching: tenMinutesBeforeComponents, repeats: true)
                       let tenMinutesBeforeRequest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: tenMinutesBeforeTrigger)
                       
                       // 0 minutes before
                       let zeroMinutesBeforeTrigger = UNCalendarNotificationTrigger(dateMatching: nextWorkoutComponents, repeats: true)
                       let zeroMinutesBeforeRequest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: zeroMinutesBeforeTrigger)
                       
                       UNUserNotificationCenter.current().add(oneHourBeforeRequest)
                       UNUserNotificationCenter.current().add(tenMinutesBeforeRequest)
                       UNUserNotificationCenter.current().add(zeroMinutesBeforeRequest)
                       
                       print("notifications sent")
                   } else {
                       print("Notification authorization denied")
                   }
                }
            }
        }
}



#Preview {
    Home(info: dataViewModel(), homeSelectedTimed: .constant([]), homeSelectedDays: .constant([]))
}
