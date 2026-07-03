import SwiftUI
import PhotosUI
import SwiftData

struct CheckInForm: View {
    @Environment(CheckInViewModel.self) private var checkInViewModel
        
    @State private var displayingImage: UIImage?
    @State private var selectedImage: PhotosPickerItem?
    @State private var imageData: Data?
    
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
                        SubmitButton(labelText: "Complete Check In") {
                            
                            checkInViewModel.saveCheckIn(imageData: imageData)
                        }
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
    let context = ModelContext(previewContainer)
    let checkInViewModel = CheckInViewModel(modelContext: context)
    
    CheckInForm()
        .modelContainer(previewContainer)
        .environment(checkInViewModel)
}
