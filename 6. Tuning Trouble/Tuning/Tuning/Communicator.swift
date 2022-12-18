//
//  Communicator.swift
//  Tuning
//
//  Created by Konstantin Mishukov on 18.12.2022.
//

import Foundation

final class Communicator {
    static func detectPacketMarker(signal: String) -> Int {
        let packetMarkerLength = 4
        return detectMarker(signal: signal, startIndex: packetMarkerLength)
    }

    static func detectMessageMarker(signal: String) -> Int {
        let messageMarkerLength = 14
        return detectMarker(signal: signal, startIndex: packetMarkerLength)
    }

    private static func detectMarker(signal: String, startIndex: Int) -> Int {
        var input = signal
        var currentIndex: Int = startIndex
        var packet = (1...startIndex).map { _ in return input.removeFirst() }

        while !isUnique(packet: packet) {
            packet.removeFirst()
            packet.append(input.removeFirst())
            currentIndex += 1
        }

        return currentIndex
    }

    private static func isUnique(packet: [String.Element]) -> Bool {
        var unique: Set<String.Element> = []
        return packet.allSatisfy { unique.insert($0).inserted }
    }
}
