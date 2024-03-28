//
//  CreateView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 13/1/24.
//

import SwiftUI

struct CreateView: View {
    
    @EnvironmentObject var dayPlanner: DayPlanner
    @State private var showWhatView: Bool = true
    
    var body: some View {
        VStack{
            HeaderView()
                .padding()
            
            Divider()
            
            if showWhatView{
                WhatView(showWhatView: $showWhatView)
                    .padding()
            } else {
                TaskField(dayPlanner.taskDescription)
                    .padding()
            }
            
            Spacer()
        }
    }
}

struct HeaderView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack{
            Text("Create Task")
            Spacer()
            Image(systemName: "xmark")
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
        }
        .font(.title)
        .fontWeight(.bold)
    }
}

struct WhatView: View {
   
    @EnvironmentObject var dayPlanner: DayPlanner
    @Binding var showWhatView: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            Text("What?")
                .font(.title2)
            
            TaskField(dayPlanner.taskDescription)
            
            Spacer()
                        
            Button(action: {
                showWhatView.toggle()
            }) {
                Text("Continue")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .buttonStyle(.bordered)
        }
    }
}

struct TaskField: View {
    @EnvironmentObject var dayPlanner: DayPlanner
    @State private var activity: String = ""
    
    init(_ activity: String) {
        _activity = State(initialValue: activity)
    }
    
    var body: some View {
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 50, height: 50)
                Image(systemName: "at")
                    .foregroundColor(.gray)
                    .imageScale(.large)
            }
            .shadow(radius: 5)
            
            VStack {
                TextField("Answer Email", text: $activity)
                    .font(.title2)
                Divider()
            }
            .padding(.leading)
        }
        .onChange(of: activity) { descrip in
            dayPlanner.taskDescription = descrip
        }
    }
}

#Preview {
    CreateView()
}






