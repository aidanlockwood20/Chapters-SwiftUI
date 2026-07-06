import SwiftUI
import SwiftData

struct RecentCheckIns: View {
    @Environment(\.colorScheme) private var colourScheme
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    @Query(sort: \CheckIn.createdAt, order: .reverse) var checkins: [CheckIn]
    
    var textColour: Color {
        return colourScheme == .dark ? .white : .black
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                dashboardViewModel.navTo(to: .checkIn)
            }, label: {
                HStack {
                    Text("Recent Check Ins")
                        .font(.title)
                        .foregroundStyle(textColour)
                        .bold()
                    Image(systemName: "chevron.right")
                        .bold()
                        .foregroundStyle(.textLowContrast)
                        .font(.title3)
                }
            })
            ScrollView(.horizontal) {
                HStack {
                    ForEach(checkins, id: \.self) { checkin in
                        CheckInPreviewCard(checkin: checkin)
                    }
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 8)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top)
    }
}
