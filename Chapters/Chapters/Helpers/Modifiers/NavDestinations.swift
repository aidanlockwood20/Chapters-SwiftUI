import SwiftUI

struct NavDestinations: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: Chapter.self) { chapter in
                ChapterDetailView(chapter: chapter)
            }
            .navigationDestination(for: DashboardNav.self) { route in
                AppBackgroundContainer {
                    switch route {
                    case .main:
                        DashboardView()
                    case .chapters:
                        ChapterListView()
                    case .stats:
                        UserStatsListView()
                    case .checkIn:
                        CheckInListView()
                    }
                }
            }
    }
}
