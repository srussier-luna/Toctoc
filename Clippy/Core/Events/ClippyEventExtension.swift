//
//  ClippyEventExtension.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

extension ClippyEvent {
    enum Kind: String {
        case promptSubmitted
        case toolFinished
        case questionAsked
        case permissionRequested
        case finished
        case failed
        case sessionEnded
    }
}
