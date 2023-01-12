//
//  ReminderDetailView.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/10/23.
//

import SwiftUI

struct ReminderDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var hasDate: Bool = false
    @State private var hasTime: Bool = false
    
    private var isFormValid: Bool {
        !title.isEmpty
    }
    
    var body: some View {
        VStack {
            List {
                Section {
                    TextField("Reminder Name", text: $title)
                    TextField("Notes", text: $notes)
                }
                Section {
                    Toggle(isOn: $hasDate) {
                        Image(systemName: "calendar")
                            .foregroundColor(.red)
                    }
                    
                    Toggle(isOn: $hasTime) {
                        Image(systemName: "clock")
                            .foregroundColor(.blue)
                    }
                }
            }.listStyle(.insetGrouped)
            
        }.toolbar {
            ToolbarItem(placement: .principal) {
                Text("Details")
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    if isFormValid {
                        
                    }
                }.disabled(!isFormValid)
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}

struct ReminderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReminderDetailView()
                .environment(\.colorScheme, .dark)
        }
    }
}
