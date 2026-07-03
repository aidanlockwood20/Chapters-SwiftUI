import Foundation

extension CheckIn {
    static var sampleData: [CheckIn] {
        [
            CheckIn(moodScore: 8, moodLabel: .happy, title: "Getting my exam marks back", diaryNotes: "Was very pleased with the results", energyLevel: 9, sleepQuality: 10),
            CheckIn(moodScore: 5, moodLabel: .indifferent, title: "Cloudy Monday", diaryNotes: "Felt a bit sluggish, but got some work done.", energyLevel: 5, sleepQuality: 7),
            CheckIn(moodScore: 9, moodLabel: .happy, title: "Started a new hobby", diaryNotes: "Loved the first guitar lesson!", energyLevel: 8, sleepQuality: 9),
            CheckIn(moodScore: 3, moodLabel: .frustrated, title: "Long day at work", diaryNotes: "Overwhelmed and drained by meetings.", energyLevel: 2, sleepQuality: 4),
            CheckIn(moodScore: 7, moodLabel: .indifferent, title: "Evening walk", diaryNotes: "Felt peaceful watching the sunset in the park.", energyLevel: 6, sleepQuality: 8)
        ]
    }
}
