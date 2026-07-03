import SwiftUI
import SwiftData
import PhotosUI

import Observation

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
    
    func saveCheckIn(imageData: Data?) -> Void {
        print("Hello World")
        
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
        
        print("CHECK IN RECORD: ")
        print("-----------------")
        
        print("Mood Score: \(checkInRecord.moodScore)")
        print("Mood Label: \(checkInRecord.moodLabel.displayValue)")
        print("Title: \(checkInRecord.title)")
        print("Notes: \(checkInRecord.diaryNotes)")
        print("Energy Level: \(checkInRecord.energyLevel)")
        print("Sleep Quality: \(checkInRecord.sleepQuality)")
        print("Photo Path: \(checkInRecord.checkInPhoto, default: "Some photo path")")
    }
}
