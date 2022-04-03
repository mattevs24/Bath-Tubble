//
//  Logo.swift
//  Mattble
//
//  Created by Tom Ryan on 03/04/2022.
//

import Foundation
import SwiftUI

struct Logo: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var desc: String
    var image: Image {
        Image(String(id))
    }
}
