import SwiftData
import Foundation

@Model
final class CheckIn {
    var id: UUID = UUID()
    var moodScore: Double = 0
    var moodLabel: MoodSelection = MoodSelection.happy
    var title: String = ""
    var diaryNotes: String = ""
    var energyLevel: Double = 0
    var sleepQuality: Double = 0
    var createdAt: Date = Date()
    
    @Attribute(.externalStorage)
    var checkInPhoto: Data? = nil
    
    var user: User? = nil
    var chapter: Chapter? = nil
    
    init(id: UUID = UUID(), moodScore: Double, moodLabel: MoodSelection, title: String, diaryNotes: String, energyLevel: Double, sleepQuality: Double, user: User? = nil, chapter: Chapter? = nil, checkInPhoto: Data? = nil) {
        self.id = id
        self.moodScore = moodScore
        self.moodLabel = moodLabel
        self.title = title
        self.diaryNotes = diaryNotes
        self.energyLevel = energyLevel
        self.sleepQuality = sleepQuality
        self.user = user
        self.chapter = chapter
        self.checkInPhoto = checkInPhoto
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case moodScore = "mood_score"
        case moodLabel = "mood_label"
        case title = "title"
        case diaryNotes = "diary_notes"
        case energyLevel = "energy_level"
        case sleepQuality = "sleep_quality"
        case checkInPhoto = "checkin_photo"
        case user = "user"
        case chapter = "chapter"
    }
    
    // Further methods for validation here
}
