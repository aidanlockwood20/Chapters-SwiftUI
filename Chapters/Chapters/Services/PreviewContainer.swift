import SwiftUI
import SwiftData

let previewContainer: ModelContainer = {
    do {
        let schema = Schema([
            Chapter.self,
            CheckIn.self,
            User.self
        ])
        
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        
        let container = try ModelContainer(for: schema, configurations: config)
        
        for checkin in CheckIn.sampleData {
            container.mainContext.insert(checkin)
        }
        
        for chapter in Chapter.sampleData {
            container.mainContext.insert(chapter)
        }
        
        return container
    }
    catch {
        fatalError("Failed to create a container")
    }
}()
