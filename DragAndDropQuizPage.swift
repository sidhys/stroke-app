import SwiftUI


struct DragAndDropQuizPage: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var humanRect: CGRect = .zero
    @State private var showAlert = false
    @State private var thankYouAlertShown = false
    @State private var showThankYouAlert = false
    @State private var droppedElement = ""
    @State private var responseMessage = ""
    @State private var dropCounter = 0
    
    let dragElements = [
        ("healthyfood", "Healthy Food|Healthy food such as vegetables and salmon helps your heart function properly."),
        ("redmeat", "Red Meat|Although some believe that red meat is healthy, studies have shown that red meat significantly increases your chances of heart problems. You should consider a vegetarian diet to get a healthier heart."),
        ("lolipop", "Candy|The syrup used in candies is often terrible for your overall health, and even worse for your heart. Stay away from candy!"),
        ("water", "Water|Drinking water is one of the most beneficial things that you can do! "),
        ("weights", "Weights|Through resistance training, you can set your body up for heart success"),
        ("drinks", "Alcoholic drinks|Alcohol consumption in excess can lead to high blood pressure, which in turn can cause damage to the heart and blood vessels. Additionally, long-term heavy drinking can weaken the heart muscle and lead to heart failure.")
    ]
    
    var body: some View {
        VStack {
            Text("This is Bob. Bob has started to worry about his health, and fears getting a stroke. Drag each item over Bob to learn more!")
                .font(.headline)
                .padding()
                .multilineTextAlignment(.center)
            
            Spacer()
            
            HStack {
                Spacer()
                DragElement(imageName: dragElements[0].0, responseMessage: dragElements[0].1)
                Spacer()
                Spacer()
                DragElement(imageName: dragElements[1].0, responseMessage: dragElements[1].1)
                Spacer()
            }
            
            Spacer()
            
            HStack {
                DragElement(imageName: dragElements[2].0, responseMessage: dragElements[2].1)
                Spacer()
                Image("guy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .background(GeometryGetter(rect: $humanRect))
                    .zIndex(1.0)
                Spacer()
                DragElement(imageName: dragElements[3].0, responseMessage: dragElements[3].1)
            }
            
            Spacer()
            
            HStack {
                Spacer()
                DragElement(imageName: dragElements[4].0, responseMessage: dragElements[4].1)
                Spacer()
                Spacer()
                DragElement(imageName: dragElements[5].0, responseMessage: dragElements[5].1)
                Spacer()
            }
        }
        .padding()
        .onReceive(DragElement.dropPublisher) { notification in
            if let _ = notification.userInfo?["location"] as? CGPoint, let message = notification.userInfo?["message"] as? String {
                
                let separated = message.split(separator: "|")
                
                showAlert = true
                self.droppedElement = String(separated[0])
                self.responseMessage = String(separated[1])
                
                // Increment the dropCounter
                dropCounter += 1
                
                // Check if all elements have been dropped
                if dropCounter == dragElements.count {
                    showAlert = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        showThankYouAlert = true
                    }
                }
            }
        }
        
        .alert(isPresented: $showAlert) {
            Alert(title: Text("\(droppedElement)"),
                  message: Text(" \(responseMessage)"),
                  dismissButton: .default(Text("OK")) {
                if showThankYouAlert && !thankYouAlertShown {
                    thankYouAlertShown = true
                    showAlert = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showAlert = true
                        droppedElement = "All elements dropped"
                        responseMessage = "Thank you for learning, I hope this information helps you in your future!"
                    }
                } else if thankYouAlertShown {
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}
