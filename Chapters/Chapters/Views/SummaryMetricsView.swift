import SwiftUI

struct SummaryMetricsView: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel

    let metric: DashboardMetrics
    
    var body: some View {
        NavigationStack {
            AppBackgroundContainer {
                Text("Summary Metrics View for: \(metric.displayName)")
                    .closeSheetToolbar {
                        dashboardViewModel.displayMetricsSheet = nil
                    }
            }
        }
    }
}
