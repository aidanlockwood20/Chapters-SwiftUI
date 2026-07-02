import SwiftUI
import SwiftData

struct DashboardView: View {
    
    var body: some View {
        ScrollView {
            PageTitle()
            LogCheckInCard()
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

#Preview {
    ContentView()
        .modelContainer(previewContainer)
        .environment(DashboardViewModel())
}
