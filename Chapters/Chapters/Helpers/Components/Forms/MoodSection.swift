import SwiftUI

struct MoodSection: View {
    @Environment(CheckInViewModel.self) private var checkInViewModel
        
    var body: some View {
        @Bindable var checkInVM = checkInViewModel
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Mood")
                        .font(.title3)
                        .bold()
                }
                CheckInFormSlider(sliderValue: $checkInVM.checkInInstance.moodScore, sliderDescription: "How would you describe your mood?")
                HStack {
                    Text("How would you best describe it?")
                    Spacer()
                    Picker("Best word to describe it?", selection: $checkInVM.checkInInstance.moodLabel) {
                        ForEach(MoodSelection.allCases) { mood in
                            Text(mood.displayValue).tag(mood)
                        }
                    }
                }
            }
            .padding(20)
        }
        .logCheckInCardStyle(horizontalPadding: 0)
        .padding(.bottom, 16)
    }
}
