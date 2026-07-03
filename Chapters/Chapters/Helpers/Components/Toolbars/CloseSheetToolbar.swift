import SwiftUI

struct CloseSheetToolbar: ViewModifier {
    
    let isDisabled: Bool
    let action: (() -> Void)
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: action) {
                        Image(systemName: "xmark")
                            .bold()
                            .foregroundStyle(.white)
                    }
                    .disabled(isDisabled)
                    .buttonStyle(.borderedProminent)
                    .tint(Color.red)
                }
            }
    }
}
