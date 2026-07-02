import SwiftUI
import PhotosUI
import SwiftData

struct CheckInForm: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    @State var checkInInput = CheckInInput()
    
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
                .navigationDestination(for: CheckInNavigation.self) { _ in
                    CheckInNotesView(checkInNotes: $checkInInput.diaryNotes)
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
