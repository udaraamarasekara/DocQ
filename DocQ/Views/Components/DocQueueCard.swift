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

@available(iOS 16.0, *)
struct DocQueueCard: View {
    @Binding var path:NavigationPath
    var session: DoctorSessionResponse
    var imageUrl: URL? {
        URL(string: "\(Api.imgURL)\(session.image )")
    }

    init(session: DoctorSessionResponse,path:Binding<NavigationPath> ) {
        self.session = session
        _path = path
    }
    
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
                    Text(session.name).bold().padding().frame(width:180,alignment: .leading)
                    Text(session.category).padding(.leading).frame(width:180,alignment: .leading)
                    Text(session.status).padding(.leading).frame(width:180,alignment: .leading)
                }
            }
            InverseCustomButton(title:"View Patient Details"){
                path.append(session)
            }
        }.frame(width:300).padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}
