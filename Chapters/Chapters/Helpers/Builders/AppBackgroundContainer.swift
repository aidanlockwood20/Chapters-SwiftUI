import SwiftUI

struct AppBackgroundContainer<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        VStack(alignment: .leading) {
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundColour)
    }
}
