//
//  ClaudeSessionFile.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

struct ClaudeSessionFile: Decodable {
    private enum CodingKeys: String, CodingKey {
        case cliSessionID = "cliSessionId"
    }

    let cliSessionID: String
}
