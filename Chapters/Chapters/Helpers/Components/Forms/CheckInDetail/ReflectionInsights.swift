import SwiftUI

struct ReflectionInsights: View {
    
    let checkIn: CheckIn
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Mood")
                        .font(.title3)
                        .bold()
                }
                VStack(alignment: .leading) {
                    Text(checkIn.diaryNotes)
                }
            }
            .padding(20)
        }
        .logCheckInCardStyle(horizontalPadding: 0)
        .padding(.bottom, 16)
    }
}
