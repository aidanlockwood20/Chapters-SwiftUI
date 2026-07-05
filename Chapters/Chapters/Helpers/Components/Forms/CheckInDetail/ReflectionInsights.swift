import SwiftUI

struct ReflectionInsights: View {
    
    let checkin: CheckIn
    
    var body: some View {
        CheckInSectionCard(title: "Reflections") {
            Text(checkin.diaryNotes)
        }
    }
}
