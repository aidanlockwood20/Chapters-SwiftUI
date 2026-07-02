import SwiftUI

struct AccountSettingsView: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    var body: some View {
        NavigationStack {
            Text("Account Settings View")
                .closeSheetToolbar {
                    dashboardViewModel.displayAccountSettings.toggle()
                }
        }
    }
}
