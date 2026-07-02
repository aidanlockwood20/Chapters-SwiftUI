import SwiftUI

extension View {
    func chapterPreviewCard() -> some View {
        self.modifier(ChapterPreviewCardStyle())
    }
    
    func userStatsCardStyle() -> some View {
        self.modifier(UserStatsCardStyle())
    }
    
    func submitButtonStyle() -> some View {
        self.modifier(SubmitButtonStyle())
    }
    
    func logCheckInCardStyle(horizontalPadding: CGFloat) -> some View {
        self.modifier(LogCheckInCardStyle(horizontalPadding: horizontalPadding))
    }
    
    func checkInCardTextStyle() -> some View {
        self.modifier(CheckInCardText())
    }
}
