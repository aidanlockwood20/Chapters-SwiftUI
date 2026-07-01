import SwiftUI

enum MoodSelection: String, Identifiable, Hashable, Codable, CaseIterable {
    case happy
    case sad
    case indifferent
    case frustrated
    
    enum CodingKeys: CodingKey {
        case happy, sad, indifferent, frustrated
    }
    
    var id: String { self.rawValue }
    
    var displayValue: String {
        switch self {
        case .happy:
            return "Happy"
        case .sad:
            return "Sad"
        case .indifferent:
            return "Indifferent"
        case .frustrated:
            return "Frustrated"
        }
    }
}
