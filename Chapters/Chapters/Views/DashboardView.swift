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
        .padding(.horizontal, 12)
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
        .environment(DashboardViewModel())
}
