import SwiftUI

struct ChapterDetailView: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    let chapter: Chapter
    
    var body: some View {
        NavigationStack {
            AppBackgroundContainer {
                Text("Chapter Detail View")
                    .closeSheetToolbar {
                        dashboardViewModel.displayChapterSheet = nil
                    }
            }
        }
    }
}
