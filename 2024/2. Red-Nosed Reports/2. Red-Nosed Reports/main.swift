//
//  main.swift
//  2. Red-Nosed Reports
//
//  Created by Konstantin Mishukov on 02.12.2024.
//

import Foundation

func main() {
    let reports = DataMapper.mapInputs(Input.text)
    var safeReports = 0
    for report in reports {
        safeReports += testReport(report: report, part2: false) ? 1 : 0
    }
    print(safeReports)
}

// Part 1
private func testReport(report: [Int], part2: Bool = false) -> Bool {
    let isIncrease = report[1] - report[0] > 0
    var isSafe = true
    for i in 1..<report.count {
        let diff = report[i] - report[i-1]
        guard (diff > 0) == isIncrease,
              abs(diff) >= 1 && abs(diff) <= 3
        else {
            isSafe = part2 ? tryRemovingLevel(report: report) : false
            return isSafe
        }
    }
    return isSafe
}

// Part 2
private func tryRemovingLevel(report: [Int]) -> Bool {
    for i in 0..<report.count {
        var newReport = report
        newReport.remove(at: i)
        if testReport(report: newReport) {
            return true
        }
    }
    return false
}

main()

