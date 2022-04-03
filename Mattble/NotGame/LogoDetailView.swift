//
//  LogoDetailView.swift
//  Mattble
//
//  Created by Tom Ryan on 03/04/2022.
//

import SwiftUI

struct LogoDetailView: View {
    var logo: Logo
    var body: some View {
        VStack {
            CircleImage(image: logo.image)
                .image.resizable()
                .frame(width: 370, height: 370)

            VStack(alignment: .leading) {
                Text(logo.name)
                    .font(.largeTitle)
                Divider()
                    .offset(y: -20)
                    .padding(.bottom, -20)
                
                Text(logo.desc)
            }
            .offset(y: -55)
            .padding(.bottom, -55)
           
            
            Spacer()
        }
        .padding()
        
    }
}

struct LogoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LogoDetailView(logo: logos[0])
    }
}
