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
                        ReflectionInsights(checkin: checkin)
                        CheckInPhotoDisplay(attachedPhoto: attachedPhoto)
                        MoodEnergyDisplay(checkin: checkin)
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
                .navigationTitle("Check in on \(checkin.createdAt.formatted(date: .abbreviated, time: .omitted))")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    CheckInDetailView(checkin: CheckIn.sampleData[0])
        .withPreviewEnvironment()
}
