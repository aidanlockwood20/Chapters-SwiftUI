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
    var errorMessage: String?
    
    var isSaving: Bool = false
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func validateCheckIn() -> Void {
        print("Validation Process")
    }
    
    func saveCheckIn() async -> Bool {
        isSaving = true
        errorMessage = nil
        defer {
            isSaving = false
        }

        await Task.yield()

        let checkInRecord = CheckIn(
            id: UUID(),
            moodScore: checkInInstance.moodScore,
            moodLabel: checkInInstance.moodLabel,
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
    }
}
