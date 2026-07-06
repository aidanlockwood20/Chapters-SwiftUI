import SwiftUI
import PhotosUI

struct CheckInInput {
    var moodScore: Double = 0
    var moodLabel: MoodSelection? = nil
    var checkInTitle: String = ""
    var diaryNotes: String = ""
    var energyLevel: Double = 0
    var sleepQuality: Double = 0
    var checkInPhoto: Data? = nil
}
