import SwiftUI

struct RecoverySection: View {
    @Environment(CheckInViewModel.self) private var checkInViewModel
        
    var body: some View {
        @Bindable var checkInVM = checkInViewModel
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                CheckInFormCardTitle(cardTitle: "Recovery")
                CheckInFormSlider(sliderValue: $checkInVM.checkInInstance.energyLevel, sliderDescription: "How would you rate your Energy Level")
                .padding(.bottom, 8)
                CheckInFormSlider(sliderValue: $checkInVM.checkInInstance.sleepQuality, sliderDescription: "How would you rate your Sleep Quality?")
            }
            .padding(20)
        }
        .logCheckInCardStyle(horizontalPadding: 0)
        .padding(.bottom, 16)
    }
}
