import SwiftUI


struct GeometryGetter: View {
    @Binding var rect: CGRect
    @State private var humanRect: CGRect = .zero
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: RectanglePreferenceKey.self, value: geometry.frame(in: .global))
        }
        .onAppear {
            DispatchQueue.main.async {
                rect = humanRect
            }
        }
        
    }
}
