//
//  LeaderboardRow.swift
//  Mattble
//
//  Created by Tom Ryan on 02/04/2022.
//

import SwiftUI

struct LeaderboardRow: View {
    var winner: Winner
    
    
    var body: some View {
        HStack {
            Text(winner.name)
            Spacer()
        }
    }
}

struct LeaderboardRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LeaderboardRow(winner: winners[0]).previewLayout(.fixed(width: 300, height: 70))
            LeaderboardRow(winner: winners[1]).previewLayout(.fixed(width: 300, height: 70))
            LeaderboardRow(winner: winners[2]).previewLayout(.fixed(width: 300, height: 70))
            LeaderboardRow(winner: winners[3]).previewLayout(.fixed(width: 300, height: 70))
        }
    }
}
