//
//  ClinicCard.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-24.
//

import SwiftUI

struct ClinicCard: View {
    private var clinic:ClinicResponse?
    var imageUrl: URL? {
        URL(string: "\(Api.imgURL)\(clinic?.image ?? "")")
    }

    init(clinic:ClinicResponse)
    {
       

        self.clinic = clinic
    }
    var body: some View {
        VStack{
            if #available(iOS 15.0, *) {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView() // Optional loading indicator
                }
                .frame(width: 200, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
            } else {
                // Fallback on earlier versions
            }
            HStack{
                Text(clinic?.name ?? "").padding().frame(width:200,alignment: .leading)
                
            }
        }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}


