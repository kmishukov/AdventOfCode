//
//  mapper.swift
//  2. Red-Nosed Reports
//
//  Created by Konstantin Mishukov on 02.12.2024.
//

import Foundation

final class DataMapper {
    static func mapInputs(_ input: String) -> ([[Int]]) {
        let lines = input.components(separatedBy: "\n")
        var reports: [[Int]] = []
        for line in lines {
            let report = line.components(separatedBy: " ").compactMap { Int($0) }
            reports.append(report)
        }
        return reports
    }
}
