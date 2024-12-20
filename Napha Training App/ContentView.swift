import SwiftUI
import AVFoundation
import Combine

class SoundManager {
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "Alarm", withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error playing sound")
        }
    }
}

struct data{
    var Age: Int
    var Gender: Bool
    var prev: [String]
    var targ: [String]
    var schedule: [String]
    var NAPFA_Date: Date
    var Goals: [[String]]
    
    init(Age: Int, Gender: Bool, prev: [String], targ: [String], schedule: [String], NAPFA_Date: Date, Goals: [[String]]) {
        self.Age = Age
        self.Gender = Gender
        self.prev = prev
        self.targ = targ
        self.schedule = schedule
        self.NAPFA_Date = NAPFA_Date
        self.Goals = Goals
        
        UITabBar.appearance().isHidden = true
    }
}



class newData: ObservableObject{
    @Published var Age: Int
    @Published var Gender: Bool
    @Published var prev: [String]
    @Published var targ: [String]
    @Published var schedule: [String]
    @Published var NAPFA_Date: Date
    @Published var Goals: [[String]]
    
    init(Age: Int, Gender: Bool, prev: [String], targ: [String], schedule: [String], NAPFA_Date: Date, Goals: [[String]]) {
        self.Age = Age
        self.Gender = Gender
        self.prev = prev
        self.targ = targ
        self.schedule = schedule
        self.NAPFA_Date = NAPFA_Date
        self.Goals = Goals
        
        UITabBar.appearance().isHidden = true
    }
}
class dataViewModel: ObservableObject {
    @Published var info_object = newData(Age: 12, Gender: false, prev: ["","","","","",""], targ: ["","","","","",""], schedule: [], NAPFA_Date: Date.now, Goals: [])
}

struct ContentView: View {
    
    @State var info = data(Age: 12, Gender: false, prev: ["","","","","",""], targ: ["","","","","",""], schedule: [], NAPFA_Date: Date.now, Goals: [])
    @State var selectedTimesCV: [Date] = []
    @State var selectedDaysCV: [Int] = []
    @State var Sex: Bool = true
    @State var age: Int = 12
    @State var prevWorkout = ""
    @State var firstTime = true
    @State var GoalSheetCV = false
    @State var AgeSheetCV = false
    @State var SchedSheetCV = false
    @State var showLogin = false
    @State var selectedTab: Tab = .house
    @State var Startingpage = false
    var body: some View {
        
        if selectedTab == .house {
            Home(info: dataViewModel(), prevWorkout: prevWorkout, homeSelectedTimed: $selectedTimesCV, homeSelectedDays: $selectedDaysCV)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .fullScreenCover(isPresented: $showLogin){
                    StartingPage(info: dataViewModel(),ageFirstTime: $firstTime,ageSheet: $AgeSheetCV,Sex: $Sex,Age: $age,goalSheet: $GoalSheetCV,schedSheet: $SchedSheetCV, selectedDays: $selectedDaysCV,selectedTimes: $selectedTimesCV, showLogin: $showLogin)
                }
                .onChange(of: showLogin){
                    if showLogin == false {
                        firstTime = false
                        UserDefaults.standard.setValue(false, forKey: "fT")
                    }
                 }
            
        } else if selectedTab == .dumbbell{
            Workout(info: dataViewModel())
                .tabItem {
                    ZStack{
                        Circle()
                            .foregroundStyle(.blue)
                            .frame(width: 60,height: 60)
                        Image(systemName: "dumbbell.fill")
                            .scaleEffect(2)
                            .foregroundStyle(.white)
                        Text("Workout Now!")
                            .offset(y: 50)
                            .font(.system(size: 13))
                            .foregroundStyle(.black)
                    }
                }
        } else if selectedTab == .gearshape{
            Settings(info: dataViewModel(), GoalSheet: $GoalSheetCV, AgeSheet: $AgeSheetCV, SchedSheet: $SchedSheetCV, selectedTimedSettings: $selectedTimesCV, selectedDaysSettings: $selectedDaysCV, Sex: $Sex, age: $age, ftSettings: $firstTime)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        } else {
            Statistics()
                .tabItem{
                    Label("Statistics", systemImage: "chart.bar.fill")
                }
        }
        VStack{
            CustomTabBar(selectedTab: $selectedTab)

        } /* .fullScreenCover(isPresented: $Startingpage){ "eg for full screen thing
            StartingPage(info: $info, TabViewSheet: false, showNewView: false, nextAction: {}) */
        .onAppear{
            if let storedFirst = UserDefaults.standard.object(forKey: "fT") as? Bool {
                firstTime = storedFirst
                
            }
            if firstTime == true {
                showLogin = true
                UserDefaults.standard.set(Date.now, forKey: "DOWNLOADDATE")
                print("first time")
            }
            if let storedST = UserDefaults.standard.object(forKey: "ST") as? [Date]{
                selectedTimesCV = storedST
            }
            if let storedSD = UserDefaults.standard.object(forKey: "SD") as? [Int]{
                selectedDaysCV = storedSD
            }
            
            if let storedSex = UserDefaults.standard.object(forKey: "sex") as? Bool {
                info.Gender = storedSex
                
            }
            if let storedAge = UserDefaults.standard.object(forKey: "age") as? Int{
                info.Age = storedAge
            }
            if let storedNAPFA_Date = UserDefaults.standard.object(forKey: "NAPFA_Date") as? Date{
                info.NAPFA_Date = storedNAPFA_Date
            }
            //print((UserDefaults.standard.object(forKey: "DOWNlOADEDDATE") as? Date)!.formatted(date: .abbreviated, time: .standard))
        }
    }
}



#Preview {
    ContentView()
}
