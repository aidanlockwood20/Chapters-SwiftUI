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

#Preview("Main View"){
    ContentView()
        .modelContainer(previewContainer)
        .withPreviewEnvironment()
}
