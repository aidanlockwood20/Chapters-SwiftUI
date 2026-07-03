import SwiftUI
import SwiftData
import PhotosUI

import Observation

@MainActor
@Observable
final class CheckInViewModel {
    let modelContext: ModelContext
    
    var checkInInstance: CheckInInput = CheckInInput()
    var checkInNavPath: [CheckInNavigation] = []

    var selectedChapter: Chapter?
    var selectedImage: PhotosPickerItem?
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    var isSaving: Bool = false
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func validateCheckIn() -> Void {
        print("Validation Process")
    }
    
    func saveCheckIn(imageData: Data?) async -> Bool {
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
            checkInPhoto: imageData
        )

        modelContext.insert(checkInRecord)

        do {
            try modelContext.save()
            checkInInstance = CheckInInput()
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}
