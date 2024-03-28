//
//  ContentView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 12/1/24.
//

import SwiftUI



struct MainView: View {
    
    @ObservedObject var dayPlanner = DayPlanner()
    
    var body: some View {
        
        let mondayOfTheCurrentDate = dayPlanner.starDateOfWeek(from: dayPlanner.currentDate)
        
        ZStack(alignment: .bottomTrailing) {
            VStack{
                HStack{
                    Text(mondayOfTheCurrentDate.monthYYYY())
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    HStack{
                        Image(systemName: "calendar")
                        Image(systemName: "tray.fill")
                        Image(systemName: "gear")
                    }
                    .font(.title)
                }
                .padding([.top, .trailing, .leading])
                
                
                SwipeableStack(dayPlanner.startDateOfWeekInAYear(),
                               jumpTo: mondayOfTheCurrentDate) { (date, pos)  in
                    WeekView(of: date, viewPosition: pos)
                }
                               .frame(maxHeight: 100)
                
                SwipeableStack([1,2,3], jumpTo: 2) { (_, _) in
                    DayView()
                }
            }
            CreateButton()
        }
        .environmentObject(dayPlanner)
    }
}

struct SwipeableStack<WhateverTypeOfData: Hashable, Content>: View where Content: View {
    
    var whateverData: [WhateverTypeOfData] = []
    let content: (WhateverTypeOfData, ViewPosition) -> Content
    var jumpTo: WhateverTypeOfData?
    
    init(_ data: [WhateverTypeOfData], 
         jumpTo: WhateverTypeOfData? = nil,
         @ViewBuilder content: @escaping (WhateverTypeOfData, ViewPosition) -> Content) {
        
        self.whateverData = data
        self.content = content
        if let jumpTo {
            self.jumpTo = jumpTo
        }
    }
    
    @State private var dataIndex = 0
    @State private var dragged = CGSize.zero
    
    var previousExist: Bool {
        return (dataIndex - 1) >= 0
    }
    
    var nextExist: Bool {
        return dataIndex < whateverData.count - 1
    }
    
    var body: some View {
        GeometryReader{ geo in
            let frameWidth = geo.size.width
            
            HStack(spacing: 0) {
                if previousExist{
                    content(whateverData[dataIndex - 1], .previusView) //previus
                        .frame(width: frameWidth)
                        .offset(x: previousExist ? -frameWidth : 0)
                }
                content(whateverData[dataIndex], .centerView) // Current
                    .frame(width: frameWidth)
                    .offset(x: previousExist ? -frameWidth : 0)
                if nextExist {
                    content(whateverData[dataIndex + 1], .nextView) //next
                        .frame(width: frameWidth)
                        .offset(x: previousExist ? -frameWidth : 0)
                }
            }
            .onAppear {
                if let jumpTo {
                    if let position = whateverData.firstIndex(of: jumpTo) {
                        dataIndex = position
                    }
                }
            }
            .offset(x: dragged.width)
            .gesture(DragGesture()
                .onChanged { value in
                    dragged.width = value.translation.width
                }
                .onEnded { value in
                    var indexOffset = 0
                    withAnimation(.easeInOut(duration: 0.3)) {
                        dragged = CGSize.zero
                        if value.predictedEndTranslation.width < -frameWidth / 2 && nextExist {
                            dragged.width = -frameWidth
                            indexOffset = 1 // Next
                        }
                        if value.predictedEndTranslation.width > frameWidth / 2 && previousExist {
                            dragged.width = frameWidth
                            indexOffset = -1 // Next
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        dataIndex += indexOffset
                        dragged = CGSize.zero
                    }
                }
            )
        }
    }
}

enum ViewPosition {
    case centerView
    case previusView
    case nextView
}

struct WeekView: View {
    @EnvironmentObject var dayPlanner: DayPlanner
    let date: Date
    let week = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    var viewPosition = ViewPosition.centerView
    
    init(of date: Date, viewPosition: ViewPosition) {
        self.date = date
        self.viewPosition = viewPosition
    }
    
    var body: some View {
        let datesInAWeek = dayPlanner.datesInAWeek(from: date)
        HStack {
            Spacer()
            ForEach(datesInAWeek.indices, id: \.self) { ind in
                let day = datesInAWeek[ind]
                VStack{
                    Text(week[ind])
                        .padding(.bottom, 5)
                    Text(day.dayNum())
                        .fontWeight(.bold)
                        .foregroundColor(dayPlanner.isCurrent(day) ? Color.white : Color.black)
                        .background(
                            ZStack{
                                if dayPlanner.isCurrent(day) {
                                    Circle()
                                        .fill(.primary)
                                        .frame(width: 30, height: 30)
                                }
                                
                            }
                        )
                }
                .onTapGesture {
                    dayPlanner.setCurrentDate(to: day)
                }
                Spacer()
            }
        }
        .onChange(of: date) { day in
            if viewPosition == .centerView {
                let position = dayPlanner.currentPositionInWeek()
                let datesInAWeek = dayPlanner.datesInAWeek(from: day)
                dayPlanner.setCurrentDate(to: datesInAWeek[position])
            }
        }
    }
    
}

struct CreateButton: View {
    
    @State private var isPresented = false
    
    var body: some View {
        Button(action: {
            self.isPresented.toggle()
        }){
            ZStack{
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.green)
                Image(systemName: "plus")
                    .imageScale(.large)
                    .foregroundColor(.white)
            }
        }
        .padding()
        .sheet(isPresented: $isPresented, content: {
            CreateView()
        })
    }
}

struct DayView: View {
    var body: some View {
        ZStack(alignment: .topLeading){
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.yellow)
                .ignoresSafeArea()
            LazyVStack(spacing: 0){
                ForEach(testTask, id: \.self) { myTask in
                    TaskView(for: myTask)
                }
            }
            .padding()
        }
    }
}

struct TaskView: View {
    
    private var task: Task
    
    init(for task: Task) {
        self.task = task
    }
    
    var body: some View {
        HStack{
            Text("6:00 am")
            VStack(spacing: 0){
                ZStack{
                    Circle()
                        .fill(Color.white)
                        .frame(width: 50, height: 50)
                    Image(systemName: "at")
                        .foregroundColor(.black)
                        .imageScale(.large)
                }
                Rectangle()
                    .fill(.black)
                    .frame(width: 3)
            }
            Text(task.taskDescription)
            Spacer()
            Image(systemName: "checkmark")
                .padding(5)
                .background(Color.white, in: Circle())
        }
    }
    
}

#Preview {
    MainView()
}




