import SwiftUI
import Observation

@Observable
final class DashboardViewModel {
    var navigationPath: [DashboardNav] = []
    
    var displayCheckInSheet: Bool = false
    var displayChapterSheet: Chapter?
    var displayMetricsSheet: DashboardMetrics?
    
    func navTo(to toPath: DashboardNav) {
        navigationPath.append(toPath)
    }
    
    func goBack() {
        navigationPath.removeAll()
    }
}

