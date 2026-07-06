import SwiftUI

struct CheckInPreviewCard: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    
    let checkin: CheckIn

    private var checkInTitle: String {
        checkin.title.isEmpty ? "Check-in" : checkin.title
    }

    private var moodSymbol: String {
        switch checkin.moodLabel {
        case .happy:
            return "sun.max.fill"
        case .sad:
            return "cloud.rain.fill"
        case .indifferent:
            return "cloud.fill"
        case .frustrated:
            return "bolt.fill"
        }
    }

    private var secondaryText: String {
        if let chapterTitle = checkin.chapter?.title, !chapterTitle.isEmpty {
            return chapterTitle
        }

        return checkin.createdAt.formatted(date: .abbreviated, time: .omitted)
    }

    @ViewBuilder
    private var checkInArtwork: some View {
        if let checkInPhoto = checkin.checkInPhoto, let image = UIImage(data: checkInPhoto) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else {
            LinearGradient(
                colors: [.teal.opacity(0.95), .tealButtonColour, .cardSurfaceColour],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .overlay(alignment: .topLeading) {
                Label(checkin.moodLabel.displayValue, systemImage: moodSymbol)
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
            }
        }
    }
    
    var body: some View {
        Button(action: {
            dashboardViewModel.showCheckInDetailSheet = checkin
        }, label:  {
            ZStack(alignment: .bottomLeading) {
                checkInArtwork
                
                LinearGradient(
                    colors: [.clear, .black.opacity(0.7)],
                    startPoint: .center,
                    endPoint: .bottom
                )
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(checkInTitle)
                        .font(.headline)
                        .bold()
                        .lineLimit(2)
                    
                    Text(secondaryText)
                        .font(.subheadline)
                        .lineLimit(1)
                    
                    Text(checkin.createdAt.formatted(date: .abbreviated, time: .omitted))
                        .font(.footnote)
                        .foregroundStyle(.white.secondary)
                        .lineLimit(1)
                }
                .foregroundStyle(.white)
                .padding()
            }
        })
        .chapterPreviewCard()
        .padding(.trailing)
        .accessibilityLabel("\(checkInTitle), \(checkin.moodLabel.displayValue), \(secondaryText), \(checkin.createdAt.formatted(date: .abbreviated, time: .omitted))")
    }
}
