//
//  IssueModel.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import Foundation

struct IssueModel: Identifiable {
    let id = UUID()
    let name: String
    let date: String
    let time: String
    let description: String
    let priority: Int
}
