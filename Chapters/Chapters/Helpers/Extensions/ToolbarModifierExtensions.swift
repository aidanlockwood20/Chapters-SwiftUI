import SwiftUI

extension View {
    func closeSheetToolbar(
        isDisabled: Bool = false,
        action: @escaping (() -> Void)
    ) -> some View {
        self.modifier(CloseSheetToolbar(isDisabled: isDisabled, action: action))
    }
    
    func mainToolbar() -> some View {
        self.modifier(MainToolbar())
    }
    
}
