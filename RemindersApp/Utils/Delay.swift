//
//  Delay.swift
//  Reminders
//
//  Created by Mohammad Azam on 12/15/21.
//

import Foundation

class Delay {
    
    private var seconds: Double
    
    init(_ seconds: Double = 1.0) {
        self.seconds = seconds
    }
    
    var workItem: DispatchWorkItem?
    
    func performWork(_ work: @escaping () -> Void) {
        workItem = DispatchWorkItem(block: {
            work()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: workItem!)
    }
    
    func cancel() {
        workItem?.cancel()
    }
    
}
