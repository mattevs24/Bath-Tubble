//
//  Winner.swift
//  Mattble
//
//  Created by Tom Ryan on 02/04/2022.
//

import Foundation
import SwiftUI


struct Winner: Hashable, Codable {
    var id: Int
    var name: String
    var date: String
    var score: Int
    var time: Int
    var cards: Int
    var image: Image {
        Image(name)
    }
}

