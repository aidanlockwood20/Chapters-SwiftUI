import SwiftUI
import PhotosUI

struct PhotoCardPicker: View {
    @Binding var imageData: Data?

    let title: String
    let subtitle: String
    let placeholderSystemImage: String
    let height: CGFloat

    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedUIImage: UIImage?

    init(
        imageData: Binding<Data?>,
        title: String,
        subtitle: String,
        placeholderSystemImage: String = "photo",
        height: CGFloat = 220
    ) {
        _imageData = imageData
        self.title = title
        self.subtitle = subtitle
        self.placeholderSystemImage = placeholderSystemImage
        self.height = height
    }

    var body: some View {
        PhotosPicker(selection: $selectedPhoto, matching: .images) {
            ZStack {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color.secondary.opacity(0.18))

                if let selectedUIImage {
                    Image(uiImage: selectedUIImage)
                        .resizable()
                        .scaledToFill()
                } else {
                    VStack(spacing: 12) {
                        Image(systemName: placeholderSystemImage)
                            .font(.system(size: 38, weight: .semibold))

                        Text(title)
                            .font(.headline)

                        Text(subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(24)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(Color.secondary.opacity(0.25), lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel(imageData == nil ? title : "Change selected photo")
        .onAppear {
            selectedUIImage = imageData.flatMap(UIImage.init(data:))
        }
        .onChange(of: selectedPhoto) { _, _ in
            Task {
                guard let selectedPhoto,
                      let data = try? await selectedPhoto.loadTransferable(type: Data.self) else {
                    return
                }

                imageData = data
                selectedUIImage = UIImage(data: data)
                self.selectedPhoto = nil
            }
        }
        .onChange(of: imageData) { _, newValue in
            selectedUIImage = newValue.flatMap(UIImage.init(data:))
        }
    }
}
