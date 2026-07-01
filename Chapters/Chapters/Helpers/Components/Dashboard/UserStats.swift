import SwiftUI

struct UserStats: View {
    @Environment(\.colorScheme) private var colourScheme
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    var textColour: Color {
        return colourScheme == .dark ? .white : .black
    }
    
    var body: some View {
        @Bindable var dashboardVM = dashboardViewModel
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Button(action: {
                    dashboardViewModel.navTo(to: .stats)
                }, label: {
                    HStack {
                        Text("Your Stats")
                            .font(.title)
                            .foregroundStyle(textColour)
                            .bold()
                        Image(systemName: "chevron.right")
                            .bold()
                            .foregroundStyle(.textLowContrast)
                            .font(.title3)
                    }
                })
                Text("Last 7 days")
                    .font(.subheadline)
            }
            .padding(.bottom)
            Grid(horizontalSpacing: 32, verticalSpacing: 32){
                GridRow {
                    UserStatsButton(metric: DashboardMetrics.sleepQuality, metricStatus: "Good")
                    UserStatsButton(metric: DashboardMetrics.checkInStreak, metricStatus: "5 days")
                }
                GridRow {
                    UserStatsButton(metric: DashboardMetrics.avgMoodScore, metricStatus: "8")
                    UserStatsButton(metric: DashboardMetrics.avgEnergyLvl, metricStatus: "8")
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top)
        .sheet(item: $dashboardVM.displayMetricsSheet) { metric in
            SummaryMetricsView(metric: dashboardViewModel.displayMetricsSheet ?? .sleepQuality)
        }
    }
}
