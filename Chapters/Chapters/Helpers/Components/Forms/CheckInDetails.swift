import SwiftUI
import SwiftData

struct CheckInDetails: View {
    
    @Query var chapters: [Chapter]
    
    @State var selectedChapter: Chapter?
    
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
                        .bold()
                    Spacer()
                    Button(action: {
                        notesNavPath.append(.noteTaking)
                    }, label: {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.textLowContrast)
                    })
                }
                HStack {
                    Text("Add to an Existing Chapter")
                        .bold()
                    Spacer()
                    Picker("Add to an Existing Chapter", selection: $selectedChapter) {
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
