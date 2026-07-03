import SwiftUI

struct AccountSettingsView: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    @Environment(SettingsViewModel.self) private var settingsViewModel;
    
    var body: some View {
        NavigationStack {
            AppBackgroundContainer {
                Text("Account Settings View")
                    .closeSheetToolbar {
                        dashboardViewModel.displayAccountSettings.toggle()
                    }
            }
        }
    }
}
