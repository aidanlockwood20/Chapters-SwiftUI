import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    var body: some View {
        @Bindable var dashboardVM = dashboardViewModel
        
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
        .sheet(isPresented: $dashboardVM.displayAccountSettings) {
            AccountSettingsView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
        .environment(DashboardViewModel())
}
