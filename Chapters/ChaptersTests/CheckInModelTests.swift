import Testing
import Foundation

@testable import Chapters

struct CheckInModelTests {
    @Test("Check In Initialises with correct values")
    func testCheckInInitialisesCorrectly() async throws {
        
        // Arrange - Initialise the test object
        let testCheckInInstance = CheckIn()
        
        // Setup the expected values
        let expectedSliderValue: Double = 0.0
        let expectedStringValues: String = ""
        let expectedMoodSelection: MoodSelection = .happy
        
        #expect(testCheckInInstance.moodScore == expectedSliderValue)
        #expect(testCheckInInstance.moodLabel == expectedMoodSelection)
        #expect(testCheckInInstance.title == expectedStringValues)
        #expect(testCheckInInstance.diaryNotes == expectedStringValues)
        #expect(testCheckInInstance.energyLevel == expectedSliderValue)
        #expect(testCheckInInstance.sleepQuality == expectedSliderValue)
        #expect(testCheckInInstance.user == nil)
        #expect(testCheckInInstance.chapter == nil)
        #expect(testCheckInInstance.checkInPhoto == nil)
    }
}
