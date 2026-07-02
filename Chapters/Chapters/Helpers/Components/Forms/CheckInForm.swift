import SwiftUI
import PhotosUI
import SwiftData

struct CheckInForm: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    @State var checkInInput: CheckInInput = CheckInInput()
    @State private var selectedImage: Image?
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
                                PhotosPicker(selection: $checkInInput.checkInPhoto) {
                                    Text("Add a Photo (optional)")
                                }
                                if let selectedImage {
                                    selectedImage
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(ConcentricRectangle(corners: .concentric, isUniform: true))
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            .padding(20)
                        }
                        .logCheckInCardStyle(horizontalPadding: 0)
                        .padding(.bottom, 16)
                        Button(action: {
                            dashboardViewModel.displayCheckInSheet.toggle()
                        }, label: {
                            Text("Complete Check In")
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
        .onChange(of: checkInInput.checkInPhoto) { _, newItem in
            Task {
                if let newItem {
                    if let loadImage = try? await newItem.loadTransferable(type: Image.self) {
                        selectedImage = loadImage
                    } else {
                        print("Failed to load image")
                    }
                }
            }
        }
    }
}

#Preview {
    CheckInForm()
        .modelContainer(previewContainer)
        .environment(DashboardViewModel())
}
