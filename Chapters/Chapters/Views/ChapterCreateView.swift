import SwiftUI

struct ChapterCreateView: View {
    @Environment(ChapterViewModel.self) private var chapterViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        AppBackgroundContainer {
            NavigationStack {
                ChapterCreateForm()
                    .closeSheetToolbar {
                        chapterViewModel.chapterInstance = ChapterInput()
                        dismiss()
                    }
            }
        }
    }
}

#Preview {
    
    ChapterCreateView()
        .withPreviewEnvironment()
}
