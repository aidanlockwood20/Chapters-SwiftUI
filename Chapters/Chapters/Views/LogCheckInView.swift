import SwiftUI
import SwiftData

struct LogCheckInView: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    @Environment(CheckInViewModel.self) private var checkInViewModel
    
    var body: some View {
        NavigationStack {
            CheckInForm(onSaveComplete: dismissSheet)
                .closeSheetToolbar(isDisabled: checkInViewModel.isSaving) {
                    dismissSheet()
                }
        }
        .interactiveDismissDisabled(checkInViewModel.isSaving)
    }

    private func dismissSheet() {
        checkInViewModel.checkInNavPath.removeAll()
        dashboardViewModel.displayCheckInSheet = false
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
