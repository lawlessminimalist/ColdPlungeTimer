import SwiftUI

struct CompletedPlungeView: View {
    @Binding public var path:[String]
    @Binding public var session:PlungeSession

    var body: some View {
        VStack{
            Image("iceberg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height:200)
            
            Text("Plunge Complete")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.blue)
                .padding(.bottom, 20)
            
            Text("See below for the stats about your plunge")
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 20)
                .padding(.bottom, 30)
            
            HStack(spacing: 40) {
                VStack {
                    Image(systemName: "clock")
                        .font(.system(size: 30))
                    Text("\(session.minutes)m \(session.seconds)s")
                        .font(.system(size: 14))
                }
                
                VStack {
                    Image(systemName: "thermometer")
                        .font(.system(size: 30))
                    Text("\(Int(session.temperature))°C")
                        .font(.system(size: 14))
                }
                
                VStack {
                    Image(systemName: "flame")
                        .font(.system(size: 30))
                    Text("\(session.kcaloricBurn)cal")
                        .font(.system(size: 14))
                }
            }
            HStack(spacing: 30) {
                            Button(action: {

                                CoreDataStack.shared.savePlunge(
                                    minutes: session.minutes,
                                    seconds: session.seconds,
                                    temperature: session.temperature,
                                    caloricBurn: session.kcaloricBurn
                                )
                                path = []
                                
                            }) {
                                Text("Save")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(20)
                            }
                            .buttonStyle(PlainButtonStyle())

                            Button(action: {
                                session = PlungeSession() // If this is how you clear your session.
                                path = []
                            }) {
                                Text("Clear")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.gray)
                                    .cornerRadius(20)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
            .padding(.top, 40)
        }
        .padding()

    }
}

struct CompletedPlungeView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedPlungeView(path: .constant(["testing"]),session: .constant(PlungeSession(minutes: 1, seconds: 1, temperature: 1)))
    }
}
