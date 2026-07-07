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
                    Picker("Add to an Existing Chapter", selection: $checkInVM.checkInInstance.chapterSelection) {
                        Text("-------").tag(nil as Chapter?)
                        ForEach(chapters, id: \.id) { chapter in
                            Text(chapter.title).tag(chapter as Chapter?)
                        }
                    }
                }
                .onChange(of: checkInVM.checkInInstance.chapterSelection) {
                    checkInViewModel.clearValidationMessage()
                }
                HStack {
                    Button {
                        checkInViewModel.displayChapterCreateSheet = true
                    } label: {
                        HStack {
                            Text("Or start a new chapter")
                                .foregroundStyle(Color.primary)
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.textLowContrast)
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

#Preview("Check In Form") {
    CheckInForm()
        .modelContainer(previewContainer)
        .withPreviewEnvironment()
}
