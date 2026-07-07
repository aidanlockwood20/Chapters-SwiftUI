import SwiftUI

struct MoodSection: View {
    @Environment(CheckInViewModel.self) private var checkInViewModel

    var body: some View {
        @Bindable var checkInVM = checkInViewModel

        CheckInSectionCard(title: "Mood") {
            VStack(alignment: .leading) {
                CheckInFormSlider(sliderValue: $checkInVM.checkInInstance.moodScore, sliderDescription: "How would you describe your mood?")
                HStack {
                    Text("How would you best describe it?")
                    Spacer()
                    Picker("Best word to describe it?", selection: $checkInVM.checkInInstance.moodLabel) {
                        Text("-------").tag(nil as MoodSelection?)
                        ForEach(MoodSelection.allCases) { mood in
                            Text(mood.displayValue).tag(mood)
                        }
                    }
                }
            }
            .onChange(of: checkInVM.checkInInstance.moodLabel) {
                checkInViewModel.clearValidationMessage()
            }
        }
    }
}

#Preview {
    MoodSection()
        .withPreviewEnvironment()
}
