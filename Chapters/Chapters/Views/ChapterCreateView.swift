import SwiftUI

struct ChapterCreateView: View {
    @Environment(ChapterViewModel.self) private var chapterViewModel
    @Environment(\.dismiss) private var dismiss

    let onChapterCreated: (Chapter) -> Void

    init(onChapterCreated: @escaping (Chapter) -> Void = { _ in }) {
        self.onChapterCreated = onChapterCreated
    }

    var body: some View {
        AppBackgroundContainer {
            NavigationStack {
                ChapterCreateForm(onChapterCreated: onChapterCreated)
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
