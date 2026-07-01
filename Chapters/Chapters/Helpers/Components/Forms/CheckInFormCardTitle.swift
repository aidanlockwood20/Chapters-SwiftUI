import SwiftUI

struct CheckInFormCardTitle: View {
    
    let cardTitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(cardTitle)
                .font(.title3)
                .bold()
        }
    }
}
