import SwiftUI

func convertTemperature(value: Double, from fromUnit: String, to toUnit: String) -> Double {
    switch (fromUnit, toUnit) {
    case ("ºC", "ºF"):
        return value * 9 / 5 + 32
    case ("ºF", "ºC"):
        return (value - 32) * 5 / 9
    case ("ºC", "ºK"):
        return value + 273.15
    case ("ºK", "ºC"):
        return value - 273.15
    case ("ºF", "ºK"):
        let celsius = (value - 32) * 5 / 9
        return celsius + 273.15
    case ("ºK", "ºF"):
        let celsius = value - 273.15
        return celsius * 9 / 5 + 32
    default:
        return value
    }
}

struct ContentView: View {
    @State private var firstUnit = "ºF"
    @State private var firstNum = 0.0
    @State private var secondUnit = "ºC"
    @FocusState private var amountIsFocused: Bool
    let units = ["ºF", "ºC", "ºK"]
    
    var convertedValue: Double {
        convertTemperature(value: firstNum, from: firstUnit, to: secondUnit)
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                Section("Enter Your Starting Unit") {
                    Picker("Select Unit", selection: $firstUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    TextField("Enter number", text: Binding<String>(
                        get: { String(format: "%.2f", self.firstNum) },
                        set: { self.firstNum = Double($0) ?? 0 }
                        
                    ))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                }
                Section("Enter Your Second Unit"){
                    Picker("Select Unit", selection: $secondUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("\(String(format: "%.2f", firstNum))\(firstUnit) is equal to \(String(format: "%.2f", convertedValue))\(secondUnit)")
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
