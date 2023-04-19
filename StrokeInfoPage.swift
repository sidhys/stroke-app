import SwiftUI


class GradientController: ObservableObject {
    @Published var color: Color = Color.red.opacity(0.3)
    @Published var heartScale: CGFloat = 1.0
    
    private var timer: Timer?
    
    init() {
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            let scaleRange: CGFloat = 0.1
            let period: CGFloat = 6.0
            let angle = 2 * CGFloat.pi * (CGFloat(self.timer!.fireDate.timeIntervalSince1970).truncatingRemainder(dividingBy: period) / period)
            self.heartScale = 1.0 + scaleRange * (sin(angle) + 1) / 2
            
            let redValue = 0.1 + 0.6 * (sin(angle) + 1) / 2
            self.color = Color.red.opacity(redValue)
        }
    }
}

struct CustomTitle: View {
    var body: some View {
        Text("StrokeSaver")
            .font(.largeTitle) 
            .bold()
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5) // Add a shadow
            .padding(.top, 50)
    }
}

struct StrokeInfoPage: View {
    @StateObject private var gradientController = GradientController()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [gradientController.color, Color.white]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                VStack {
                    Text("Stroke deaths are unnecessary. Learn all about strokes, then take an interactive quiz to prove your knowledge. ")
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.top, 20) // Add some padding to move it down from the top
                    Image("heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .scaleEffect(gradientController.heartScale) // Apply the scale effect
                        .animation(Animation.easeInOut(duration: 0.5), value: gradientController.heartScale) // Add animation
                    
                    VStack(alignment: .center, spacing: 20) {
                        NavigationLink(destination: SymptomsPage()) {
                            Text("Symptoms")
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                        
                        NavigationLink(destination: PreventativeMeasuresPage()) {
                            Text("Preventative Measures")
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                        
                        NavigationLink(destination: StrokeActionsPage()) {
                            Text("What to do")
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                        
                        NavigationLink(destination: QuizPage()) {
                            Text("Quiz")
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                        
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline) // Change this line
            .toolbar { // Add this block
                ToolbarItem(placement: .principal) {
                    CustomTitle()
                }
            }
        }
    }
}
