import SwiftUI

struct ChapterCreateForm: View {
    @Environment(ChapterViewModel.self) private var chapterViewModel
    @Environment(\.dismiss) private var dismiss

    let onChapterCreated: (Chapter) -> Void

    init(onChapterCreated: @escaping (Chapter) -> Void = { _ in }) {
        self.onChapterCreated = onChapterCreated
    }

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
                                    .onChange(of: chapterVM.chapterInstance.title) {
                                        chapterViewModel.clearValidationMessage()
                                    }
                            }
                            VStack(alignment: .leading) {
                                Text("Description")
                                    .font(.title3)
                                    .bold()
                                TextField("Description", text: $chapterVM.chapterInstance.chapterDescription)
                                    .onChange(of: chapterVM.chapterInstance.chapterDescription) {
                                        chapterViewModel.clearValidationMessage()
                                    }
                            }
                        }
                        if let validationMessage = chapterVM.validationMessage {
                            Text(validationMessage.errorDescription)
                                .validationMessageStyle()
                                .transition(.opacity.combined(with: .move(edge: .top)))
                                .id(validationMessage)
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
                            guard chapterViewModel.validateChapterEntry() else {
                                return
                            }

                            Task {
                                guard let savedChapter = await chapterViewModel.saveChapter() else {
                                    return
                                }

                                onChapterCreated(savedChapter)
                                dismiss()
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(.backgroundColour)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .animation(.snappy, value: chapterVM.validationMessage)
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
