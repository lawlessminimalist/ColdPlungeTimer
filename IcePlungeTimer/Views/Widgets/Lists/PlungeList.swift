import SwiftUI

struct PlungeListView: View {
    
    private var plunges:[Plunge] = CoreDataStack.shared.fetchAllPlunges()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(plunges, id: \.self) { plunge in
                    CardView(plunge: plunge)
                        .border(Color.black, width: 2)
                        .shadow(radius: 10)
                        .cornerRadius(10)
                        .padding()
                }
            }
            .border(Color.orange, width: 2)
            .cornerRadius(10)
        }
        .frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.height / 2) // Set ScrollView dimensions to half of the screen width and height

    }
}

struct CardView: View {
    var plunge: Plunge

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
            VStack(alignment: .leading) {
                Text(plunge.date ?? Date(), formatter: dateFormatter)
                Text("Temperature: \(plunge.temperature)")
                Text("Time:\(plunge.duration)")
            }
            .padding()
        }
        .frame(height: 100)
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yy"
    return formatter
}()

struct PlungeListView_Previews: PreviewProvider {
    
    static var previews: some View {
        PlungeListView()
    }
}
