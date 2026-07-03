import SwiftUI
import SwiftData

struct DashboardView: View {
    
    var body: some View {
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
        .sheetViews()
    }
}

#Preview("Main View") {
    ContentView()
        .modelContainer(previewContainer)
        .withPreviewEnvironment()
}
