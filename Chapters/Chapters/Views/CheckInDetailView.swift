import SwiftUI

struct CheckInDetailView: View {
    @Environment(DashboardViewModel.self) private var dashboardViewModel
    @Environment(CheckInViewModel.self) private var checkInViewModel
    @State private var isEditing: Bool = false
    @State private var insightsRequestID: UUID = UUID()
    
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
        .sheet(isPresented: aiInsightsBinding, onDismiss: checkInViewModel.dismissAIInsights) {
            aiInsightsSheet
        }
    }

    private var checkInSummaryView: some View {
        AppBackgroundContainer {
            NavigationStack {
                ScrollView {
                    VStack {
                        ReflectionInsights(checkin: checkin)
                        aiInsightsButton
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

    private var aiInsightsButton: some View {
        SubmitButton(labelText: "AI Insights", isLoading: checkInViewModel.isGeneratingAIInsights) {
            insightsRequestID = UUID()
            checkInViewModel.isPresentingAIInsights = true
        }
        .task(id: insightsRequestID) {
            guard checkInViewModel.isPresentingAIInsights else {
                return
            }

            await checkInViewModel.presentAIInsights(for: checkin)
        }
    }

    private var aiInsightsBinding: Binding<Bool> {
        @Bindable var checkInVM = checkInViewModel
        return $checkInVM.isPresentingAIInsights
    }

    private var aiInsightsSheet: some View {
        NavigationStack {
            AppBackgroundContainer {
                ScrollView {
                    CheckInSectionCard(title: "AI Insights") {
                        if checkInViewModel.isGeneratingAIInsights {
                            ProgressView("Generating insights...")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } else if let insights = checkInViewModel.aiInsights {
                            VStack(alignment: .leading, spacing: 16) {
                                insightRow(title: "Summary", text: insights.summary)
                                insightRow(title: "Pattern", text: insights.pattern)
                                insightRow(title: "Next Step", text: insights.nextStep)
                            }
                        } else if let errorMessage = checkInViewModel.aiInsightsErrorMessage {
                            Text(errorMessage)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } else {
                            Text("No insights are available yet.")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                }
            }
            .closeSheetToolbar {
                checkInViewModel.dismissAIInsights()
            }
            .navigationTitle("AI Insights")
            .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.medium, .large])
    }

    private func insightRow(title: LocalizedStringKey, text: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
            Text(text)
                .fixedSize(horizontal: false, vertical: true)
        }
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
