import SwiftUI


struct CardView: View {
    let symptom: [String]
    @Binding var isFlipped: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                isFlipped.toggle()
            }
        }) {
            VStack {
                Text(isFlipped ? symptom[1] : symptom[0])
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color
                        .gray.opacity(0.2))
                    .cornerRadius(10)
            }
        }
    }
}
