import SwiftUI
import PhotosUI

struct CheckInInput {
    var moodScore: Double = 5
    var moodLabel: MoodSelection? = nil
    var checkInTitle: String = ""
    var diaryNotes: String = ""
    var energyLevel: Double = 5
    var sleepQuality: Double = 5
    var chapterSelectionID: UUID? = nil
    var chapterSelection: Chapter? = nil
    var checkInPhoto: Data? = nil
}
