//
//  Routes.swift
//  DocQ
//
//  Created by udara prabath on 2025-04-04.
//
import Foundation
enum Route: Hashable {
    case detailsView(ClinicResponse)
    case bookingView(ClinicResponse)
}
