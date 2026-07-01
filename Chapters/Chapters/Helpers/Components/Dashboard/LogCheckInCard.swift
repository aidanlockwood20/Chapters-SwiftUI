import SwiftUI

struct LogCheckInCard: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    var body: some View {
        @Bindable var dashboardVM = dashboardViewModel
        
        VStack {
            Text("What's on your mind?")
                .font(.title2)
                .bold()
                .frame(height: 50)
                .padding(.top, 24)
            Button(action: {
                dashboardViewModel.displayCheckInSheet.toggle()
            }, label: {
                Text("Log Check In")
                    .checkInCardTextStyle()
            })
            .frame(maxWidth: .infinity, minHeight: 40)
            .background(.tealButtonColour.gradient)
            .padding()
        }
        .logCheckInCardStyle(horizontalPadding: 32)
        .sheet(isPresented: $dashboardVM.displayCheckInSheet) {
            LogCheckInView()
        }
        
    }
}
