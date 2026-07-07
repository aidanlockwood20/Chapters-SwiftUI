import SwiftUI
import SwiftData
import Observation

enum ChapterValidation: String, Hashable {
    case titleMissing
    case descriptionMissing

    var errorDescription: String {
        switch self {
        case .titleMissing:
            return "A title is required. Please add a title for this chapter."
        case .descriptionMissing:
            return "A description is required. Please add a description for this chapter."
        }
    }
}

@Observable
final class ChapterViewModel {
    let modelContext: ModelContext
    
    var isLoading: Bool = false
    var errorMessage: String?
    var validationMessage: ChapterValidation?
    
    var chapterInstance: ChapterInput = ChapterInput()
    
    var isSaving: Bool = false
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func saveChapter() async -> Chapter? {
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
            return chapterRecord
        }
        catch {
            errorMessage = error.localizedDescription
            return nil
        }        
    }
    
    func resetDraft() {
        chapterInstance = ChapterInput()
        validationMessage = nil
    }

    func validateChapterEntry() -> Bool {
        let validationResult: ChapterValidation?

        if chapterInstance.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            validationResult = .titleMissing
        } else if chapterInstance.chapterDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            validationResult = .descriptionMissing
        } else {
            validationResult = nil
        }

        validationMessage = validationResult
        return validationResult == nil
    }

    func clearValidationMessage() {
        validationMessage = nil
    }
}
