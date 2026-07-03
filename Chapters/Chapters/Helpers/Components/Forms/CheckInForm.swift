import SwiftUI
import PhotosUI
import SwiftData

struct CheckInForm: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    @Environment(CheckInViewModel.self) private var checkInViewModel
    
    @State var checkInInput: CheckInInput = CheckInInput()
    
    @State private var displayingImage: UIImage?
    @State private var selectedImage: PhotosPickerItem?
    @State private var imageData: Data?
    
    @State private var checkInNavPath: [CheckInNavigation] = []
    
    var body: some View {
        AppBackgroundContainer {
            NavigationStack(path: $checkInNavPath) {
                ScrollView {
                    Text("What's Been Happening?")
                        .font(.title2)
                        .bold()
                        .padding()
                    VStack { // Sets the main padding for the entire form
                        MoodSection(checkInInput: $checkInInput)
                        RecoverySection(checkInInput: $checkInInput)
                        CheckInDetails(checkInTitle: $checkInInput.checkInTitle, notesNavPath: $checkInNavPath)
                        VStack {
                            VStack {
                                PhotosPicker(selection: $selectedImage) {
                                    Text("Add a Photo (optional)")
                                }
                                if let displayingImage {
                                    Image(uiImage: displayingImage)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(ConcentricRectangle(corners: .concentric, isUniform: true))
                                }
                                
                            }
                            .padding(20)
                        }
                        .logCheckInCardStyle(horizontalPadding: 0)
                        .padding(.bottom, 16)
                        Button(action: {
                            // Create a new CheckIn model with the provided inputs and optional image
                            let checkInRecord = CheckIn(
                                id: UUID(),
                                moodScore: checkInInput.moodScore,
                                moodLabel: checkInInput.moodLabel.rawValue,
                                title: checkInInput.checkInTitle,
                                diaryNotes: checkInInput.diaryNotes,
                                energyLevel: checkInInput.energyLevel,
                                sleepQuality: checkInInput.sleepQuality,
                                user: nil,
                                chapter: nil,
                                checkInPhoto: imageData
                            )
                            
                            
                            
                        }, label: {
                            Text("Complete Check In")
                                .colorInvert()
                                .foregroundStyle(Color.primary)
                                .bold()
                        })
                        .submitButtonStyle()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                }
                .scrollClipDisabled()
                .navigationDestination(for: CheckInNavigation.self) { _ in
                    CheckInNotesView(checkInNotes: $checkInInput.diaryNotes)
                }
            }
        }
        .onChange(of: selectedImage) { _, _ in
            Task {
                if let selectedImage,
                   let data = try? await selectedImage.loadTransferable(type: Data.self) {
                    imageData = data
                    
                    if let image = UIImage(data: data) {
                        displayingImage = image
                    }
                }
                
                selectedImage = nil
            }
        }
    }
}

#Preview {
    CheckInForm()
        .modelContainer(previewContainer)
        .environment(DashboardViewModel())
}
