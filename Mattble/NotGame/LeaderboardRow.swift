//
//  LeaderboardRow.swift
//  Mattble
//
//  Created by Tom Ryan on 02/04/2022.
//

import SwiftUI

struct LeaderboardRow: View {
    var winner: Winner
    var place: Int
    
    
    var body: some View {
        
        HStack {
            
            Text(String(place))
                .font(.system(size: 25))
                .frame(width: 30, height: 50)
            
            VStack(alignment: .leading) {
                Text(winner.name)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                Text(winner.date)
                    .font(.system(size: 11))
                    .foregroundColor(Color.gray)
                
            }
            Spacer()
            Text("\(winner.score)")
                .font(.system(size: 23))
                .multilineTextAlignment(.trailing)
                .frame(width: 90, alignment: .trailing)
            winner.image
                .resizable()
                .frame(width: 50, height: 50)
        }
    }
}

struct LeaderboardRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LeaderboardRow(winner: winners[0], place: 1).previewLayout(.fixed(width: 300, height: 70))
            LeaderboardRow(winner: winners[1], place: 2).previewLayout(.fixed(width: 300, height: 70))
            LeaderboardRow(winner: winners[2], place: 3).previewLayout(.fixed(width: 300, height: 70))
            LeaderboardRow(winner: winners[3], place: 4).previewLayout(.fixed(width: 300, height: 70))
        }
    }
}
