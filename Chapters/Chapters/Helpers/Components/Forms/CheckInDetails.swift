import SwiftUI

struct CheckInDetails: View {
    
    @Binding var checkInTitle: String
    @Binding var notesNavPath: [CheckInNavigation]
    
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
                        notesNavPath.append(.noteTaking)
                    }, label: {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.textLowContrast)
                    })
                }
                HStack {
                    
                }
            }
            .padding(20)
        }
        .logCheckInCardStyle(horizontalPadding: 0)
        .padding(.bottom, 16)
    }
}
