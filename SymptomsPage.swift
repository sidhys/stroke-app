import SwiftUI


struct SymptomsPage: View {
    
    let symptoms = [
        ["Drooping Face", "Does one side of the face droop or feel numb? If so, this could be a warning of a developing stroke. This is because of muscle weaknesses, that cause the face to slightly change in appearance."],
        ["Arm Weakness", "Is one arm weak or numb? Try raising both arms. If one arm drifts downward or is difficult to raise, it could be a sign of a stroke."],
        ["Speech Difficulty", "Is speech slurred or difficult to understand? This may be a sign of a stroke. Try to repeat a simple sentence."],
        ["Sudden Confusion", "Stroke can cause sudden confusion, trouble understanding speech, or difficulty speaking."],
        ["Vision Problems", "Sudden trouble seeing in one or both eyes, blurred vision, or blackened vision can be signs of a stroke."],
        ["Sudden Headache", "A sudden, severe headache with no known cause can be an indication of a stroke. The pain can be accompanied by dizziness, vomiting, or altered consciousness."],
        ["Dizziness", "Sudden dizziness, loss of balance, or trouble walking can be symptoms of a stroke."],
        ["Numbness", "Sudden numbness or weakness, particularly on one side of the body, can be a sign of a stroke."],
        ["Loss of Coordination", "A sudden loss of coordination, stumbling, or difficulty walking can indicate a stroke."],
        ["Difficulty Swallowing", "Trouble swallowing or an inability to swallow is a potential symptom of a stroke."],
        ["Seizures", "Sudden onset of seizures, particularly in individuals with no prior history of seizures, may indicate a stroke."],
        ["Incontinence", "Loss of bladder or bowel control can be a sign of a stroke."],
        ["Shortness of Breath", "Difficulty breathing, shortness of breath, or chest pain could be symptoms of a stroke."],
        ["Unconsciousness", "A stroke may cause someone to suddenly lose consciousness or become unresponsive."],
        ["Coma", "In severe cases, a stroke can lead to a coma or a vegetative state."],
        ["Sudden Mood Changes", "Sudden changes in mood, irritability, or emotional outbursts can be symptoms of a stroke."],
        ["Memory Loss", "Stroke can cause sudden memory loss or difficulty recalling recent events."],
        ["Vertigo", "A sudden onset of vertigo or a spinning sensation can be a sign of a stroke."],
        ["Nausea and Vomiting", "Sudden nausea and vomiting without any apparent cause can be symptoms of a stroke."],
        ["Sudden Fatigue", "A sudden feeling of extreme fatigue or exhaustion can be a sign of a stroke."],
        ["Facial Pain", "Stroke can cause sudden facial pain or discomfort, particularly on one side of the face."],
        ["Tinnitus", "Sudden onset of ringing in the ears, also known as tinnitus, can be a sign of a stroke."],
        ["Loss of Taste", "A sudden loss of taste or changes in the ability to taste can be symptoms of a stroke."],
        ["Loss of Smell", "A sudden loss of smell or changes in the ability to smell can be symptoms of a stroke."],
        ["Unexplained Pain", "Sudden, unexplained pain, particularly on one side of the body, can be a sign of a stroke."]
    ]
    
    @State private var flipped = Array(repeating: false, count: 25)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<symptoms.count, id: \.self) { index in
                    CardView(symptom: symptoms[index], isFlipped: $flipped[index])
                }
            }
            .padding()
        }
        .navigationBarTitle("Symptoms", displayMode: .inline)
    }
}
