import SwiftUI

struct AppBackgroundContainer<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        VStack(alignment: .leading) {
            content
            Spacer()
        }
        .padding(.top, 96)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(.backgroundColour)
    }
}
