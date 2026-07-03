import SwiftUI
import SwiftData

struct CheckInDetails: View {
    @Environment(CheckInViewModel.self) private var checkInViewModel
    
    @Query var chapters: [Chapter]
            
    var body: some View {
        @Bindable var checkInVM = checkInViewModel
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Check In Title (optional)")
                        .fontWeight(.semibold)
                    TextField("Title", text: $checkInVM.checkInInstance.checkInTitle)
                }
                HStack {
                    Text("Add some notes (optional)")
                        .bold()
                    Spacer()
                    Button(action: {
                        checkInViewModel.checkInNavPath.append(.noteTaking)
                    }, label: {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.textLowContrast)
                    })
                }
                HStack {
                    Text("Add to an Existing Chapter")
                        .bold()
                    Spacer()
                    Picker("Add to an Existing Chapter", selection: $checkInVM.selectedChapter) {
                        ForEach(chapters, id: \.self) { chapter in
                            Text(chapter.title)
                        }
                    }

                }
            }
            .padding(20)
        }
        .logCheckInCardStyle(horizontalPadding: 0)
        .padding(.bottom, 16)
    }
}
