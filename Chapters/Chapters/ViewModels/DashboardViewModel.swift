import SwiftUI
import Observation

@Observable
final class DashboardViewModel {
    var navigationPath: [DashboardNav] = []
    
    var showCheckInDetailSheet: CheckIn?
    var displayCheckInSheet: Bool = false
    var displayChapterSheet: Chapter?
    var displayMetricsSheet: DashboardMetrics?
    var displayAccountSettings: Bool = false
    
    func navTo(to toPath: DashboardNav) {
        navigationPath.append(toPath)
    }
    
    func goBack() {
        navigationPath.removeAll()
    }
}

