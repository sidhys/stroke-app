import SwiftUI


struct DragElement: View {
    let imageName: String
    let responseMessage: String
    @State private var dragOffset: CGSize = .zero
    
    static let dropPublisher = NotificationCenter.default.publisher(for: .dragElementDrop)
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .shadow(radius: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5))
            )
            .offset(dragOffset)
            .zIndex(9999) 
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation
                    }
                    .onEnded { value in
                        NotificationCenter.default.post(name: .dragElementDrop, object: nil, userInfo: ["element": imageName, "message": responseMessage, "location": value.location])
                        dragOffset = .zero
                    }
            )
    }
}
