//
//  Item.swift
//  PlayArchive-SwiftUI-test
//
//  Created by 水原　樹 on 2023/12/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
