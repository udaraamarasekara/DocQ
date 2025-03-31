//
//  DataModals.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-30.
//

import Foundation
import CoreData
class SessionManager: ObservableObject {
    @Published var name: String? = nil
    @Published var role: String? = nil
    @Published var token: String? = nil
}


@objc(Appointment)
public class InOutAt: NSManagedObject{}

extension InOutAt {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<InOutAt> {
        return NSFetchRequest<InOutAt>(entityName: "Appointment")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var inAt: String?
}
