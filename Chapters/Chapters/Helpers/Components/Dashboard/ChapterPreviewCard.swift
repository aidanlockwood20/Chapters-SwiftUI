import SwiftUI

struct ChapterPreviewCard: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    let chapter: Chapter
    
    var body: some View {
        @Bindable var dashboardVM = dashboardViewModel
        
        Button(action: {
            dashboardViewModel.displayChapterSheet = chapter
        }, label: {
            VStack {
                Image(systemName: "photo.fill")
                Spacer()
                Text("Chapter Title")
                    .font(.title2)
            }
            .padding(.vertical, 20)
        })
        .chapterPreviewCard()
        .padding(.trailing)
        .sheet(item: $dashboardVM.displayChapterSheet) {
            ChapterDetailView(chapter: $0)
        }
    }
}
