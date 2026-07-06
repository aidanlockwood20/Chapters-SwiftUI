import SwiftUI

struct ChapterPreviewCard: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    let chapter: Chapter
    
    private var chapterTitle: String {
        chapter.title.isEmpty ? "Untitled Chapter" : chapter.title
    }

    private var supportingText: String {
        if !chapter.chapterDescription.isEmpty {
            return chapter.chapterDescription
        }

        if !chapter.dominantTags.isEmpty {
            return chapter.dominantTags
        }

        return chapter.startDate.formatted(date: .abbreviated, time: .omitted)
    }

    private var overlayTitle: String {
        if !chapter.dominantTags.isEmpty {
            return chapter.dominantTags
        }

        return chapter.startDate.formatted(date: .abbreviated, time: .omitted)
    }

    private var overlaySymbol: String {
        chapter.dominantTags.isEmpty ? "calendar" : "tag.fill"
    }

    @ViewBuilder
    private var chapterArtwork: some View {
        if let chapterPhoto = chapter.chapterPhoto, let image = UIImage(data: chapterPhoto) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else {
            LinearGradient(
                colors: [.teal.opacity(0.8), .tealButtonColour, .cardSurfaceColour],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    var body: some View {
        Button(action: {
            dashboardViewModel.displayChapterSheet = chapter
        }, label: {
            ZStack(alignment: .bottomLeading) {
                chapterArtwork
                    .overlay(alignment: .topLeading) {
                        Label(overlayTitle, systemImage: overlaySymbol)
                            .font(.subheadline)
                            .bold()
                            .foregroundStyle(.white)
                            .lineLimit(1)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                    }
                
                LinearGradient(
                    colors: [.clear, .black.opacity(0.7)],
                    startPoint: .center,
                    endPoint: .bottom
                )
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(chapterTitle)
                        .font(.headline)
                        .bold()
                        .lineLimit(2)
                    
                    Text(supportingText)
                        .font(.subheadline)
                        .lineLimit(2)
                }
                .foregroundStyle(.white)
                .padding()
            }
        })
        .chapterPreviewCard()
        .padding(.trailing)
        .accessibilityLabel("\(chapterTitle), \(supportingText)")
    }
}
