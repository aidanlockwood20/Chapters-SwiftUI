import SwiftUI

struct CheckInDetailView: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    @Environment(CheckInViewModel.self) private var checkInViewModel
    
    let checkin: CheckIn
    
    private var attachedPhoto: UIImage? {
        guard let photoData = checkin.checkInPhoto else {
            return nil
        }
        
        return UIImage(data: photoData)
    }
    
    var body: some View {
        AppBackgroundContainer {
            NavigationStack {
                ScrollView {
                    VStack {
                        CheckInSectionCard(title: "Reflections") {
                            Text(checkin.diaryNotes)
                        }
                        CheckInSectionCard(title: "Attached Photo") {
                            Group {
                                if let attachedPhoto {
                                    Image(uiImage: attachedPhoto)
                                        .resizable()
                                        .scaledToFill()
                                } else {
                                    ZStack {
                                        Rectangle()
                                            .fill(Color.secondary)
                                        
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(.background)
                                            .padding(56)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 240)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        }
                        CheckInSectionCard(title: "Mood and Energy") {
                            HStack {
                                VStack {
                                    Text("Mood Score")
                                        .font(.title3)
                                        .bold()
                                    Text(String(checkin.moodScore))
                                }
                                Spacer()
                                VStack {
                                    Text("Energy Score")
                                        .font(.title3)
                                        .bold()
                                    Text(String(checkin.energyLevel))
                                }
                            }
                        }
                        SubmitButton(labelText: "Update", isLoading: checkInViewModel.isSaving) {
                            print("Send User to Update View")
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(.backgroundColour)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                }
                .scrollClipDisabled()
                .closeSheetToolbar {
                    dashboardViewModel.showCheckInDetailSheet = nil
                }
            }
        }
    }
}

#Preview {
    CheckInDetailView(checkin: CheckIn.sampleData[0])
        .withPreviewEnvironment()
}
