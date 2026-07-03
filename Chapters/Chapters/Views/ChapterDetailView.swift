import SwiftUI

struct ChapterDetailView: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    @Environment(ChapterViewModel.self) private var chapterViewModel
    
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
