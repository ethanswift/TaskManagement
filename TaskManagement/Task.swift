//
//  Task.swift
//  TaskManagement
//
//  Created by ehsan sat on 12/14/23.
//

import Foundation

struct Task: Identifiable {
    var id: String = UUID().uuidString
    var name: String? = ""
    var title: String? = ""
    var date: String? = ""
    var isComleted: Bool = false
}

