import SwiftUI

extension View {
    func navDestinations() -> some View {
        self.modifier(NavDestinations())
    }
    
    func sheetViews() -> some View {
        self.modifier(SheetViews())
    }
}
