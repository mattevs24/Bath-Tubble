//
//  LeaderboardList.swift
//  Mattble
//
//  Created by Tom Ryan on 02/04/2022.
//

import SwiftUI

struct LeaderboardList: View {
    var result = winners.sorted {
        $0.score > $1.score
    }
    var body: some View {
        NavigationView {
            List(result.indices, id: \.self) {index in
                LeaderboardRow(winner: result[index], place: index+1)
            }
                .navigationTitle("Leaderboard")
        }
    }
}

struct LeaderboardList_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardList()
    }
}
