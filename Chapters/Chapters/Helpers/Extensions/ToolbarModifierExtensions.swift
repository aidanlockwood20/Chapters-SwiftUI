import SwiftUI

extension View {
    func closeSheetToolbar(action: @escaping (() -> Void)) -> some View {
        self.modifier(CloseSheetToolbar(action: action))
    }
    
    func mainToolbar() -> some View {
        self.modifier(MainToolbar())
    }
    
}
