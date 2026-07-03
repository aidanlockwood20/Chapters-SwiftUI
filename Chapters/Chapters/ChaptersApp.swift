import SwiftUI
import SwiftData

@main
struct ChaptersApp: App {
    
    @State private var dashboardViewModel = DashboardViewModel()
    @State private var chapterViewModel = ChapterViewModel()
    @State private var checkInViewModel = CheckInViewModel(modelContext: ModelContext(previewContainer))
    @State private var metricsViewModel = MetricsViewModel()
    @State private var settingsViewModel = SettingsViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(previewContainer)
                .environment(dashboardViewModel)
                .environment(chapterViewModel)
                .environment(checkInViewModel)
                .environment(metricsViewModel)
        }
        
    }
}
