//
//  Color+Extensions.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/8/23.
//

import Foundation
import SwiftUI

extension Color {
    
    static var primaryBackground: Color {
        Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1) : UIColor(red: 200, green: 200, blue: 200, alpha: 1) })
    }
    
    static var listRowBackground: Color {
        Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(red: 27/255, green: 27/255, blue: 30/255, alpha: 1) : UIColor(red: 200, green: 200, blue: 200, alpha: 1) })
    }
    
    static var secondaryBackground: Color {
        Color(red: 27/255, green: 27/255, blue: 30/255)
    }
    
}
