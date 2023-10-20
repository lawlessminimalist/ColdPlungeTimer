//
//  PlungeTimer.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 27/4/2023.
//
import Dispatch
import SwiftUI
import Combine
import AudioToolbox
import AVFoundation



func normalizeOffset(timerModel: TimerModel) -> Float {
    let baseline = Float(timerModel.initialTime)
    let offsetTime = Float(max(1, timerModel.totalSeconds))
    let ratio = offsetTime / baseline
    return 120 * (1 - ratio)
}




struct PlungeTimerView: View {
    @EnvironmentObject var timerModel: TimerModel
    @Binding var isCelsius:Bool;

    @State var performOnce = false
    @State var waterOffset:CGFloat = CGFloat(0.0)
    @State private var showText = false
    @State private var tapCount = 0
    
    
    @Binding var path: [String]
    @Binding var inNestedView:Bool
    @Binding var session:PlungeSession
    
    @State private var showAlert = false
    @State private var isPlayingAlertSound = false

    
    private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    @State private var timerCancellable: Cancellable? = nil
    @State private var cancelled = false
    
    @State private var audioPlayer: AVAudioPlayer?
    
    // TODO: Change location of this =
    let location = Bundle.main.path(forResource:"tibetan_gong", ofType:"mp3")!




    private let width: Double = 250
    
    
    func triggerAlertSound(){
        do {
            let url = URL(fileURLWithPath: location)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            audioPlayer?.numberOfLoops = -1;
            AudioServicesPlaySystemSound(1520) // Actuate "Nope" feedback (series of three weak booms)

        } catch {
            // couldn't load file :(
        }
    }
    
    
    var body: some View {
        ZStack {
            VStack{
                IcebergDynamicView(offsetY:$waterOffset)
                    Text("Tap twice to exit the plunge")
                        .transition(.opacity)
                        .font(.system(size:20))
                        .foregroundColor(showText ? .yellow : .gray)
                TimerView()
            }
            .onAppear(perform:{
                self.waterOffset = 0
                timerModel.start(seconds:timerModel.seconds)
                timerModel.updateCountdown()
                
                timerCancellable = timer.sink { _ in
                    // If timer ended and clean_up not done
                    if timerModel.totalSeconds == 0 && !performOnce {
                        // Submit the plunge session to local
                        if(isCelsius){
                            session = PlungeSession(minutes: timerModel.minutesElapsed, seconds: timerModel.secondsElapsed, celsius: 4.0)
                        }
                        else{
                            session = PlungeSession(minutes: timerModel.minutesElapsed, seconds: timerModel.secondsElapsed, farenheight: 42.0)
                        }

                        // Flag as submitted
                        performOnce = true
                        
                        // Start playing the alert sound in a loop and show the alert.
                        self.triggerAlertSound()
                        self.isPlayingAlertSound = true
                        self.showAlert = true
                    } else if !cancelled {
                        timerModel.updateCountdown()
                        self.waterOffset = CGFloat(normalizeOffset(timerModel: timerModel))
                    }
                }
            })
                
            .onDisappear(perform: {
                timerModel.reset()
                timerModel.updateCountdown()
            })
            
            .onReceive(timer){_ in
                timerModel.updateCountdown()
                self.waterOffset = CGFloat(normalizeOffset(timerModel: timerModel) )
            }
            .navigationBarBackButtonHidden(true)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Timer Finished"),
                  message: Text("Your plunge has completed."),
                  dismissButton:
                    .default(Text("Finish")) {
                      self.isPlayingAlertSound = false
                      self.showAlert = false
                      // release system audio
                      audioPlayer?.stop()
                      path.append("PlungeComplete")
                  })
        }
        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    tapCount += 1
                    if tapCount == 1 {
                        withAnimation {
                            showText = true
                        }
                        // Reset tapCount and hide text after 3 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                showText = false
                            }
                            tapCount = 0
                        }
                    } else if tapCount == 2 {
                        cancelled = true
                        if(isCelsius){
                            session = PlungeSession(minutes: timerModel.minutesElapsed, seconds: timerModel.secondsElapsed, celsius: 4.0)
                        }
                        else{
                            session = PlungeSession(minutes: timerModel.minutesElapsed, seconds: timerModel.secondsElapsed, farenheight: 42.0)
                        }
                        path.append("PlungeComplete")
                    }
                })
    }

}

struct PlungeTimerView_Previews: PreviewProvider {
    static var timerModel = TimerModel()

    static var previews: some View {
        PlungeTimerView( isCelsius: .constant(true),path: .constant(["Home","Init"]),inNestedView: .constant(true), session: .constant(PlungeSession(minutes: 1, seconds: 2, celsius: 4)))
            .environmentObject(timerModel)
    }
}
