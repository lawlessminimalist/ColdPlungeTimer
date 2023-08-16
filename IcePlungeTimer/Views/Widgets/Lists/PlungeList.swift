import SwiftUI

import SwiftUI

struct PlungeListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Plunge.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Plunge.date, ascending: false)],
        animation: .default)
    private var plunges: FetchedResults<Plunge>
    
    var body: some View {

        ScrollView {
            VStack(alignment: .leading) {
                let groupedPlunges = Dictionary(grouping: plunges, by: { (plunge: Plunge) -> Date in
                    // if nil set to now
                    let date = plunge.date ?? Date()
                    let components = Calendar.current.dateComponents([.year, .month], from: date)
                    return Calendar.current.date(from: components) ?? Date()
                })
                let sortedKeys = groupedPlunges.keys.sorted(by:>)
                ForEach(sortedKeys, id: \.self) { key in
                    HStack {
                        Text(dateFormatter.string(from: key))
                            .padding(.horizontal,10)
                        Spacer()
                        Text("\(groupedPlunges[key]?.count ?? 0) sessions")
                            .padding(.horizontal,10)

                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                    ForEach(groupedPlunges[key] ?? [], id: \.self) { plunge in
                        CardView(plunge: plunge)
                            .padding([.leading, .trailing, .bottom])
                    }
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.1) // Set padding to 10% of screen width
                    Divider() // Adds a thin line
                }
            }

            
        }
        .border(Color.blue, width: 4)
        .cornerRadius(10)
        .frame(maxWidth: .infinity,maxHeight:UIScreen.main.bounds.height * 0.5 )
        .padding([.leading, .trailing], UIScreen.main.bounds.width * 0.1)
    }
}


struct CardView: View {
    var plunge: Plunge
    
    private let smallDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text("Ice Plunge")
                    .font(.body)
                    .foregroundColor(.blue)
                
                Spacer()
                
                Text(smallDateFormatter.string(from: plunge.date ?? Date()))
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal,10)
            .padding(.bottom,10)

            HStack() {
                Text("\(Int(plunge.temperature))°c")
                    .font(.headline)
                    .padding(.horizontal,10)
                Text("\(plunge.minutes)m\(plunge.seconds)s")
                    .font(.headline)
                    .padding(.horizontal,10)

                Text("\(Int(plunge.caloricBurn))cal")
                    .font(.headline)

            }
            
            Spacer()
        }
        
        .frame(height: 100)
        .background(Color.clear)
    }
}



private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM yyyy"
    return formatter
}()

struct PlungeListView_Previews: PreviewProvider {
    
    static var previews: some View {
        PlungeListView()
    }
}
