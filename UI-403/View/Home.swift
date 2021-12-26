//
//  Home.swift
//  UI-403
//
//  Created by nyannyan0328 on 2021/12/26.
//

import SwiftUI
import RealmSwift

struct Home: View {
    
    @ObservedResults(TaskItem.self, sortDescriptor: SortDescriptor.init(keyPath: "taskDate",ascending: false)) var taskFetched
    
    
    @State var lastAddedTaskID : String = ""

    var body: some View {
        NavigationView{
            
            ZStack{
                
                if taskFetched.isEmpty{
                    
                    Text("Add to Task")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.gray)
                    
                }
                
                else{
                    
                    List{
                        
                        
                        ForEach(taskFetched){task in
                            
                            
                            TaskRowView(taskItem: task, lastAddedTaskID: $lastAddedTaskID)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    
                                    
                                    Button(role: .destructive) {
                                        
                                        $taskFetched.remove(task)
                                        
                                        
                                    } label: {
                                        
                                        Image(systemName: "trash")
                                        
                                        
                                    }

                                    
                                    
                                }
                            
                            
                        }
                        
                        
                        
                    }
                    .listStyle(.insetGrouped)
                    .animation(.spring(), value: taskFetched)
                }
                
                
                
                
            }
            .navigationTitle("Realme")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        
                        let task = TaskItem()
                        lastAddedTaskID = task.id.stringValue
                        $taskFetched.append(task)
                        
                        
                    } label: {
                        
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.black)
                            .blur(radius: 1)
                    }

                    
                    
                }
                
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                
                
            lastAddedTaskID = ""
                
                
                guard let last = taskFetched.last else{return}
                
                
                if last.taskTitle == ""{
                    
                    $taskFetched.remove(last)
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct TaskRowView : View{
    
    @ObservedRealmObject var taskItem : TaskItem
    
    @Binding var lastAddedTaskID : String
    @FocusState var showKey : Bool
    var body: some View{
        
        HStack(spacing:15){
            
            
            Menu {
                
                Button("Missed"){
                    
                    $taskItem.taskStatus.wrappedValue = .missed
                    
                    
                }
                
                Button("Completed"){
                    
                    $taskItem.taskStatus.wrappedValue = .completed
                    
                    
                    
                }
                
                
            } label: {
                
                
                Circle()
                    .stroke(.gray)
                    .frame(width: 16, height: 16)
                    .overlay(
                    
                    Circle()
                        .fill(taskItem.taskStatus == .missed ? .red : (taskItem.taskStatus == .pending ? .yellow : .gray))
                    
                    )
                
                
                
                
            }
            
            
            VStack(alignment: .leading, spacing: 13) {
                
                
                TextField("kavsoft", text: $taskItem.taskTitle)
                    .focused($showKey)
                
                
                if taskItem.taskTitle != ""{
                    
                    
                    Picker(selection: $taskItem.taskDate) {
                        
                        
                        DatePicker(selection: $taskItem.taskDate, displayedComponents: .date) {
                            
                            
                            
                        }
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .navigationTitle("Picker")
                        
                        
                    } label: {
                        
                        HStack{
                            
                            
                            Image(systemName: "calendar")
                                .font(.system(size: 13, weight: .semibold))
                            
                            
                            Text(taskItem.taskDate.formatted(date: .numeric, time: .omitted))
                            
                            
                        }
                        
                        
                        
                    }

                    
                    
                    
                }
                
                
            }
            
            
            

            
        }
        .onAppear {
            if lastAddedTaskID == taskItem.id.stringValue{
                
                showKey.toggle()
            }
            
        }
    }
}
