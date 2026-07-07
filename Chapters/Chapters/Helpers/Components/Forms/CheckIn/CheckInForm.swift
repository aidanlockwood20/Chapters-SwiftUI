import SwiftUI
import SwiftData

struct CheckInForm: View {
    private static let topScrollAnchor = "check-in-form-top"

    @Environment(CheckInViewModel.self) private var checkInViewModel
    @State private var saveErrorIsPresented: Bool = false

    let onSaveComplete: () -> Void

    init(onSaveComplete: @escaping () -> Void = {}) {
        self.onSaveComplete = onSaveComplete
    }
    
    var body: some View {
        @Bindable var checkInVM = checkInViewModel
        
        AppBackgroundContainer {
            NavigationStack(path: $checkInVM.checkInNavPath) {
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        Text("What's Been Happening?")
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
                                labelText: "Complete Check In",
                                isLoading: checkInViewModel.isSaving,
                                action: {
                                    submitCheckIn(scrollProxy: scrollProxy)
                                }
                            )
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
        .alert("Unable to Save Check-In", isPresented: $saveErrorIsPresented) {
        } message: {
            Text(checkInViewModel.errorMessage ?? "An unexpected error occurred while saving your check-in.")
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
            let didSave = await checkInViewModel.saveCheckIn()

            if didSave {
                checkInViewModel.checkInNavPath.removeAll()
                onSaveComplete()
            } else {
                checkInViewModel.checkInNavPath.removeAll { $0 == .savingProgress }
                saveErrorIsPresented = true
            }
        }
    }
}

#Preview("Check In Form") {
    CheckInForm()
        .modelContainer(previewContainer)
        .withPreviewEnvironment()
}
