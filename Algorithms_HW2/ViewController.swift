//
//  ViewController.swift
//  Algorithms_HW2
//
//  Created by Serhii Haponov on 13.08.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let coordinates = CoordinatesDataSourse.genarage(amount: 10)
        print(coordinates)
        let bigestPrimeter = bigestPrimeter(coordinates: coordinates)
        print(perimeterDescription(perimeter: bigestPrimeter))
    }

}

// MARK: - Task 1
fileprivate extension ViewController {
    
    struct Coordinate {
        let x: Int
        let y: Int
    }

    struct CoordinatesDataSourse {
        static func genarage(amount: Int) -> [Coordinate] {
            var coordinages: [Coordinate] = []
            for _ in 0...amount {
                let coordinate = Coordinate(x: Int.random(in: 0..<1000), y: Int.random(in: 0..<1000))
                coordinages.append(coordinate)
            }
            return coordinages
        }
    }
    
    func perimeter(a: Coordinate, b: Coordinate, c: Coordinate) -> Double {
         let ab = calculateDistance(point1: a, point2: b)
         let bc = calculateDistance(point1: b, point2: c)
         let ac = calculateDistance(point1: a, point2: c)
        
         return ab + bc + ac
     }
     
    func perimeterDescription(perimeter: Double) -> String {
         return String(format: "%.13f", perimeter)
     }
     
    func calculateDistance(point1: Coordinate, point2: Coordinate) -> Double {
         let distance_2 = Double(((point2.x - point1.x) * (point2.x - point1.x)) +
                           ((point2.y - point1.y) * (point2.y - point1.y)))
         return sqrt(distance_2)
     }
    
    func bigestPrimeter(coordinates: [Coordinate]) -> Double {
        var maxXC: Coordinate = coordinates.first!
        var maxYC: Coordinate = coordinates.first!
        
        var minXC: Coordinate = coordinates.first!
        var minYC: Coordinate = coordinates.first!
        
        for xy in coordinates {
            if xy.x > maxXC.x {
                maxXC = xy
            } else if xy.x < minXC.x {
                minXC = xy
            }
            
            if xy.y > maxYC.y {
                maxYC = xy
            } else if xy.y < minYC.y {
                minYC = xy
            }
        }
        
        let upPeak = perimeter(a: maxXC, b: maxYC, c: minXC)
        let downPeak = perimeter(a: maxXC, b: minYC, c: minXC)
        let leftPeak = perimeter(a: minYC, b: minXC, c: maxYC)
        let rightPeak = perimeter(a: minYC, b: maxXC, c: maxYC)
    
        let perimeters = [upPeak, downPeak, leftPeak, rightPeak]
        
        var bigestPerimeter = upPeak
        
        for per in perimeters where per > bigestPerimeter {
            bigestPerimeter = per
        }
        return bigestPerimeter
    }

}
