//
//  main.swift
//  3. Mull It Over
//
//  Created by Konstantin Mishukov on 03.12.2024.
//

import Foundation

let regex = "\\(\\d{1,3},\\d{1,3}\\)"

func main() {
    findMuls() // Part 1
    findMuls2() // Part 2
}

private func findMuls() {
    //let input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
    let input = Input.text

    let regexPattern = "mul\\(\\d{1,3},\\d{1,3}\\)"

    do {
        let regex = try NSRegularExpression(pattern: regexPattern)
        let matches = regex.matches(in: input, range: NSRange(input.startIndex..., in: input))
        let instructions = matches.compactMap { match -> String? in
            guard let range = Range(match.range, in: input) else { return nil }
            return String(input[range])
        }

        let sum = instructions.map { instruction in
            let numbers = instruction.replacingOccurrences(of: "mul(", with: "")
                .replacingOccurrences(of: ")", with: "")
                .components(separatedBy: ",")
            return numbers.compactMap { Int($0) }.reduce(1, *)
        }

        print(sum.reduce(0, +))
    } catch {
        print("Error: \(error)")
    }
}

// Part 2
private func findMuls2() {
    let regexPattern = "mul\\(\\d{1,3},\\d{1,3}\\)|don't\\(\\)|do\\(\\)"

//    let input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
    let input = Input.text

    do {
        let regex = try NSRegularExpression(pattern: regexPattern)
        let matches = regex.matches(in: input, range: NSRange(input.startIndex..., in: input))
        let instructions = matches.compactMap { match -> String? in
            guard let range = Range(match.range, in: input) else { return nil }
            return String(input[range])
        }
        execute(instructions: instructions)
    } catch {
        print("Error: \(error)")
    }
}

private func execute(instructions: [String]) {
    var shouldExecute = true
    var sum = 0

    for instruction in instructions {
        if instruction == "do()" {
            shouldExecute = true
            continue
        } else if instruction == "don't()" {
            shouldExecute = false
            continue
        }

        guard shouldExecute else { continue }

        sum += executeMul(instruction)
    }
    print(sum)
}

private func executeMul(_ mulFunction: String) -> Int {
    let numbers = mulFunction.replacingOccurrences(of: "mul(", with: "")
        .replacingOccurrences(of: ")", with: "")
        .components(separatedBy: ",")
    return numbers.compactMap { Int($0) }.reduce(1, *)
}

main()
