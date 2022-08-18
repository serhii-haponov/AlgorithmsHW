//
//  HW2_Task1.swift
//  Algorithms_HW2
//
//  Created by Serhii Haponov on 17.08.2022.
//

import Foundation

// MARK: - Task 1
//1) Програма отримує на вхід набір точок на площині. Напочатку задано кількість точок n (2 < n < 101), далі йде послідовність з n рядків, кожен з яких містить 2 числа - координати точки. Всі координати - це цілі числа не більше 1000. Серед заданих точок знайдіть 3, які утворюють трикутник з максимальним периметром та виведіть його з точністю в 15 значущих цифр.
//Вхід:
//4
//0 0
//0 1
//1 0
//1 1
//Вихід
//3.41421356237309

    
fileprivate struct Coordinate {
        let x: Int
        let y: Int
    }

fileprivate struct CoordinatesDataSourse {
        static func genarage(amount: Int) -> [Coordinate] {
            var coordinages: [Coordinate] = []
            for _ in 0...amount {
                let coordinate = Coordinate(x: Int.random(in: 0...1000), y: Int.random(in: 0...1000))
                coordinages.append(coordinate)
            }
            return coordinages
        }
        
        static func defaultValue() -> [Coordinate] {
            return [Coordinate(x: 0, y: 1),
                    Coordinate(x: 1, y: 1),
                    Coordinate(x: 1, y: 0),
                    Coordinate(x: 0, y: 0)]
        }
    }

 struct HW2_Task1 {
    func startCalculateBigestPrimeter() {
//        let coordinates = CoordinatesDataSourse.genarage(amount: 10)
        let coordinates = CoordinatesDataSourse.defaultValue()
        
        let bigestPrimeter = bigestPrimeter(coordinates: coordinates)
        print(perimeterDescription(perimeter: bigestPrimeter))
    }
}

private extension HW2_Task1 {
    private func perimeter(a: Coordinate, b: Coordinate, c: Coordinate) -> Double {
          let ab = calculateDistance(point1: a, point2: b)
          let bc = calculateDistance(point1: b, point2: c)
          let ac = calculateDistance(point1: a, point2: c)
         
          return ab + bc + ac
      }
      
     private func perimeterDescription(perimeter: Double) -> String {
          return String(format: "%.14f", perimeter)
      }
      
     private func calculateDistance(point1: Coordinate, point2: Coordinate) -> Double {
          let distance_2 = Double(((point2.x - point1.x) * (point2.x - point1.x)) +
                            ((point2.y - point1.y) * (point2.y - point1.y)))
          return sqrt(distance_2)
      }
     
     private func bigestPrimeter(coordinates: [Coordinate]) -> Double {
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
