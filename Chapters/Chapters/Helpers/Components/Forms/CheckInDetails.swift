import SwiftUI

struct CheckInDetails: View {
    
    @Binding var checkInTitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Check In Title (optional)")
                        .fontWeight(.semibold)
                    TextField("Title", text: $checkInTitle)
                }
                HStack {
                    Text("Add some notes (optional)")
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.textLowContrast)
                    })
                }
                
            }
            .padding(20)
        }
        .logCheckInCardStyle(horizontalPadding: 0)
        .padding(.bottom, 16)
    }
}
