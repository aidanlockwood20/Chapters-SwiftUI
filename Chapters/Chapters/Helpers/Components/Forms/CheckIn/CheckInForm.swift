import SwiftUI
import PhotosUI
import SwiftData

struct CheckInForm: View {
    @Environment(CheckInViewModel.self) private var checkInViewModel
    @State private var imageData: Data?
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
                        VStack {
                            PhotoSelectionPicker(imageData: $imageData)
                            .padding(20)
                        }
                        .logCheckInCardStyle(horizontalPadding: 0)
                        .padding(.bottom, 16)
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
            let didSave = await checkInViewModel.saveCheckIn(imageData: imageData)

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
