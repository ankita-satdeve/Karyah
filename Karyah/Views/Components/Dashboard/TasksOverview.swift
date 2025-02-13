//
//  TasksOverview.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct TasksOverview: View {
    let tasks: [TaskModel]

    var body: some View {
        VStack(spacing: 16) {
            Text("Tasks")
                .font(.title2)
                .foregroundColor(.secondary)
            
            Text("04")
                .font(.largeTitle).bold()
                .foregroundColor(.primary)
            
            Divider()
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                ForEach(tasks) { task in
                    TaskInfo(title: task.title, count: "\(task.count)")
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(UIColor.secondarySystemBackground)))
        .padding(.horizontal)
    }
}

struct TaskInfo: View {
    let title: String
    let count: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(count)
                .font(.title3).bold()
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
    }
}

//#Preview() {
//    TasksOverview(tasks: tasks)
//}
