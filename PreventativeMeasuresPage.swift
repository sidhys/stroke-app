import SwiftUI


struct PreventativeMeasuresPage: View {
    let preventativeMeasures = [
        ("Take prescribed medicine", "pills.fill"),
        ("Quit smoking", "nosign"),
        ("Get regular physical activity", "figure.walk"),
        ("Monitor blood pressure", "gauge.badge.plus"),
        ("Maintain a healthy weight", "scalemass.fill"),
        ("Reduce alcohol intake", "drop.fill"),
        ("Control diabetes", "drop.triangle.fill"),
        ("Manage stress", "heart.slash.circle.fill"),
        ("Eat a healthy diet", "leaf.fill"),
        ("Monitor cholesterol levels", "waveform.path.ecg"),
        ("Stay hydrated", "drop.fill"),
        ("Get adequate sleep", "bed.double.fill"),
        ("Treat sleep apnea", "zzz"),
        ("Attend regular check-ups", "stethoscope"),
        ("Monitor atrial fibrillation", "stopwatch.fill")
    ]
    
    @State private var showAnimation = Array(repeating: false, count: 15)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(0..<preventativeMeasures.count, id: \.self) { index in
                    HStack {
                        Image(systemName: preventativeMeasures[index].1)
                            .font(.title)
                            .scaleEffect(showAnimation[index] ? 1.5 : 1.0)
                            .animation(Animation.easeInOut(duration: 0.5))
                            .onTapGesture {
                                showAnimation[index].toggle()
                            }
                        Text("\(index + 1). \(preventativeMeasures[index].0)")
                    }
                }
            }
            .padding()
        }
        .navigationBarTitle("Preventative Measures", displayMode: .inline)
    }
}
