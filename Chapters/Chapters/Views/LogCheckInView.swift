import SwiftUI
import SwiftData

struct LogCheckInView: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    @Environment(CheckInViewModel.self) private var checkInViewModel
    
    var body: some View {
        @Bindable var dashboardVM = dashboardViewModel
        
        NavigationStack {
            CheckInForm(onSaveComplete: dismissSheet)
                .closeSheetToolbar(isDisabled: checkInViewModel.isSaving) {
                    dismissSheet()
                }
                .sheet(isPresented: $dashboardVM.displayChapterCreateSheet) {
                    ChapterCreateView()
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
        .withPreviewEnvironment()
}

#Preview("Content View") {
    ContentView()
        .modelContainer(previewContainer)
        .withPreviewEnvironment()
}
