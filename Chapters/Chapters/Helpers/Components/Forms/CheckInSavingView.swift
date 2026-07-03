import SwiftUI

struct CheckInSavingView: View {
    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            ProgressView()
                .controlSize(.large)
                .tint(.white)
                .scaleEffect(1.4)

            VStack(spacing: 8) {
                Text("Saving Your Check-In")
                    .font(.title2)
                    .bold()

                Text("Please wait while we save your entry to your journal.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 24)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CheckInSavingView()
}
