import SwiftUI
import SwiftData

struct ChapterListView: View {
    @Query var chapters: [Chapter]
    
    var body: some View {
        VStack {
            
        }
        .navigationTitle("All Chapters")
    }
}
