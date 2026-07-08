import SwiftUI
import SwiftData
import Observation

@MainActor
@Observable
final class CheckInViewModel {
    let modelContext: ModelContext
    
    var checkInInstance: CheckInInput = CheckInInput()
    var checkInNavPath: [CheckInNavigation] = []
    var editingCheckIn: CheckIn?

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
            chapter: checkInInstance.chapterSelection,
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
    
    func beginEditing(_ checkIn: CheckIn) {
        editingCheckIn = checkIn
        checkInInstance = CheckInInput(
            moodScore: checkIn.moodScore,
            moodLabel: checkIn.moodLabel,
            checkInTitle: checkIn.title,
            diaryNotes: checkIn.diaryNotes,
            energyLevel: checkIn.energyLevel,
            sleepQuality: checkIn.sleepQuality,
            chapterSelectionID: checkIn.chapter?.id,
            chapterSelection: checkIn.chapter,
            checkInPhoto: checkIn.checkInPhoto
        )
        selectedChapter = checkIn.chapter
        displayChapterCreateSheet = false
        validationMessage = nil
        errorMessage = nil
        checkInNavPath.removeAll()
    }
    
    func updateCheckIn() async -> Bool {
        isSaving = true
        errorMessage = nil
        defer {
            isSaving = false
        }

        await Task.yield()

        guard let existingCheckIn = editingCheckIn,
              let checkInMood = checkInInstance.moodLabel else {
            return false
        }

        existingCheckIn.moodScore = checkInInstance.moodScore
        existingCheckIn.moodLabel = checkInMood
        existingCheckIn.title = checkInInstance.checkInTitle
        existingCheckIn.diaryNotes = checkInInstance.diaryNotes
        existingCheckIn.energyLevel = checkInInstance.energyLevel
        existingCheckIn.sleepQuality = checkInInstance.sleepQuality
        existingCheckIn.chapter = checkInInstance.chapterSelection
        existingCheckIn.checkInPhoto = checkInInstance.checkInPhoto

        do {
            try modelContext.save()
            resetDraft()
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func deleteCheckIn() async -> Bool {
        isSaving = true
        errorMessage = nil
        defer {
            isSaving = false
        }

        await Task.yield()

        guard let existingCheckIn = editingCheckIn else {
            return false
        }

        modelContext.delete(existingCheckIn)

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
        editingCheckIn = nil
        displayChapterCreateSheet = false
        validationMessage = nil
        errorMessage = nil
        checkInNavPath.removeAll()
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
