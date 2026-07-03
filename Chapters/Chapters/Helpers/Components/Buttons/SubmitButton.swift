import SwiftUI

struct SubmitButton: View {
    let labelText: String
    let isLoading: Bool
    let action: (() -> Void)
    
    var body: some View {
        Button(action: action) {
            Group {
                if isLoading {
                    ProgressView()
                        .tint(.primary)
                } else {
                    Text(labelText)
                        .colorInvert()
                        .foregroundStyle(.primary)
                        .bold()
                }
            }
            .frame(maxWidth: .infinity, minHeight: 50)
        }
        .disabled(isLoading)
        .submitButtonStyle()
    }
}
