import SwiftUI

struct Action: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
}

struct StrokeActionsPage: View {
    let actions = [
        Action(title: "Check for F.A.S.T. (Facial drooping, Arm weakness, Speech difficulties and Time) symptoms", imageName: "eye.circle.fill"),
        Action(title: "Call 911 immediately", imageName: "phone.arrow.up.right"),
        Action(title: "Stay with the person", imageName: "person.2.fill"),
        Action(title: "Make them comfortable", imageName: "house.fill"),
        Action(title: "Loosen tight clothing", imageName: "scissors"),
        Action(title: "Monitor their breathing", imageName: "lungs.fill"),
        Action(title: "Do not give them anything to eat or drink", imageName: "nosign"),
        Action(title: "Take note of the time symptoms started", imageName: "clock.fill")
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(actions) { action in
                    HStack {
                        Image(systemName: action.imageName)
                            .font(.title)
                            .frame(height: 50)
                        Text(action.title)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitle("What to do", displayMode: .inline)
    }
}
