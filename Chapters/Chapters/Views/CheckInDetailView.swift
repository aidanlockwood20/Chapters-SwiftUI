import SwiftUI

struct CheckInDetailView: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    @Environment(CheckInViewModel.self) private var checkInViewModel
    @State private var isEditing: Bool = false
    
    let checkin: CheckIn
    
    private var attachedPhoto: UIImage? {
        guard let photoData = checkin.checkInPhoto else {
            return nil
        }
        
        return UIImage(data: photoData)
    }
    
    var body: some View {
        ZStack {
            if isEditing {
                editCheckInView
                    .transition(.move(edge: .trailing))
            } else {
                checkInSummaryView
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.snappy, value: isEditing)
    }

    private var checkInSummaryView: some View {
        AppBackgroundContainer {
            NavigationStack {
                ScrollView {
                    VStack {
                        ReflectionInsights(checkin: checkin)
                        CheckInPhotoDisplay(attachedPhoto: attachedPhoto)
                        MoodEnergyDisplay(checkin: checkin)
                        SubmitButton(labelText: "Update", isLoading: checkInViewModel.isSaving) {
                            checkInViewModel.beginEditing(checkin)
                            withAnimation(.snappy) {
                                isEditing = true
                            }
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

    private var editCheckInView: some View {
        @Bindable var checkInVM = checkInViewModel

        return NavigationStack {
            CheckInForm(
                headingText: "Make Changes to This Check-In",
                submitButtonText: "Save Changes",
                submitErrorTitle: "Unable to Update Check-In",
                submitAction: checkInViewModel.updateCheckIn,
                onSubmitComplete: dismissSheet,
                deleteButtonText: "Delete Check-In",
                deleteErrorTitle: "Unable to Delete Check-In",
                deleteAction: checkInViewModel.deleteCheckIn,
                onDeleteComplete: dismissSheet
            )
            .closeSheetToolbar(isDisabled: checkInViewModel.isSaving) {
                dismissSheet()
            }
            .sheet(isPresented: $checkInVM.displayChapterCreateSheet) {
                ChapterCreateView(onChapterCreated: updateSelectedChapter)
            }
            .navigationTitle("Update Check In")
            .navigationBarTitleDisplayMode(.inline)
        }
        .interactiveDismissDisabled(checkInViewModel.isSaving)
    }

    private func dismissSheet() {
        isEditing = false
        checkInViewModel.resetDraft()
        dashboardViewModel.showCheckInDetailSheet = nil
    }

    private func updateSelectedChapter(_ chapter: Chapter) {
        checkInViewModel.checkInInstance.chapterSelectionID = chapter.id
        checkInViewModel.checkInInstance.chapterSelection = chapter
        checkInViewModel.selectedChapter = chapter
        checkInViewModel.displayChapterCreateSheet = false
        checkInViewModel.clearValidationMessage()
    }
}

#Preview {
    CheckInDetailView(checkin: CheckIn.sampleData[0])
        .withPreviewEnvironment()
}
