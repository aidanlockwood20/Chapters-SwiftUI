import SwiftUI

struct CheckInPhotoDisplay: View {
    
    let attachedPhoto: UIImage?
    
    var body: some View {
        CheckInSectionCard(title: "Attached Photo") {
            Group {
                if let attachedPhoto {
                    Image(uiImage: attachedPhoto)
                        .resizable()
                        .scaledToFill()
                } else {
                    ZStack {
                        Rectangle()
                            .fill(Color.secondary)
                        
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.background)
                            .padding(56)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 240)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
    }
}
