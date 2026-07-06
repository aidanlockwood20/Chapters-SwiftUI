import SwiftUI
import SwiftData

struct CheckInForm: View {
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
                ScrollView {
                    Text("What's Been Happening?")
                        .font(.title2)
                        .bold()
                        .padding()
                    VStack { // Sets the main padding for the entire form
                        MoodSection()
                        RecoverySection()
                        CheckInDetails()
                        CheckInSectionCard(title: "Add Photo") {
                            PhotoCardPicker(imageData: $checkInVM.checkInInstance.checkInPhoto, title: "Select a Photo", subtitle: "Choose an image for this check in")
                        }
                        SubmitButton(
                            labelText: "Complete Check In",
                            isLoading: checkInViewModel.isSaving,
                            action: submitCheckIn
                        )
                    }
                    .scrollContentBackground(.hidden)
                    .background(.backgroundColour)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
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
        .alert("Unable to Save Check-In", isPresented: $saveErrorIsPresented) {
        } message: {
            Text(checkInViewModel.errorMessage ?? "An unexpected error occurred while saving your check-in.")
        }
    }

    private func submitCheckIn() {
        guard !checkInViewModel.isSaving else { return }

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
