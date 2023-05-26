import SwiftUI

struct HomeScreen: View {
    @State private var date = Date()
    let parentBackgroundColor = Color.white  // Define parent background color
    @State var offsetY = CGFloat(0.0)
    @State var phase: CGFloat = 0.1
    @State private var path: [String] = []

    
    private var borderColor = Color.cyan
    var body: some View {
        NavigationStack(path: $path) {
            VStack{
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .background(Color.clear) // Add a transparent background
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Overlay with rounded rectangle
                        .stroke(borderColor, lineWidth: 2) // Add border
                )
                .frame(width: 300)
                .padding()
                
                
                Image("iceberg")
                    .resizable()
                    .clipShape(Circle())  // Enclose the view in a circle
                    .overlay(Circle().stroke(Color.cyan, lineWidth: 10))
                    .frame(width: 150,height: 150)
                    .overlay(
                        CosineWaveLine(phase: phase)
                            .stroke(.blue, lineWidth: 10)
                            .animation(.linear(duration: 2.1).repeatForever(autoreverses: false), value: phase)
                            .onAppear {
                                withAnimation {
                                    phase = 2 * CGFloat.pi
                                }
                            }
                            .padding()
                    )
                Button(action: {
                    path.append("Init")
                }, label: {
                    Text("Start Plunge")
                        .font(.title)
                        .foregroundColor(parentBackgroundColor)  // Font color
                        .padding()
                        .background(Color.yellow)  // Background color
                        .cornerRadius(50)  // Rounded corners
                        .padding()
                    
                })
                .navigationDestination(for: String.self) { str in
                                switch str {
                                case "Init":
                                    TimerInitView(path: $path)
                                case "Plunge":
                                    PlungeTimerView(path: $path)
                                default:
                                    Text("Unknown destination")
                                }
                }
                
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
