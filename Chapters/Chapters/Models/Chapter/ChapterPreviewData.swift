import Foundation

extension Chapter {
    static var sampleData: [Chapter] {
        [
            Chapter(title: "Going on holiday", chapterDescription: "A few journals made from the holiday", startDate: Date(), endDate: Date(), dominantTags: "happy", createdAt: Date(), lastModified: Date(), moodAverage: 8.0),
            Chapter(title: "Work Sprint", chapterDescription: "A productive period at work with lots of progress.", startDate: Date().addingTimeInterval(-60*60*24*30), endDate: Date().addingTimeInterval(-60*60*24*25), dominantTags: "productive, focused", createdAt: Date().addingTimeInterval(-60*60*24*30), lastModified: Date(), moodAverage: 7.2),
            Chapter(title: "Winter Blues", chapterDescription: "A few low-mood days during the winter season.", startDate: Date().addingTimeInterval(-60*60*24*90), endDate: Date().addingTimeInterval(-60*60*24*85), dominantTags: "tired, low energy", createdAt: Date().addingTimeInterval(-60*60*24*90), lastModified: Date(), moodAverage: 4.8),
            Chapter(title: "Spring Refresh", chapterDescription: "Feeling renewed and energetic as spring arrives.", startDate: Date().addingTimeInterval(-60*60*24*60), endDate: Date().addingTimeInterval(-60*60*24*55), dominantTags: "energetic, renewed", createdAt: Date().addingTimeInterval(-60*60*24*60), lastModified: Date(), moodAverage: 8.5),
            Chapter(title: "Family Time", chapterDescription: "Quality time spent with family over a long weekend.", startDate: Date().addingTimeInterval(-60*60*24*15), endDate: Date().addingTimeInterval(-60*60*24*12), dominantTags: "family, love", createdAt: Date().addingTimeInterval(-60*60*24*15), lastModified: Date(), moodAverage: 9.1)
        ]
    }
}
