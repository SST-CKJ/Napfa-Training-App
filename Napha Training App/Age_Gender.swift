import SwiftUI

struct Age_Gender: View {
    @Binding var start: Bool
    @StateObject var info = dataViewModel()
   // @Binding var info: data
    @State var Sex = true // Default to Male
    @State var birthdate = Date() // Default to today's date
    @Binding var ageFirstTime: Bool
    @Binding var ageSheet: Bool
    @State var GenderSheet = false
    @State private var selectedDate = Date()
    
    let baseStartYear = 2005
    let baseEndYear = 2012
    let calendar = Calendar.current
    @Environment(\.dismiss) private var dismiss
    func calculatedStartDate() -> Date {
        let currentYear = calendar.component(.year, from: Date())
        let shift = currentYear - 2024 // Calculate the difference between current year and 2024 (base year)
        
        // Start date: January 1st, 2005 + shift (if current year is 2024, shift is -1, so 2005 stays unchanged)
        return calendar.date(from: DateComponents(year: baseStartYear + shift, month: 1, day: 1)) ?? Date()
    }
    
    // Calculate the dynamic end date: December 31, 2012 shifted by the same year difference
    func calculatedEndDate() -> Date {
        let currentYear = calendar.component(.year, from: Date())
        let shift = currentYear - 2024 // Calculate the difference between current year and 2024
        
        // End date: December 31st, 2012 + shift
        return calendar.date(from: DateComponents(year: baseEndYear + shift, month: 12, day: 31)) ?? Date()
    }
    
    
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    var age: Int {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: birthdate, to: now)
        return ageComponents.year ?? 0
    }
    
    var body: some View {
          
        VStack(alignment:.leading) {
           
            Text("About Me")
                .font(.title)
                .bold()
                .padding(.bottom)
                .offset(x: 20)
                .offset(x: 10)
            
            Form {
                DatePicker("Birthdate", selection: $birthdate, in: calculatedStartDate()...calculatedEndDate(), displayedComponents: .date)
                    .onChange(of: birthdate) {
                        let calculatedAge = age
                        UserDefaults.standard.setValue(birthdate, forKey: "birthdate")
                        UserDefaults.standard.setValue(calculatedAge, forKey: "age")
                    }
                    .onAppear() { selectedDate = calculatedStartDate()}
                
                HStack() {
                    Text("Sex:")
                    Spacer()
                    Button(action: {
                        GenderSheet.toggle()
                    }) {
                        Text(info.info_object.Gender ? "Male" : "Female") // Display saved sex
                            .foregroundColor(.black)
                    }
                    .sheet(isPresented: $GenderSheet) {
                        GenderSelectionView(info: dataViewModel(), sex: $Sex)
                            .presentationDetents([.fraction(0.45)])
                            .presentationDragIndicator(.visible)
                    }
                    .labelsHidden()
                    .tint(.black)
                    .offset(x: -10)
                }
                
                if (!start) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Save")
                            .foregroundStyle(.blue)
                    }
                }
               
            }
            .onAppear {
                // Load stored data if it exists
                if let storedSex = UserDefaults.standard.object(forKey: "sex") as? Bool {
                    Sex = storedSex
                }
                if let storedBirthdate = UserDefaults.standard.object(forKey: "birthdate") as? Date {
                    birthdate = storedBirthdate
                }
                // Store birthdate and sex on appear
                UserDefaults.standard.setValue(birthdate, forKey: "birthdate")
                UserDefaults.standard.setValue(Sex, forKey: "sex")
                
                let calculatedAge = age
                UserDefaults.standard.setValue(calculatedAge, forKey: "age")
                print("Age: \(calculatedAge), Sex: \(Sex)")
            }
        }
    }
    
    struct GenderSelectionView: View {
        @StateObject var info = dataViewModel()
        @Environment(\.presentationMode) var presentationMode
        @State private var selectedGender: String? = "Male"
        @Binding var sex: Bool
        
        var body: some View {
            VStack {
                Text("Your sex")
                    .font(.headline)
                Divider()
                
                HStack {
                    GenderButton(gender: "Female", selectedGender: $selectedGender)
                        .onChange(of: selectedGender){
                            print(selectedGender ?? "none provided")
                            if selectedGender == "Female"{
                                sex = false
                                info.info_object.Gender = false
                                print("now female")
                            } else {
                                sex = true
                                info.info_object.Gender = true
                                print("now male")
                            }
                        }
                
                    GenderButton(gender: "Male", selectedGender: $selectedGender)
                        .onChange(of: selectedGender){
                            print(selectedGender ?? "none provided")
                            if selectedGender == "Female"{
                                sex = false
                                info.info_object.Gender = false
                                print("now female")
                            } else {
                                sex = true
                                info.info_object.Gender = true
                                print("now male")
                            }
                        }
                }
                .padding(.vertical)
                
                Button{
                    if selectedGender == "Male" {
                        info.info_object.Gender = true
                        sex = true
                    } else if selectedGender == "Female" {
                        info.info_object.Gender = false
                        sex = false
                    }
                    print(info.info_object.Gender)
                    
                } label: {
                }
                Button{
                    
                    presentationMode.wrappedValue.dismiss()
                    print(info.info_object.Gender)
                    
                } label: {
                    ZStack{
                        Text("Save")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .padding(.horizontal)
                            .padding(.bottom)
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(.horizontal)
                            .contentShape(Rectangle())
                        
                    }
                }
            }
        }
        
    }
}


struct GenderButton: View {
    var gender: String
    @Binding var selectedGender: String?
    
    var isSelected: Bool {
        selectedGender == gender
    }
    
    var body: some View {
        Button(action: {
            withAnimation {
                selectedGender = gender
            }
        }) {
            VStack {
                Image(systemName: isSelected ? "person.fill" : "person")
                    .font(.system(size: 40))
                    .foregroundColor(isSelected ? .white : .blue)
                
                Text(gender)
                    .font(.headline)
                    .foregroundColor(isSelected ? .white : .blue)
            }
            .padding()
            .frame(width: 155, height: 100)
            .background(isSelected ? Color.blue : Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 2)
            )
        }
    }
}

struct Age_Gender_Previews: PreviewProvider {
    static var previews: some View {


        Age_Gender(start: .constant(false), info: dataViewModel(), ageFirstTime: .constant(false), ageSheet: .constant(false))

    }
}
