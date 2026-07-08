import SwiftUI
import SwiftData

struct CheckInForm: View {
    private static let topScrollAnchor = "check-in-form-top"

    @Environment(CheckInViewModel.self) private var checkInViewModel
    @State private var saveErrorIsPresented: Bool = false
    @State private var deleteErrorIsPresented: Bool = false

    let headingText: String
    let submitButtonText: String
    let submitErrorTitle: String
    let submitAction: () async -> Bool
    let onSaveComplete: () -> Void
    let deleteButtonText: String?
    let deleteErrorTitle: String
    let deleteAction: (() async -> Bool)?
    let onDeleteComplete: () -> Void

    init(
        headingText: String = "What's Been Happening?",
        submitButtonText: String = "Complete Check In",
        submitErrorTitle: String = "Unable to Save Check-In",
        submitAction: @escaping () async -> Bool = { false },
        onSaveComplete: @escaping () -> Void = {},
        deleteButtonText: String? = nil,
        deleteErrorTitle: String = "Unable to Delete Check-In",
        deleteAction: (() async -> Bool)? = nil,
        onDeleteComplete: @escaping () -> Void = {}
    ) {
        self.headingText = headingText
        self.submitButtonText = submitButtonText
        self.submitErrorTitle = submitErrorTitle
        self.submitAction = submitAction
        self.onSaveComplete = onSaveComplete
        self.deleteButtonText = deleteButtonText
        self.deleteErrorTitle = deleteErrorTitle
        self.deleteAction = deleteAction
        self.onDeleteComplete = onDeleteComplete
    }
    
    var body: some View {
        @Bindable var checkInVM = checkInViewModel
        
        AppBackgroundContainer {
            NavigationStack(path: $checkInVM.checkInNavPath) {
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        Text(headingText)
                            .font(.title2)
                            .bold()
                            .padding()
                            .id(Self.topScrollAnchor)
                        VStack { // Sets the main padding for the entire form
                            MoodSection()
                            if let validationMessage = checkInVM.validationMessage {
                                if checkInVM.validationMessage == .moodNotSelected {
                                    Text(validationMessage.errorDescription)
                                        .validationMessageStyle()
                                        .transition(.opacity.combined(with: .move(edge: .top)))
                                        .id(CheckInValidation.moodNotSelected)
                                }
                            }
                            RecoverySection()
                            CheckInDetails()
                            if let validationMessage = checkInVM.validationMessage {
                                if checkInVM.validationMessage == .chapterNotSelected {
                                    Text(validationMessage.errorDescription)
                                        .validationMessageStyle()
                                        .transition(.opacity.combined(with: .move(edge: .top)))
                                        .id(CheckInValidation.chapterNotSelected)
                                }
                            }
                            CheckInSectionCard(title: "Add Photo") {
                                PhotoCardPicker(imageData: $checkInVM.checkInInstance.checkInPhoto, title: "Select a Photo", subtitle: "Choose an image for this check in")
                            }
                            SubmitButton(
                                labelText: submitButtonText,
                                isLoading: checkInViewModel.isSaving,
                                action: {
                                    submitCheckIn(scrollProxy: scrollProxy)
                                }
                            )
                            if let deleteButtonText {
                                Button(role: .destructive) {
                                    deleteCheckIn()
                                } label: {
                                    Text(deleteButtonText)
                                        .frame(maxWidth: .infinity, minHeight: 50)
                                }
                                .disabled(checkInViewModel.isSaving)
                                .buttonStyle(.bordered)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .background(.backgroundColour)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                        .animation(.snappy, value: checkInVM.validationMessage)
                    }
                    .scrollClipDisabled()
                    .navigationDestination(for: CheckInNavigation.self) { destination in
                        switch destination {
                        case .noteTaking:
                            CheckInNotesView()
                        case .savingProgress:
                            CheckInSavingView()
                        case .mainForm:
                            EmptyView()
                        }
                    }
                }
            }
        }
        .alert(submitErrorTitle, isPresented: $saveErrorIsPresented) {
        } message: {
            Text(checkInViewModel.errorMessage ?? "An unexpected error occurred while saving your check-in.")
        }
        .alert(deleteErrorTitle, isPresented: $deleteErrorIsPresented) {
        } message: {
            Text(checkInViewModel.errorMessage ?? "An unexpected error occurred while deleting your check-in.")
        }
    }

    private func submitCheckIn(scrollProxy: ScrollViewProxy) {
        guard !checkInViewModel.isSaving else { return }
        guard checkInViewModel.validateCheckInEntry() else {
            if let validationMessage = checkInViewModel.validationMessage {
                let targetID: AnyHashable = switch validationMessage {
                case .moodNotSelected, .noErrors:
                    Self.topScrollAnchor
                case .chapterNotSelected:
                    CheckInValidation.chapterNotSelected
                }

                Task { @MainActor in
                    await Task.yield()

                    withAnimation(.snappy) {
                        scrollProxy.scrollTo(targetID, anchor: .top)
                    }
                }
            }
            return
        }

        checkInViewModel.checkInNavPath.append(.savingProgress)

        Task {
            let didSave: Bool

            if deleteButtonText == nil {
                didSave = await checkInViewModel.saveCheckIn()
            } else {
                didSave = await submitAction()
            }

            if didSave {
                checkInViewModel.checkInNavPath.removeAll()
                onSaveComplete()
            } else {
                checkInViewModel.checkInNavPath.removeAll { $0 == .savingProgress }
                saveErrorIsPresented = true
            }
        }
    }

    private func deleteCheckIn() {
        guard !checkInViewModel.isSaving else { return }
        guard let deleteAction else { return }

        Task {
            let didDelete = await deleteAction()

            if didDelete {
                checkInViewModel.checkInNavPath.removeAll()
                onDeleteComplete()
            } else {
                deleteErrorIsPresented = true
            }
        }
    }
}

#Preview("Check In Form") {
    CheckInForm()
        .modelContainer(previewContainer)
        .withPreviewEnvironment()
}
