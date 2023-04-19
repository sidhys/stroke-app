import SwiftUI


struct QuizPage: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showCompletionAlert = false
    @State private var showTimesUpAlert = false
    @State private var showDragAndDropSheet = false   
    
    let questions = [
        ["What is the first symptom of a stroke to check?", "Drooping Face", "Arm Weakness", "Speech Difficulty", "Sudden Confusion"],
        ["What is the most effective immediate action when someone is having a stroke?", "Call 911 immediately", "Loosen tight clothing", "Make them comfortable", "Monitor their breathing"],
        ["Which preventative measure is most effective in reducing stroke risk?", "Quit smoking", "Take dedicated medicine", "Get regular physical activity", "Control alcohol intake"],
        ["What should you NOT do when someone is having a stroke?", "Give them something to eat or drink", "Check for F.A.S.T. symptoms", "Call 911 immediately", "Stay with the person"],
        ["Which symptom is a sign of a stroke?", "Sudden dizziness", "Dry mouth", "Earache", "Mild fever"],
    ]
    @State private var shuffledQuestions: [[String]] = []
    
    @State private var currentQuestion = 0
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var correctAnswers = 0
    @State private var selectedOption: Int? = nil
    @State private var timeRemaining = 10
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private func resetQuiz() {
        currentQuestion = 0
        correctAnswers = 0
        resetState()
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(shuffledQuestions.indices.contains(currentQuestion) ? shuffledQuestions[currentQuestion][0] : "No questions available")                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .padding()
            
            ProgressBar(value: Float(currentQuestion) / Float(shuffledQuestions.count))
                .frame(height: 10)
                .padding(.horizontal)
            
            VStack(spacing: 20) {
                ForEach(1...4, id: \.self) { index in
                    Button(action: {
                        selectedOption = index
                    }) {
                        Text(shuffledQuestions.indices.contains(currentQuestion) && shuffledQuestions[currentQuestion].indices.contains(index) ? shuffledQuestions[currentQuestion][index] : "")
                            .foregroundColor(selectedOption == index ? .white : .black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(selectedOption == index ? Color.red : Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            
            HStack {
                Button(action: {
                    if currentQuestion > 0 {
                        currentQuestion -= 1
                        resetState()
                    }
                }) {
                    Text("Previous Question")
                        .foregroundColor(.white)
                        .frame(width: 150, height: 50)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .disabled(currentQuestion == 0)
                
                Button(action: {
                    if let selectedOption = selectedOption {
                        if selectedOption == 1 {
                            correctAnswers += 1
                        }
                        if currentQuestion < shuffledQuestions.count - 1 {
                            currentQuestion += 1
                            resetState()
                        } else {
                            showAlert = true
                            alertTitle = "Quiz Completed"
                            timer.upstream.connect().cancel() 
                        }
                    }
                }) {
                    Text(currentQuestion < shuffledQuestions.count - 1 ? "Next Question" : "Finish")
                        .foregroundColor(.white)
                        .frame(width: 150, height: 50)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            
            Text("Time remaining: \(timeRemaining)")
                .padding()
                .onReceive(timer) { _ in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    } else {
                        timer.upstream.connect().cancel()
                        showAlert = true
                        alertTitle = "Time's up!"
                    }
                }
        }
        
        .navigationBarTitle("Quiz", displayMode: .inline)
        .sheet(isPresented: $showDragAndDropSheet) {
            DragAndDropQuizPage()
        }
        .onAppear {
            shuffledQuestions = questions.shuffled()
            timeRemaining = 10
            timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            showDragAndDropSheet = false 
        }
        
        if showAlert {
            CustomAlert(title: alertTitle,
                        message: "You got \(correctAnswers) out of \(shuffledQuestions.count) questions correct.",
                        buttonText: "Proceed",
                        buttonAction: {
                showAlert = false
                showDragAndDropSheet = true
                timer.upstream.connect().cancel()
            })
        }
    }
    
    private func resetState() {
        selectedOption = nil
        timeRemaining = 10
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
}
