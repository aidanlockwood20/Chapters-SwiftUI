import SwiftUI

struct SummaryMetricsView: View {
    
    let metric: DashboardMetrics
    
    var body: some View {
        Text("Summary Metrics View for: \(metric.displayName)")
    }
}
