//
//  main.swift
//  Volcanium
//
//  Created by Konstantin Mishukov on 16.12.2022.
//

import Foundation

func main() {
    let valves: [Valve] = DataMapper.mapValves(input: Input.test)
    let network = PipeNetwork(valves: valves)
    print(network.currentValve.name)
}

main()

