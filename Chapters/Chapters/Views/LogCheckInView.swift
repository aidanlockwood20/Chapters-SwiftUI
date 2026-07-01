import SwiftUI
import SwiftData

struct LogCheckInView: View {
    
    var body: some View {
        CheckInForm( previewCheckInImage: UIImage(systemName: "person.fill")!)
    }
}

#Preview {
    CheckInForm(previewCheckInImage: UIImage(systemName: "person.fill")!)
        .modelContainer(previewContainer)
}
