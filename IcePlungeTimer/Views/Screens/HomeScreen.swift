import SwiftUI

struct HomeScreen: View {
    @State private var date = Date()
    let parentBackgroundColor = Color.white  // Define parent background color

    
    private var borderColor = Color.cyan
    var body: some View {
        NavigationView {
            
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
                        CosineWaveLineView()
                        .padding()
                        .animation(.easeInOut(duration: 0.1)) // Use any duration you like
                        
                    )
                NavigationLink(destination: TimerInitView(), label: {

                        Text("Start Plunge")
                            .font(.title)
                            .foregroundColor(parentBackgroundColor)  // Font color
                            .padding()
                            .background(Color.yellow)  // Background color
                            .cornerRadius(50)  // Rounded corners
                            .padding()
                })
            }
            
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
