//
//  LeaderboardList.swift
//  Mattble
//
//  Created by Tom Ryan on 02/04/2022.
//

import SwiftUI

struct LeaderboardList: View {
    var body: some View {
        List(winners, id: \.score) {winner in
            LeaderboardRow(winner: winner, place: 1)
        }
    }
}

struct LeaderboardList_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardList()
    }
}
