import SwiftUI

struct CheckInPreviewCard: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    let checkin: CheckIn
    
    var body: some View {
        Button(action: {
            dashboardViewModel.showCheckInDetailSheet = checkin
        }, label:  {
            VStack {
                Text("Check in on \(checkin.createdAt.formatted(date: .abbreviated, time: .omitted))")
                    .bold()
            }
            .padding(.horizontal, 16)
        })
        .chapterPreviewCard()
        .padding(.trailing)
    }
}
