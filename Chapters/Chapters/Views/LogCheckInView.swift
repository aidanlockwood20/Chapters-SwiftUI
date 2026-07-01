import SwiftUI
import SwiftData

struct LogCheckInView: View {
    
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    var body: some View {
        NavigationStack {
            CheckInForm()
                .closeSheetToolbar(action: {
                    dashboardViewModel.displayCheckInSheet.toggle()
                })
        }
    }
}

#Preview {
    CheckInForm()
        .modelContainer(previewContainer)
        .environment(DashboardViewModel())
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
        .environment(DashboardViewModel())
}
