import Foundation

#if canImport(FoundationModels)
import FoundationModels

@available(iOS 26.0, macOS 26.0, *)
@Generable(description: "Concise and supportive insights about a personal wellbeing check-in.")
struct CheckInInsightGeneration: Sendable {
    @Guide(description: "A brief summary of the person's current emotional state in one or two sentences.")
    let summary: String

    @Guide(description: "A single gentle observation that connects the person's mood, energy, sleep, and written reflection.")
    let pattern: String

    @Guide(description: "A short, actionable suggestion that fits the person's current state.")
    let nextStep: String
}
#endif

struct CheckInInsight: Equatable, Sendable {
    let summary: String
    let pattern: String
    let nextStep: String
}

#if canImport(FoundationModels)
@available(iOS 26.0, macOS 26.0, *)
extension CheckInInsight {
    init(_ generatedInsight: CheckInInsightGeneration) {
        self.summary = generatedInsight.summary
        self.pattern = generatedInsight.pattern
        self.nextStep = generatedInsight.nextStep
    }
}
#endif
