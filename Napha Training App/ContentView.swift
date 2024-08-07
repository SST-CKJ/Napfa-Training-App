import SwiftUI
import AVFoundation

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
    var target: [String]
    var schedule: [String]
    var NAPHA_Date: Date
    var Goals: [[String]]
    
    init(Age: Int, Gender: Bool, prev: [String], target: [String], schedule: [String], NAPHA_Date: Date, Goals: [[String]]) {
        self.Age = Age
        self.Gender = Gender
        self.prev = prev
        self.target = target
        self.schedule = schedule
        self.NAPHA_Date = NAPHA_Date
        self.Goals = Goals
    }
    
//    init(from decoder:  Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.Age = try container.decode(Float.self, forKey: .Age)
//        self.Gender = try container.decode(Bool.self, forKey: .Gender)
//        self.prev = try container.decode(Array.self, forKey: .prev)
//        self.target = try container.decode(Array.self, forKey: .target)
//        self.schedule = try container.decode(Array.self, forKey: .schedule)
//        self.NAPHA_Date = try container.decode(Date.self, forKey: .NAPHA_Date)
//    }
}

struct ContentView: View {

    @State var info = data(Age: 12, Gender: false, prev: [], target: [], schedule: [], NAPHA_Date: Date.now, Goals: [])
    @State var selectedTimesCV: [Date] = []
    @State var selectedDaysCV: [Int] = []
    @State var Sex: Bool = true
    @State var age: Int = 12
    var body: some View {
        TabView{
            Home(info: $info, homeSelectedTimed: $selectedTimesCV, homeSelectedDays: $selectedDaysCV)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            Text("")
            Settings(info: $info, selectedTimedSettings: $selectedTimesCV, selectedDaysSettings: $selectedDaysCV, Sex: $Sex, age: $age)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .preferredColorScheme(.light)
    }

}
    
#Preview {
    ContentView()
}
