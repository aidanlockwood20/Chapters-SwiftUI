import SwiftUI

struct ChapterPreviewCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 200, height: 150)
            .foregroundStyle(.primary)
            .background(.cardSurfaceColour.gradient.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 34))
            .shadow(radius: 10)
    }
}

struct CheckInCardText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .colorInvert()
            .foregroundStyle(Color.primary)
            .bold()
    }
}

struct UserStatsCardStyle: ViewModifier {
    @Environment(\.colorScheme) private var colourScheme
    
    var backgroundCardOpacity: Double {
        return colourScheme == .dark ? 1 : 0.7
    }
    
    func body(content: Content) -> some View {
        content
            .frame(width: 175, height: 100)
            .foregroundStyle(.white)
            .background(.tealButtonColour.gradient.opacity(backgroundCardOpacity))
            .clipShape(RoundedRectangle(cornerRadius: 34, style: .continuous))
            .shadow(radius: 10)
    }
}

struct LogCheckInCardStyle: ViewModifier {
    
    let horizontalPadding: CGFloat;
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .background(.cardSurfaceColour)
            .containerShape(.rect(cornerRadius: 34, style: .continuous))
            .shadow(radius: 10)
            .padding(.horizontal, horizontalPadding)
    }
}
