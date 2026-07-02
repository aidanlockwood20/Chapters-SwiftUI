import SwiftUI

struct CheckInNotesView: View {
    
    @Binding var checkInNotes: String
    
    var body: some View {
        TextEditor(text: $checkInNotes)
            .padding(.horizontal, 12)
            .navigationTitle("Check in Notes")
    }
}
