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
//    var priority: Priority? = .normal
    var isComleted: Bool = false
}

//enum Priority: String, CaseIterable, CustomStringConvertible {
//    case normal
//    case medium
//    case high
//    
//    var description: String {
//        switch self {
//        case .normal:
//            return "normal"
//        case .medium:
//            return "medium"
//        case .high:
//            return "high"
//        }
//    }
//}
