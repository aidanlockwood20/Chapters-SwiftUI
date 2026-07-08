import SwiftUI
import SwiftData
import Observation
#if canImport(FoundationModels)
import FoundationModels
#endif

@MainActor
@Observable
final class CheckInViewModel {
    let modelContext: ModelContext
    
    var checkInInstance: CheckInInput = CheckInInput()
    var checkInNavPath: [CheckInNavigation] = []

    var selectedChapter: Chapter?
    var displayChapterCreateSheet: Bool = false
    
    var isLoading: Bool = false

    var showError: Bool = false
    var errorMessage: String?
    var validationMessage: CheckInValidation?
    
    var isSaving: Bool = false
    var isPresentingAIInsights: Bool = false
    var isGeneratingAIInsights: Bool = false
    var aiInsights: CheckInInsight?
    var aiInsightsErrorMessage: String?
    private var aiInsightsCheckInID: UUID?
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func saveCheckIn() async -> Bool {
        isSaving = true
        errorMessage = nil
        defer {
            isSaving = false
        }

        await Task.yield()

        guard let checkInMood = checkInInstance.moodLabel else {
            return false
        }

        let checkInRecord = CheckIn(
            id: UUID(),
            moodScore: checkInInstance.moodScore,
            moodLabel: checkInMood,
            title: checkInInstance.checkInTitle,
            diaryNotes: checkInInstance.diaryNotes,
            energyLevel: checkInInstance.energyLevel,
            sleepQuality: checkInInstance.sleepQuality,
            user: nil,
            chapter: checkInInstance.chapterSelection,
            checkInPhoto: checkInInstance.checkInPhoto
        )

        modelContext.insert(checkInRecord)

        do {
            try modelContext.save()
            resetDraft()
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    func resetDraft() {
        checkInInstance = CheckInInput()
        selectedChapter = nil
        displayChapterCreateSheet = false
        validationMessage = nil
    }
    
    func validateCheckInEntry() -> Bool {
        let validationResult: CheckInValidation

        if checkInInstance.moodLabel == nil {
            validationResult = .moodNotSelected
        } else if checkInInstance.chapterSelection == nil {
            validationResult = .chapterNotSelected
        } else {
            validationResult = .noErrors
        }

        validationMessage = validationResult == .noErrors ? nil : validationResult
        return validationResult == .noErrors
    }

    func clearValidationMessage() {
        validationMessage = nil
    }

    func presentAIInsights(for checkIn: CheckIn) async {
        isPresentingAIInsights = true
        aiInsightsErrorMessage = nil

        guard aiInsightsCheckInID != checkIn.id || aiInsights == nil else {
            return
        }

        await generateAIInsights(for: checkIn)
    }

    func dismissAIInsights() {
        isPresentingAIInsights = false
    }

    private func generateAIInsights(for checkIn: CheckIn) async {
        isGeneratingAIInsights = true
        aiInsights = nil
        aiInsightsCheckInID = checkIn.id
        defer {
            isGeneratingAIInsights = false
        }

        #if canImport(FoundationModels)
        if #available(iOS 26.0, macOS 26.0, *) {
            let model = SystemLanguageModel.default

            switch model.availability {
            case .available:
                do {
                    let session = LanguageModelSession(
                        model: model,
                        instructions: """
                        You provide grounded, supportive wellbeing insights for a journaling app.
                        Keep each field concise, specific to the supplied check-in, and avoid clinical language.
                        """
                    )
                    let response = try await session.respond(
                        to: makeAIInsightPrompt(for: checkIn),
                        generating: CheckInInsightGeneration.self,
                        options: GenerationOptions(temperature: 0.3, maximumResponseTokens: 220)
                    )
                    aiInsights = CheckInInsight(response.content)
                    aiInsightsErrorMessage = nil
                } catch LanguageModelSession.GenerationError.refusal {
                    aiInsightsErrorMessage = "AI Insights are unavailable for this check-in."
                } catch {
                    aiInsightsErrorMessage = error.localizedDescription
                }
            case .unavailable(.deviceNotEligible):
                aiInsightsErrorMessage = "AI Insights require a device that supports Apple Intelligence."
                // Add an MLX-based fallback here for older devices.
            case .unavailable(.appleIntelligenceNotEnabled):
                aiInsightsErrorMessage = "Turn on Apple Intelligence in Settings to generate AI Insights on this device."
                // Add an MLX-based fallback here when Apple Intelligence is disabled.
            case .unavailable(.modelNotReady):
                aiInsightsErrorMessage = "The on-device model is still getting ready. Try again in a moment."
                // Add an MLX-based fallback here while the Foundation Models system model is unavailable.
            case .unavailable:
                aiInsightsErrorMessage = "AI Insights are currently unavailable on this device."
                // Add an MLX-based fallback here for other Foundation Models availability failures.
            }

            return
        }
        #endif

        aiInsightsErrorMessage = "AI Insights require Foundation Models support on this OS version."
        // Add an MLX-based fallback here for OS versions that do not support Foundation Models.
    }

    private func makeAIInsightPrompt(for checkIn: CheckIn) -> String {
        let chapterTitle = checkIn.chapter?.title ?? "No chapter selected"
        let noteText = checkIn.diaryNotes.trimmingCharacters(in: .whitespacesAndNewlines)
        let reflection = noteText.isEmpty ? "No written reflection was provided." : noteText

        return """
        Review this wellbeing check-in and generate supportive AI insights.

        Mood: \(checkIn.moodLabel.displayValue)
        Mood score: \(Int(checkIn.moodScore.rounded()))
        Energy level: \(Int(checkIn.energyLevel.rounded()))
        Sleep quality: \(Int(checkIn.sleepQuality.rounded()))
        Chapter: \(chapterTitle)
        Title: \(checkIn.title)
        Reflection: \(reflection)
        """
    }
}
