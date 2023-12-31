//
//  MockUpPauseStopwatchViewModel.swift
//  beFLE
//
//  Created by 정회승 on 11/13/23.
//

import SwiftUI

class MockUpPauseStopwatchViewModel: ObservableObject {
    @Published var elapsedTime: TimeInterval = 0
    @Published var isRunning = false
    private var timer: Timer?
    @Published private var startTime = Date.now
    
    func Start() {
        isRunning = true
        
        if isRunning {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                self?.elapsedTime += 1
            }
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func Stop() {
        isRunning = false
        
        if isRunning {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                self?.elapsedTime += 1
            }
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func reset() {
        elapsedTime = 0
            isRunning = false
            timer?.invalidate()
            timer = nil
        }
    
    func bgTimer() -> TimeInterval {
        let curTime = Date.now
        let diffTime = startTime.distance(to: curTime)
        let result = Double(diffTime.formatted())!
        elapsedTime = result + elapsedTime
        
        return elapsedTime
    }
}
