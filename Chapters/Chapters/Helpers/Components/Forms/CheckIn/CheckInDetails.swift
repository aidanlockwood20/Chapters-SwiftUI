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
                    Picker("Add to an Existing Chapter", selection: $checkInVM.checkInInstance.chapterSelectionID) {
                        Text("-------").tag(nil as UUID?)
                        ForEach(chapters, id: \.id) { chapter in
                            Text(chapter.title).tag(chapter.id as UUID?)
                        }
                    }
                }
                .onChange(of: checkInVM.checkInInstance.chapterSelectionID) {
                    checkInViewModel.checkInInstance.chapterSelection = chapters.first {
                        $0.id == checkInViewModel.checkInInstance.chapterSelectionID
                    }
                    checkInViewModel.clearValidationMessage()
                }
                .onChange(of: chapters.map(\.id)) {
                    guard let selectedChapterID = checkInViewModel.checkInInstance.chapterSelectionID else {
                        checkInViewModel.checkInInstance.chapterSelection = nil
                        return
                    }

                    checkInViewModel.checkInInstance.chapterSelection = chapters.first {
                        $0.id == selectedChapterID
                    }
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
    CheckInForm(submitAction: { true })
        .modelContainer(previewContainer)
        .withPreviewEnvironment()
}
