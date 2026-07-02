import SwiftUI

struct SheetViews: ViewModifier {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    func body(content: Content) -> some View {
        @Bindable var dashboardVM = dashboardViewModel
        
        content
            .sheet(isPresented: $dashboardVM.displayAccountSettings) {
                AccountSettingsView()
            }
            .sheet(item: $dashboardVM.displayChapterSheet) {
                ChapterDetailView(chapter: $0)
            }
            .sheet(isPresented: $dashboardVM.displayCheckInSheet) {
                LogCheckInView()
            }
            .sheet(item: $dashboardVM.displayMetricsSheet) { metric in
                SummaryMetricsView(metric: dashboardViewModel.displayMetricsSheet ?? .sleepQuality)
            }
    }
}
