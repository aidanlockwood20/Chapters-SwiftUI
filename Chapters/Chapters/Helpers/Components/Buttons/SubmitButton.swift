import SwiftUI

struct SubmitButton: View {
    let labelText: String
    let action: (() -> Void)
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(labelText)
                .colorInvert()
                .foregroundStyle(Color.primary)
                .bold()
        })
        .submitButtonStyle()
    }
}
