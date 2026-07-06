import SwiftUI

struct ChapterCreateView: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    var body: some View {
        AppBackgroundContainer {
            NavigationStack {
                Text("Chapter Create View")
                    .closeSheetToolbar {
                        dashboardViewModel.displayChapterCreateSheet.toggle()
                    }
            }
        }
    }
}
