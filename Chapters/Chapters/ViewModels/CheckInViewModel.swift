import SwiftUI
import SwiftData
import Observation

@MainActor
@Observable
final class CheckInViewModel {
    let modelContext: ModelContext
    
    var checkInInstance: CheckInInput = CheckInInput()
    var checkInNavPath: [CheckInNavigation] = []

    var selectedChapter: Chapter?
    var displayChapterCreateSheet: Bool = false
    
    var isLoading: Bool = false

    var showError: Bool = false
    var errorMessage: String?
    var validationMessage: CheckInValidation?
    
    var isSaving: Bool = false
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func saveCheckIn() async -> Bool {
        isSaving = true
        errorMessage = nil
        defer {
            isSaving = false
        }

        await Task.yield()

        guard let checkInMood = checkInInstance.moodLabel else {
            return false
        }

        let checkInRecord = CheckIn(
            id: UUID(),
            moodScore: checkInInstance.moodScore,
            moodLabel: checkInMood,
            title: checkInInstance.checkInTitle,
            diaryNotes: checkInInstance.diaryNotes,
            energyLevel: checkInInstance.energyLevel,
            sleepQuality: checkInInstance.sleepQuality,
            user: nil,
            chapter: nil,
            checkInPhoto: checkInInstance.checkInPhoto
        )

        modelContext.insert(checkInRecord)

        do {
            try modelContext.save()
            resetDraft()
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    func resetDraft() {
        checkInInstance = CheckInInput()
        selectedChapter = nil
        displayChapterCreateSheet = false
        validationMessage = nil
    }
    
    func validateCheckInEntry() -> Bool {
        let validationResult: CheckInValidation

        if checkInInstance.moodLabel == nil {
            validationResult = .moodNotSelected
        } else if checkInInstance.chapterSelection == nil {
            validationResult = .chapterNotSelected
        } else {
            validationResult = .noErrors
        }

        validationMessage = validationResult == .noErrors ? nil : validationResult
        return validationResult == .noErrors
    }

    func clearValidationMessage() {
        validationMessage = nil
    }
}
