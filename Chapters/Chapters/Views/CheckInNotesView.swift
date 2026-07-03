import SwiftUI

struct CheckInNotesView: View {
    @Environment(CheckInViewModel.self) private var checkInViewModel
        
    var body: some View {
        @Bindable var checkInVM = checkInViewModel

        TextEditor(text: $checkInVM.checkInInstance.diaryNotes)
            .padding(.horizontal, 12)
            .navigationTitle("Check in Notes")
    }
}
