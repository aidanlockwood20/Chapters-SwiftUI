import SwiftUI
import SwiftData
import Observation

@Observable
final class ChapterViewModel {
    let modelContext: ModelContext
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    var chapterInstance: ChapterInput = ChapterInput()
    
    var isSaving: Bool = false
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func saveChapter() async -> Bool {
        isSaving = true
        errorMessage = nil
        
        defer {
            isSaving = false
        }
        
        await Task.yield()
        
        let chapterRecord = Chapter(chapterPhoto: chapterInstance.chapterPhoto, title: chapterInstance.title, chapterDescription: chapterInstance.chapterDescription, startDate: chapterInstance.startDate, endDate: chapterInstance.endDate ?? Date(), dominantTags: "")
        
        modelContext.insert(chapterRecord)
        
        do {
            try modelContext.save()
            resetDraft()
            return true
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }        
    }
    
    func resetDraft() {
        chapterInstance = ChapterInput()
    }
}
