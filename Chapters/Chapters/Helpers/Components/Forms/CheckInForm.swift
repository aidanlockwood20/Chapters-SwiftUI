import SwiftUI
import PhotosUI
import SwiftData

struct CheckInForm: View {
    
    @State var checkInInput = CheckInInput()
    @State var previewCheckInImage: UIImage
    
    var body: some View {
        AppBackgroundContainer {
            ScrollView {
                Text("What's Been Happening?")
                    .font(.title2)
                    .bold()
                    .padding()
                VStack { // Sets the main padding for the entire form
                    MoodSection(checkInInput: $checkInInput)
                    RecoverySection(checkInInput: $checkInInput)
                    CheckInDetails(checkInTitle: $checkInInput.checkInTitle)
                    VStack {
                        VStack {
                            PhotosPicker(selection: $checkInInput.checkInPhoto) {
                                Text("Add a Photo (optional)")
                            }
                            Image(uiImage: previewCheckInImage)
                        }
                        .padding(20)
                    }
                    .logCheckInCardStyle(horizontalPadding: 0)
                    .padding(.bottom, 16)
                    Button(action: {
                        
                    }, label: {
                        Text("Complete Check In")
                    })
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background(.tealButtonColour.gradient)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 34, style: .continuous))
                    .padding(.bottom, 16)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .onChange(of: checkInInput.checkInPhoto) { _, _ in
                    Task {
                        if let _ = checkInInput.checkInPhoto,
                           let data = try? await checkInInput.checkInPhoto?.loadTransferable(type: Data.self) {
                            if let image = UIImage(data: data) {
                                // assign this to where the photo should be previewed
                                previewCheckInImage = image
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CheckInForm(previewCheckInImage: UIImage(systemName: "person.fill")!)
        .modelContainer(previewContainer)
}
