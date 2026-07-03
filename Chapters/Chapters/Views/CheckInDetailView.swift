import SwiftUI

struct CheckInDetailView: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    @Environment(CheckInViewModel.self) private var checkInViewModel
    
    let checkin: CheckIn
    
    var body: some View {
        NavigationStack {
            AppBackgroundContainer {
                Text("Check In Detail View")
                    .closeSheetToolbar {
                        dashboardViewModel.showCheckInDetailSheet = nil
                    }

            }
        }
    }
}
