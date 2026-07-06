import SwiftUI
import SwiftData

extension View {
    func withPreviewEnvironment() -> some View {
        
        let context = ModelContext(previewContainer)
        
        let checkInViewModel = CheckInViewModel(modelContext: context)
        let dashboardViewModel = DashboardViewModel()
        let chapterViewModel = ChapterViewModel(modelContext: context)
        let metricsViewModel = MetricsViewModel()
        let settingsViewModel = SettingsViewModel()
        
        return self
            .environment(dashboardViewModel)
            .environment(chapterViewModel)
            .environment(checkInViewModel)
            .environment(metricsViewModel)
            .environment(settingsViewModel)
    }
}
