//
//  Grid.swift
//  RopeBridge
//
//  Created by Konstantin Mishukov on 20.12.2022.
//

import Foundation

final class Grid {
    private let startCoord = Coordinate(0,0)

    private var headCoord: Coordinate
    private var tailCoord: Coordinate
    private var tailTrace: Set<Coordinate>

    private let rope: Knot

    init() {
        self.headCoord = startCoord
        self.tailCoord = startCoord
        self.tailTrace = [startCoord]

        self.rope = Knot(id: 0, coordinate: Coordinate(0,0), next: nil)
    }

    // MARK: Interface

    func doMotions(_ motions: [Motion]) {
        for motion in motions {
            doMotion(motion)
        }
    }

    func traceCount() -> Int {
        tailTrace.count
    }

    // MARK: - Private

    private func doMotion(_ motion: Motion) {
        for _ in 0..<motion.steps {
            moveHead(motion.direction)
            moveTailIfNeeded()
        }
    }

    private func moveHead(_ direction: MotionDirection) {
        switch direction {
        case .up:
            headCoord = Coordinate(headCoord.x, headCoord.y + 1)
        case .right:
            headCoord = Coordinate(headCoord.x + 1, headCoord.y)
        case .left:
            headCoord = Coordinate(headCoord.x - 1, headCoord.y)
        case .down:
            headCoord = Coordinate(headCoord.x, headCoord.y - 1)
        }
    }

    private func moveTailIfNeeded() {
        guard !tailCoord.inTouchWith(headCoord) else { return }

        let sameColumn = headCoord.x == tailCoord.x
        let sameRow = headCoord.y == tailCoord.y

        if sameColumn {
            tailCoord = Coordinate(tailCoord.x, tailCoord.y + (headCoord.y > tailCoord.y ? 1 : -1))
        } else if sameRow {
            tailCoord = Coordinate(tailCoord.x + (headCoord.x > tailCoord.x ? 1 : -1), tailCoord.y)
        } else {
            tailCoord = Coordinate(tailCoord.x + (headCoord.x > tailCoord.x ? 1 : -1), tailCoord.y + (headCoord.y > tailCoord.y ? 1 : -1))
        }

        tailTrace.insert(tailCoord)
    }

    // MARK: - Part 2

    init(numberOfKnots: Int) {
        self.headCoord = startCoord
        self.tailCoord = startCoord
        self.tailTrace = [startCoord]

        self.rope = Knot(id: 0, coordinate: Coordinate(0,0), next: nil)
        var lastKnot = self.rope
        for i in 1..<numberOfKnots {
            let knot = Knot(id: i, coordinate: startCoord, next: nil)
            lastKnot.next = knot
            lastKnot = knot
        }
    }

    func applyMotions(_ motions: [Motion]) {
        for motion in motions {
            applyMotion(motion)
        }
    }

    private func applyMotion(_ motion: Motion) {
        for _ in 0..<motion.steps {
            moveRope(motion.direction)
        }
    }

    private func moveRope(_ direction: MotionDirection) {
        switch direction {
        case .up:
            rope.coordinate = Coordinate(rope.coordinate.x, rope.coordinate.y + 1)
        case .right:
            rope.coordinate = Coordinate(rope.coordinate.x + 1, rope.coordinate.y)
        case .left:
            rope.coordinate = Coordinate(rope.coordinate.x - 1, rope.coordinate.y)
        case .down:
            rope.coordinate = Coordinate(rope.coordinate.x, rope.coordinate.y - 1)
        }
        if let next = rope.next {
            moveKnotIfNeeded(knot: next, after: rope)
        }
    }

    private func moveKnotIfNeeded(knot: Knot, after: Knot) {
        let headCoord = after.coordinate
        let tailCoord = knot.coordinate

        guard !tailCoord.inTouchWith(headCoord) else { return }

        let sameColumn = headCoord.x == tailCoord.x
        let sameRow = headCoord.y == tailCoord.y

        if sameColumn {
            knot.coordinate = Coordinate(tailCoord.x, tailCoord.y + (headCoord.y > tailCoord.y ? 1 : -1))
        } else if sameRow {
            knot.coordinate = Coordinate(tailCoord.x + (headCoord.x > tailCoord.x ? 1 : -1), tailCoord.y)
        } else {
            knot.coordinate = Coordinate(tailCoord.x + (headCoord.x > tailCoord.x ? 1 : -1), tailCoord.y + (headCoord.y > tailCoord.y ? 1 : -1))
        }

        if let next = knot.next {
            moveKnotIfNeeded(knot: next, after: knot)
        } else {
            tailTrace.insert(knot.coordinate)
        }
    }
}
