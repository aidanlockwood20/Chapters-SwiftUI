import SwiftUI
import SwiftData

struct RecentChapters: View {
    @Environment(\.colorScheme) private var colourScheme
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    @Query var chapters: [Chapter]
    
    var textColour: Color {
        return colourScheme == .dark ? .white : .black
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                dashboardViewModel.navTo(to: .chapters)
            }, label: {
                HStack {
                    Text("Your Chapters")
                        .font(.title)
                        .foregroundStyle(textColour)
                        .bold()
                    Image(systemName: "chevron.right")
                        .bold()
                        .foregroundStyle(.textLowContrast)
                        .font(.title3)
                }
            })
            ScrollView(.horizontal) {
                HStack {
                    ForEach(chapters, id: \.self) { chapter in
                        ChapterPreviewCard(chapter: chapter)
                    }
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 8)
            }
            Button {
                // Open a "Create new Chapter" sheet
            } label: {
                HStack {
                    Image(systemName: "plus")
                        .bold()
                    Text("Start a new Chapter")
                        .bold()
                }
                .colorInvert()
                .foregroundStyle(Color.primary)
            }
            .submitButtonStyle()
        }
        .frame(maxWidth: .infinity)
        .padding(.top)
    }
}
