import SwiftUI

struct ChapterCreateForm: View {
    @Environment(ChapterViewModel.self) private var chapterViewModel

    var body: some View {
        @Bindable var chapterVM = chapterViewModel
        
        AppBackgroundContainer {
            NavigationStack {
                ScrollView {
                    VStack {
                        CheckInSectionCard(title: "Add Photo") {
                            PhotoCardPicker(
                                imageData: $chapterVM.chapterInstance.chapterPhoto,
                                title: "Select a Photo (optional)",
                                subtitle: "Choose an image for this chapter"
                            )
                        }
                        CheckInSectionCard(title: "Chapter Details") {
                            VStack(alignment: .leading) {
                                Text("Title")
                                    .font(.title3)
                                    .bold()
                                TextField("Title", text: $chapterVM.chapterInstance.title)
                            }
                            VStack(alignment: .leading) {
                                Text("Description")
                                    .font(.title3)
                                    .bold()
                                TextField("Description", text: $chapterVM.chapterInstance.chapterDescription)
                            }
                        }
                        CheckInSectionCard(title: "Timeline") {
                            VStack(alignment: .leading) {
                                Text("Start Date")
                                    .font(.title3)
                                    .bold()
                                DatePicker("Start Date", selection: $chapterVM.chapterInstance.startDate, displayedComponents: .date)
                            }
                        }
                        SubmitButton(labelText: "Add New Chapter", isLoading: chapterViewModel.isSaving) {
                            print("Adding new Chapter")
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(.backgroundColour)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                }
                .scrollClipDisabled()
                .navigationTitle("Create Chapter")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    ChapterCreateView()
        .withPreviewEnvironment()
}
