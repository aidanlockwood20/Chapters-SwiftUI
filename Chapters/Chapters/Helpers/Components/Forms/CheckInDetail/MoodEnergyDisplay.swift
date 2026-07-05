import SwiftUI

struct MoodEnergyDisplay: View {
    
    let checkin: CheckIn
    
    var body: some View {
        CheckInSectionCard(title: "Mood and Energy") {
            HStack {
                VStack {
                    Text("Mood Score")
                        .font(.title3)
                        .bold()
                    Text(String(checkin.moodScore))
                }
                Spacer()
                VStack {
                    Text("Energy Score")
                        .font(.title3)
                        .bold()
                    Text(String(checkin.energyLevel))
                }
            }
        }
    }
}
