//
//  Notification.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//

//
//  PatientCard.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//

import SwiftUI

struct Notification: View {
    var body: some View {
        HStack{
            ScrollView(.vertical, showsIndicators: false) {
                HStack{
                    Circle().fill(.yellow).frame(width:50,height:50).overlay(Text("A")                    .font(.system(size: 32, weight: .bold)) // Custom font size and weight
                    ).padding()
                    VStack{
                        Text("Title").bold()
                      Text("message")
                    }
                    Spacer()
                }
                Divider()
                    .frame(height: 1)
                    .background(Color.gray.opacity(0.4))
                
                
                
                
            }
        }.padding()
    }
}

#Preview {
    Notification()
}
