import SwiftUI

struct PlungeListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Plunge.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Plunge.date, ascending: false)],
        animation: .default)
    private var plunges: FetchedResults<Plunge>

    private var groupedPlunges: [Date: [Plunge]] {
        Dictionary(grouping: plunges, by: { (plunge: Plunge) -> Date in
            let date = plunge.date ?? Date()
            let components = Calendar.current.dateComponents([.year, .month], from: date)
            return Calendar.current.date(from: components) ?? Date()
        })
    }
    
    var body: some View {
        List {
            ForEach(groupedPlunges.keys.sorted(by: >), id: \.self) { key in
                
                Section(header: Text(dateFormatter.string(from: key))) {
                    ForEach(groupedPlunges[key]!, id: \.self) { plunge in
                        CardView(plunge: plunge)
                    }
                    .onDelete(perform: { indexSet in
                        deletePlunge(from: key, at: indexSet)
                    })
                }
            }
        }
    }
    
    private func deletePlunge(from key: Date, at offsets: IndexSet) {
        guard let plungesInGroup = groupedPlunges[key] else { return }

        for index in offsets {
            let plungeToDelete = plungesInGroup[index]
            viewContext.delete(plungeToDelete)
        }
        try? viewContext.save()
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM yyyy"
    return formatter
}()

private let smallDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter
}()


struct CardView: View {
    var plunge: Plunge
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Ice Plunge")
                    .font(.body)
                    .foregroundColor(.blue)
                
                Spacer()
                
                Text(smallDateFormatter.string(from: plunge.date ?? Date()))
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            
            HStack() {
                Text("\(Int(plunge.temperature))°c")
                    .font(.headline)
                    .padding(.horizontal, 10)
                Text("\(plunge.minutes)m\(plunge.seconds%60)s")
                    .font(.headline)
                    .padding(.horizontal, 10)
            }
        }
        .frame(height: 100)
        .background(Color.clear)
    }
}
