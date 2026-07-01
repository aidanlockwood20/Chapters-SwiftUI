import SwiftUI

struct RecoverySection: View {
    
    @Binding var checkInInput: CheckInInput
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                CheckInFormCardTitle(cardTitle: "Recovery")
                CheckInFormSlider(sliderValue: $checkInInput.energyLevel, sliderDescription: "How would you rate your Energy Level")
                .padding(.bottom, 8)
                CheckInFormSlider(sliderValue: $checkInInput.sleepQuality, sliderDescription: "How would you rate your Sleep Quality?")
            }
            .padding(20)
        }
        .logCheckInCardStyle(horizontalPadding: 0)
        .padding(.bottom, 16)
    }
}
