import SwiftUI
import SwiftData

@Model
final class Chapter {
    var id: UUID = UUID()
    
    @Attribute(.externalStorage)
    var chapterPhoto: Data?
    
    var title: String = ""
    var chapterDescription: String = ""
    var startDate: Date = Date()
    var endDate: Date?
    var user: User? = nil
    var dominantTags: String = ""
    
    var createdAt: Date = Date()
    var lastModified: Date = Date()
    var moodAverage: Double = 0
    
    init(chapterPhoto: Data? = nil, title: String, chapterDescription: String, startDate: Date, endDate: Date, user: User? = nil, dominantTags: String, createdAt: Date = Date(), lastModified: Date = Date(), moodAverage: Double = 0.0) {
        self.chapterPhoto = chapterPhoto
        self.title = title
        self.chapterDescription = chapterDescription
        self.startDate = startDate
        self.endDate = endDate
        self.user = user
        self.dominantTags = dominantTags
        self.createdAt = createdAt
        self.lastModified = lastModified
        self.moodAverage = moodAverage
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case chapterPhoto = "chapter_photo"
        case title = "title"
        case chapterDescription = "description"
        case startDate = "start_date"
        case endDate = "end_date"
        case user = "user"
        case dominantTags = "dominant_tags"
        case createdAt = "created_at"
        case lastModified = "last_modified"
        case moodAverage = "mood_average"
    }
}
