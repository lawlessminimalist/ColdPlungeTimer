import SwiftUI
import UserNotifications

struct HomeScreen: View {
    @Binding public var inNestedView:Bool
    @State public var plungeSession:PlungeSession = PlungeSession()
    @Binding public var isCelius: Bool

    @State private var offsetY = CGFloat(0.0)
    @State private var phase: CGFloat = 0.1
    @State private var path: [String] = []
    @State private var selectedTemp: Int = 10
    
    
    private let parentBackgroundColor = Color.white  // Define parent background color
    private let borderColor = Color.cyan
    var body: some View {
        ZStack{
            Color(.red)
                .ignoresSafeArea(.all)
                .overlay(
            NavigationStack(path: $path) {
                VStack{
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
                }
                

                .navigationDestination(for: String.self) { str in
                    switch str {
                    case "Init":
                        TimerInitView(selectedTemp: selectedTemp,path: $path, inNestedView: $inNestedView)
                            .toolbar(.hidden, for: .tabBar)
                    case "Plunge":
                        PlungeTimerView(isCelsius: $isCelius, path: $path, inNestedView: $inNestedView, session: $plungeSession)
                    case "PlungeComplete":
                        CompletedPlungeView(path: $path, session: $plungeSession,isCelsius: $isCelius)
                    default:
                        Text("Unknown destination")
                    }
                }
            }
            )
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(inNestedView: .constant(false),plungeSession: PlungeSession(minutes: 1, seconds: 2, celsius: 3),isCelius: .constant(true))
    }
}
