import SwiftUI
import SwiftData

struct LogCheckInView: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    var body: some View {
        NavigationStack {
            CheckInForm()
                .closeSheetToolbar {
                    dashboardViewModel.displayCheckInSheet.toggle()
                }
        }
    }
}

#Preview("Check In Form") {
    let context = ModelContext(previewContainer)
    let checkInViewModel = CheckInViewModel(modelContext: context)
    
    CheckInForm()
        .modelContainer(previewContainer)
        .environment(DashboardViewModel())
        .environment(checkInViewModel)
}

#Preview("Content View") {
    ContentView()
        .modelContainer(previewContainer)
        .environment(DashboardViewModel())
}
