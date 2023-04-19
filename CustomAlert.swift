import SwiftUI

struct CustomAlert: View {
    let title: String
    let message: String
    let buttonText: String
    let buttonAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.title)
                .bold()
            
            Text(message)
                .multilineTextAlignment(.center)
            
            Button(action: buttonAction) {
                Text(buttonText)
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 12)
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}
