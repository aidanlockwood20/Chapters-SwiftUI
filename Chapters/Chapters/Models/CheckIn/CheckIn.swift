import SwiftData
import Foundation

@Model
final class CheckIn {
    var id: UUID = UUID()
    var moodScore: Double
    var moodLabel: MoodSelection
    var title: String
    var diaryNotes: String
    var energyLevel: Double
    var sleepQuality: Double
    var createdAt: Date
    
    @Attribute(.externalStorage)
    var checkInPhoto: Data?
    
    var user: User? = nil
    var chapter: Chapter?
    
    init(id: UUID = UUID(), moodScore: Double  = 0, moodLabel: MoodSelection = MoodSelection.happy, title: String = "", diaryNotes: String = "", energyLevel: Double = 0, sleepQuality: Double = 0, user: User? = nil, chapter: Chapter? = nil, checkInPhoto: Data? = nil, createdAt: Date = Date()) {
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
        self.createdAt = createdAt
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
        case createdAt = "created_at"
    }
    
    // Further methods for validation here
}
