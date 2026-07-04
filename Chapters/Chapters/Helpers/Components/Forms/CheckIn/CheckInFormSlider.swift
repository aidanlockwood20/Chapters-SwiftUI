import SwiftUI

struct CheckInFormSlider: View {
    
    @Binding var sliderValue: Double
    
    let sliderDescription: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(sliderDescription)
            VStack(alignment: .trailing) {
                HStack {
                    Text("(0-10)")
                    Spacer()
                    Text(String(format: "%.1f", sliderValue))
                }
                Slider(value: $sliderValue, in: 1...10)
            }
        }
    }
}
