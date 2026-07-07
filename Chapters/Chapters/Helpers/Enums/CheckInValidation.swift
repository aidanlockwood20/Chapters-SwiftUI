import Foundation

enum CheckInValidation: String, Hashable {
    case noErrors
    case moodNotSelected
    case chapterNotSelected
    
    var errorDescription: String {
        switch self {
            case .noErrors:
                return "Check In Validated with no errors"
            case .moodNotSelected:
                return "Mood not selected. Please enter a mood that best describes your checkin"
            case .chapterNotSelected:
                return "No chapter selected. Please add your checkin to a chapter"
        }
    }
}
