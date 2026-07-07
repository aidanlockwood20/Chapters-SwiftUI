import SwiftUI

struct ValidationMessageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .foregroundStyle(.red)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .background(.red.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
    }
}

extension View {
    func validationMessageStyle() -> some View {
        modifier(ValidationMessageModifier())
    }
}
