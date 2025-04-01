//
//  DataModals.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-30.
//

import Foundation
class SessionManager: ObservableObject {
    @Published var name: String? = nil
    @Published var role: String? = nil
    @Published var token: String? = nil
}

struct DocId: Codable,Hashable {
    var id: Int
}
