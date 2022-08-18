//
//  Utils.swift
//  Algorithms_HW2
//
//  Created by Serhii Haponov on 18.08.2022.
//

import Foundation

func measureTime(for closure: () -> Void) {
    let start = CFAbsoluteTimeGetCurrent()
    closure()
    let diff = CFAbsoluteTimeGetCurrent() - start
    print("Took \(diff) seconds")
}
