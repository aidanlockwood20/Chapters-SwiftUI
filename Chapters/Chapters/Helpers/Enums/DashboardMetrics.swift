import Foundation

enum DashboardMetrics: String, Identifiable, Hashable {
    case sleepQuality
    case checkInStreak
    case avgMoodScore
    case avgEnergyLvl
    
    var displayName: String {
        switch self {
        case .sleepQuality:
            return "Sleep Quality"
        case .checkInStreak: 
            return "Check-in Streak"
        case .avgMoodScore: 
            return "Average Mood Score"
        case .avgEnergyLvl: 
            return "Average Energy Level"
        }
    }
    
    var id: String { self.rawValue }
}
