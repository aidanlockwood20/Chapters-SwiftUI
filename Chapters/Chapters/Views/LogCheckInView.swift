import SwiftUI
import SwiftData

struct LogCheckInView: View {
    
    var body: some View {
        CheckInForm()
    }
}

#Preview {
    CheckInForm()
        .modelContainer(previewContainer)
}
