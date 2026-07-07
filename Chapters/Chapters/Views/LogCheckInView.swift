import SwiftUI
import SwiftData

struct LogCheckInView: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    @Environment(CheckInViewModel.self) private var checkInViewModel
    
    var body: some View {
        @Bindable var checkInVM = checkInViewModel
        
        NavigationStack {
            CheckInForm(onSaveComplete: dismissSheet)
                .closeSheetToolbar(isDisabled: checkInViewModel.isSaving) {
                    dismissSheet()
                }
                .sheet(isPresented: $checkInVM.displayChapterCreateSheet) {
                    ChapterCreateView(onChapterCreated: updateSelectedChapter)
                }
                .navigationTitle("Log Check In")
                .navigationBarTitleDisplayMode(.inline)
        }
        .interactiveDismissDisabled(checkInViewModel.isSaving)
    }

    private func dismissSheet() {
        checkInViewModel.checkInNavPath.removeAll()
        checkInViewModel.resetDraft()
        dashboardViewModel.displayCheckInSheet = false
    }

    private func updateSelectedChapter(_ chapter: Chapter) {
        checkInViewModel.checkInInstance.chapterSelectionID = chapter.id
        checkInViewModel.checkInInstance.chapterSelection = chapter
        checkInViewModel.selectedChapter = chapter
        checkInViewModel.displayChapterCreateSheet = false
        checkInViewModel.clearValidationMessage()
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
