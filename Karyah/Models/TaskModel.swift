//
//  TaskModel.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import Foundation

struct TaskModel: Identifiable {
    let id = UUID()
    let title: String
    let count: Int
}
