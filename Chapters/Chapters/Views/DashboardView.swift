import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    var body: some View {
        @Bindable var dashboardVM = dashboardViewModel
        
        ScrollView {
            PageTitle()
            LogCheckInCard()
            RecentCheckIns()
            RecentChapters()
            UserStats()
        }
        .scrollClipDisabled()
        .padding(.top, 24)
        .padding(.horizontal, 12)
        .mainToolbar()
        .sheet(isPresented: $dashboardVM.displayChapterCreateSheet) {
            ChapterCreateView()
        }
        .sheetViews()
    }
}

#Preview("Main View") {
    ContentView()
        .modelContainer(previewContainer)
        .withPreviewEnvironment()
}
