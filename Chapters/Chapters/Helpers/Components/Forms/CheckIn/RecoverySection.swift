import SwiftUI

struct RecoverySection: View {
    @Environment(CheckInViewModel.self) private var checkInViewModel
        
    var body: some View {
        @Bindable var checkInVM = checkInViewModel
        
        CheckInSectionCard(title: "Recovery") {
            CheckInFormSlider(sliderValue: $checkInVM.checkInInstance.energyLevel, sliderDescription: "How would you rate your Energy Level")
            .padding(.bottom, 8)
            CheckInFormSlider(sliderValue: $checkInVM.checkInInstance.sleepQuality, sliderDescription: "How would you rate your Sleep Quality?")
        }
    }
}
