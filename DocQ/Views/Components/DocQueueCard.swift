//
//  DocQueueCard.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//




//
//  BookDocCard.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-25.
//

import SwiftUI

struct DocQueueCard: View {
    let imageUrl = URL(string: "https://picsum.photos/400/300")
    var body: some View {
        
        VStack{
            HStack{
                if #available(iOS 15.0, *) {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView() // Optional loading indicator
                    }
                    .frame(width: 120, height: 120,alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                } else {
                    // Fallback on earlier versions
                }
                VStack{
                    Text("Doctor Name").bold().padding().frame(width:180,alignment: .leading)
                    Text("Category").padding(.leading).frame(width:180,alignment: .leading)
                    Text("Status").padding(.leading).frame(width:180,alignment: .leading)
                }
            }
            InverseCustomButton(title:"View Patient Details"){}
        }.frame(width:300).padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}

#Preview {
    DocQueueCard()
}
