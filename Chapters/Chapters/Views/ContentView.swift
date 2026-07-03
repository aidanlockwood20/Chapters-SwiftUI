import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    var body: some View {
        @Bindable var dashboardVM = dashboardViewModel
        
        NavigationStack(path: $dashboardVM.navigationPath) {
            AppBackgroundContainer {
                DashboardView()
            }
            .scrollClipDisabled()
            .navDestinations()
        }
    }
}

#Preview {
    let context = ModelContext(previewContainer)
    let checkInViewModel = CheckInViewModel(modelContext: context)
    
    ContentView()
        .modelContainer(previewContainer)
        .environment(DashboardViewModel())
        .environment(checkInViewModel)
        .environment(ChapterViewModel())
        .environment(MetricsViewModel())
        .environment(SettingsViewModel())
}
