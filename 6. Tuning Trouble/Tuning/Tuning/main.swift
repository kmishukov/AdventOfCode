//
//  main.swift
//  Tuning
//
//  Created by Konstantin Mishukov on 18.12.2022.
//

import Foundation

func main() {
    let packetMarkerIndex = Communicator.detectPacketMarker(signal: Input.text)
    print("Part 1: \(packetMarkerIndex)")

    let messageMarkerIndex = Communicator.detectMessageMarker(signal: Input.text)
    print("Part 2: \(messageMarkerIndex)")
}

main()

