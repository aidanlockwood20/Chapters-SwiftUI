import SwiftUI

struct CheckInNotesView: View {
    @Environment(CheckInViewModel.self) private var checkInViewModel
        
    var body: some View {
        @Bindable var checkInVM = checkInViewModel
        
        AppBackgroundContainer {
            TextEditor(text: $checkInVM.checkInInstance.diaryNotes)
                .scrollContentBackground(.hidden)
                .background(.backgroundColour)
                .padding(.horizontal, 12)
                .navigationTitle("Check in Notes")
        }
    }
}
