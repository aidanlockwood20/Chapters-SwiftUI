import SwiftData
import Foundation

@Model
final class CheckIn {
    var id: UUID = UUID()
    var moodScore: Int = 0
    var moodLabel: String = ""
    var title: String = ""
    var diaryNotes: String = ""
    var energyLevel: Int = 0
    var sleepQuality: Int = 0
    var createdAt: Date = Date()
    
    @Attribute(.externalStorage)
    var checkInPhoto: Data? = nil
    
    var user: User? = nil
    var chapter: Chapter? = nil
    
    init(id: UUID = UUID(), moodScore: Int, moodLabel: String, title: String, diaryNotes: String, energyLevel: Int, sleepQuality: Int, user: User? = nil, chapter: Chapter? = nil) {
        self.id = id
        self.moodScore = moodScore
        self.moodLabel = moodLabel
        self.title = title
        self.diaryNotes = diaryNotes
        self.energyLevel = energyLevel
        self.sleepQuality = sleepQuality
        self.user = user
        self.chapter = chapter
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
