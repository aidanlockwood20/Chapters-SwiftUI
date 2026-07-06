import SwiftUI
import SwiftData
import Observation

@Observable
final class ChapterViewModel {
    let modelContext: ModelContext
    
    var chapterInstance: ChapterInput = ChapterInput()
    var isSaving: Bool = false
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}
