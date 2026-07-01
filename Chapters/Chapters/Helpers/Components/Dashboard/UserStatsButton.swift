import SwiftUI

struct UserStatsButton: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    let metric: DashboardMetrics
    let metricStatus: String
    
    var body: some View {
        Button(action: {
            dashboardViewModel.displayMetricsSheet = metric
        }, label: {
            VStack {
                Text(metric.displayName)
                    .font(.subheadline)

                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 4)
                Text(metricStatus)
                    .font(.title2)
                    .bold()
            }
            .checkInCardTextStyle()
        })
        .userStatsCardStyle()
    }
}
