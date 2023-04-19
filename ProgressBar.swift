import SwiftUI



struct ProgressBar: View {
    
    var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.3))
                    .cornerRadius(5)
                
                Rectangle()
                    .frame(width: CGFloat(value) * geometry.size.width)
                    .foregroundColor(Color.red)
                    .cornerRadius(5)
            }
        }
    }
}
