import SwiftUI
import PhotosUI

struct PhotoSelectionPicker: View {
    @Environment(CheckInViewModel.self) private var checkInViewModel
    
    @State private var displayingImage: UIImage?
    @State private var selectedImage: PhotosPickerItem?
    @Binding var imageData: Data?
    
    var body: some View {
        @Bindable var checkInVM = checkInViewModel
        
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
