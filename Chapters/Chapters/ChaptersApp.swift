import SwiftUI
import SwiftData

@main
struct ChaptersApp: App {
    
    @State private var dashboardViewModel = DashboardViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(mainContainer)
                .environment(dashboardViewModel)
        }
        
    }
}
