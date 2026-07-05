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
                    Text(checkin.moodScore, format: .number.precision(.fractionLength(1)))
                }
                Spacer()
                VStack {
                    Text("Energy Score")
                        .font(.title3)
                        .bold()
                    Text(checkin.energyLevel, format: .number.precision(.fractionLength(1)))
                }
            }
        }
    }
}
