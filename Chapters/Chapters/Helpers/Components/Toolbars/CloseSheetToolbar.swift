import SwiftUI

struct CloseSheetToolbar: ViewModifier {
    
    let action: (() -> Void)
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        action()
                    }, label: {
                        Image(systemName: "xmark")
                            .bold()
                            .foregroundStyle(Color.white)
                    })
                    .buttonStyle(.borderedProminent)
                    .tint(Color.red)
                }
            }
    }
}
