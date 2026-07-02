import SwiftUI

struct MainToolbar: ViewModifier {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dashboardViewModel.displayAccountSettings.toggle()
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.primary, .clear)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.teal)
                }
            }
    }
}
