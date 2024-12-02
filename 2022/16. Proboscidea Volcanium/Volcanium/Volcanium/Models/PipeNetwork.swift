//
//  PipeNetwork.swift
//  Volcanium
//
//  Created by Konstantin Mishukov on 16.12.2022.
//

import Foundation

final class PipeNetwork {
    private let valves: [Valve]

    var currentValve: Valve {
        didSet {
            timeTick()
        }
    }

    init(valves: [Valve]) {
        self.valves = valves
        self.currentValve = valves[0]
    }

    private var releasedPressure: Int = 0
    private var currentPressure: Int = 0

    private var timeLeft: Int = 30 {
        didSet { releasedPressure += currentPressure }
    }

    private func openValve() {
        guard !currentValve.isOpen else { fatalError("already opened valve") }
        timeTick()
        currentPressure += currentValve.rate
    }

    private func timeTick() {
        timeLeft -= 1
    }

    // MARK: - Interface
    func mostPressureToRelease() -> Int {
        guard let nextValve = currentValve.connections.sorted(by: { $0.rate > $1.rate }).first else {fatalError("cant find next valve")}
        goToValve(nextValve)
    }

    private func goToValve(_ valve: Valve) {
        currentValve = valve
        if currentValve.rate > 0 && !currentValve.isOpen {
            openValve()
        } else {

        }
    }

}
