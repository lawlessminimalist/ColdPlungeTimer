//
//  TimerModel.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 27/4/2023.
//

import Foundation

final class TimerModel: ObservableObject{
    @Published var isActive = false
    @Published var showingAlert = false
    @Published var time: String = "5:00"
    @Published var seconds: Float = 300 {
        didSet{
            self.minutes = floor(seconds/60)
            let temp_secs = (Int(seconds)%60)
            if(temp_secs == 0){self.time = "\(Int(minutes)):\(temp_secs)0"}
            else{self.time = "\(Int(minutes)):\(temp_secs)"}
        }
    }
    @Published var timediff = 0
    
    
    private var minutes:Float = 5.0
    private var initialTime = 0
    private var endDate = Date()
    
    func start(seconds: Float){
        self.initialTime = Int(seconds)
        self.endDate = Date()
        self.isActive = true
        self.endDate = Calendar.current.date(byAdding: .second, value: Int(seconds),to: endDate)!
    }
    
    func reset(){
        self.seconds = Float(initialTime)
        self.isActive = false
        self.time = Int(self.seconds)%60 == 0 ? "\(Int(minutes)):\(Int(seconds)%60)0" : "\(Int(minutes)):\(Int(seconds)%60)"
    }
    
    func quickSet(mins:Float){
        self.seconds = mins*60
        self.isActive = false
        self.time = "\(Int(minutes)):00"
    }
    
    func updateCountdown(){
        guard isActive else {return}
        
        let now = Date()
        let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
        
        if diff <= 0 {
            self.isActive = false
            self.time = "0:00"
            self.showingAlert = true
            return
        }
        
        let date = Date(timeIntervalSince1970: diff)
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        self.seconds = Float(seconds)
        self.time = String(format:"%d:%02d", minutes,seconds)
    }
}

