import SwiftUI
import SwiftData

let mainContainer: ModelContainer = {
    do {
        let schema = Schema([
            Chapter.self,
            CheckIn.self,
            User.self
        ])
        
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        
        let container = try ModelContainer(for: schema, configurations: config)
        
        return container
    }
    catch {
        fatalError("Failed to create a container")
    }
}()
