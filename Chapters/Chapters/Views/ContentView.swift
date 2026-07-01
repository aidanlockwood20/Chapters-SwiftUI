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
            .navigationDestination(for: Chapter.self) { chapter in
                ChapterDetailView(chapter: chapter)
            }
            .scrollClipDisabled()
            .navigationDestination(for: Chapter.self) { chapter in
                ChapterDetailView(chapter: chapter)
            }
            .navigationDestination(for: DashboardNav.self) { route in
                AppBackgroundContainer {
                    switch route {
                    case .main:
                        DashboardView()
                    case .chapters:
                        ChapterListView()
                    case .stats:
                        UserStatsListView()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
        .environment(DashboardViewModel())
}
