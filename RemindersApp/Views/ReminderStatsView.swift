//
//  ReminderStatsView.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/15/23.
//

import SwiftUI

struct ReminderStatsView: View {
    
    let icon: String
    let title: String
    var count: Int?
    var iconColor: Color = .blue
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Image(systemName: icon)
                        .foregroundColor(iconColor)
                        .font(.title)
                    Text(title)
                        .opacity(0.8)
                }
                Spacer()
                if let count {
                    Text("\(count)")
                        .font(.largeTitle)
                }
               
            }.padding()
            
        }.frame(maxWidth: .infinity)
            .background(colorScheme == .dark ? Color.darkGray: Color.offWhite)
            .foregroundColor(colorScheme == .dark ? Color.offWhite: Color.darkGray)
            .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
    }
}

struct ReminderStatsView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderStatsView(icon: "calendar", title: "Today", count: 9)
    }
}
