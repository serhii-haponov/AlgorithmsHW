//
//  ViewController.swift
//  Algorithms_HW2
//
//  Created by Serhii Haponov on 13.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Execution
    override func viewDidLoad() {
        super.viewDidLoad()
//        startCalculateBigestPrimeter()
//        startCalculateNumberVariety()
        startMesureImageHandlerFunc()
//        startMesureCalculateSinX()
    }
    
    // MARK: - Tools
    func measureTime(for closure: () -> Void) {
        let start = CFAbsoluteTimeGetCurrent()
        closure()
        let diff = CFAbsoluteTimeGetCurrent() - start
        print("Took \(diff) seconds")
    }
}

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
fileprivate extension ViewController {
    
    struct Coordinate {
        let x: Int
        let y: Int
    }

    struct CoordinatesDataSourse {
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
    
    func perimeter(a: Coordinate, b: Coordinate, c: Coordinate) -> Double {
         let ab = calculateDistance(point1: a, point2: b)
         let bc = calculateDistance(point1: b, point2: c)
         let ac = calculateDistance(point1: a, point2: c)
        
         return ab + bc + ac
     }
     
    func perimeterDescription(perimeter: Double) -> String {
         return String(format: "%.14f", perimeter)
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
    
    func startCalculateBigestPrimeter() {
//        let coordinates = CoordinatesDataSourse.genarage(amount: 10)
        let coordinates = CoordinatesDataSourse.defaultValue()

        let bigestPrimeter = bigestPrimeter(coordinates: coordinates)
        print(perimeterDescription(perimeter: bigestPrimeter))
    }
}

// MARK: - Task 2
//2) Javelin важить Х кг, NLAW - Y кг, Bayraktar - Z кг.
//Напишіть програму яка визначить скільки різних варіантів “подарунків” для русні вагою рівно W кг може зробити NATO. На вхід подається чотири цілих числа X, Y, Z та W (1 ≤ X, Y, Z ≤ 100, 1 ≤ W ≤ 1000))
//Вхід
//10 25 15 40
//Вихід містить одне ціле число – кількість варіантів подарунків
//3
fileprivate extension ViewController {
    struct WeaponDelivery {
        let Javelin: Int
        let NLAW: Int
        let Bayraktar: Int
        let totalWeight: Int
    }
    
    struct DeliveryDataSource {
        static func genarate() -> WeaponDelivery {
            let Javelin = Int.random(in: 1...100)
            let NLAW = Int.random(in: 1...100)
            let Bayraktar = Int.random(in: 1...100)
            let totalWeight = Int.random(in: 1...1000)
            
            return WeaponDelivery(Javelin: Javelin,
                                  NLAW: NLAW,
                                  Bayraktar: Bayraktar,
                                  totalWeight: totalWeight)
        }
        
        static func defaultValue() -> WeaponDelivery {
            return WeaponDelivery(Javelin: 25,
                                  NLAW: 10,
                                  Bayraktar: 24 ,
                                  totalWeight: 768)
        }
    }
    
    func calculateWeaponVariety(weaponDelivery: WeaponDelivery) -> Int { // W == 1000 => 10^6 operations
        let totalWeight = weaponDelivery.totalWeight
        let Bayraktar = weaponDelivery.Bayraktar
        let NLAW = weaponDelivery.NLAW
        let Javelin = weaponDelivery.Javelin
        
        var varietyNum = 0
        
        var i = 0
        while i <= totalWeight {
            if i == totalWeight {
                varietyNum += 1
                break
            }
            var j = 0
            let iRemainWeight = totalWeight - i
            while j <= iRemainWeight {
                if j == iRemainWeight {
                    varietyNum += 1
                    break
                }

                let jRemainWeight = iRemainWeight - j
                if jRemainWeight % Javelin == 0 {
                    varietyNum += 1
                }
                j += NLAW
            }
            i += Bayraktar
        }
        return varietyNum
    }
    
    func startCalculateNumberVariety() {
//        let ds = DeliveryDataSource.genarate()
        let defaultDS = DeliveryDataSource.defaultValue()
        let veriery = calculateWeaponVariety(weaponDelivery: defaultDS)
        print(veriery)
    }
}

// MARK: - Task 3
//3) Пришвидшіть код який оброблю картинку з рандомними значеннями пікселів
//const int N = 4096;
//byte [,] image = new byte[N, N];
//public bool isDark() {
//    count = 0
//    for (int j = 0; j < N; ++j) {
//        for (int i = 0; i < N; ++i) {
//             if (image[i, j] >= 128) {
//                count += 1;
//            }
//        }
//   }
//
//   return count < N * N / 2;
//}
fileprivate extension ViewController {
    enum ImageConstants {
        static let N = 4096
    }
    
    struct ImageDataSource {
        let N = ImageConstants.N
            
        static func generate() -> [[Int]] {
            let N = 4096
            var image: [[Int]] = Array(repeating: Array(repeating: 0, count: N), count: N)
            
            for j in 0..<N {
                for i in 0..<N {
                    image[j][i] = Int.random(in: 0...255)
                }
            }
            return image
        }
    }
    
    func isDark(image: [[Int]]) -> Bool {
        let N = ImageConstants.N
        var count = 0
        
        var j = 0
        while j < N {
            var i = 0
            while i < N {
                if image[i][j] >= 128 {
                    count += 1
                }
                i += 1
            }
            j += 1
        }
        return count < N * N / 2
    }
    
    func isDarkOptimized(image: [[Int]]) -> Bool {
        let N = ImageConstants.N
        var count = 0
        
        for row in 0..<N {
            for colm in 0..<N {
                let num = image[row][colm] >> 7
                count += num
            }
        }
        return count < N * N / 2
    }

    
    func startMesureImageHandlerFunc() {
        let image = ImageDataSource.generate()
            print("Start:")
            measureTime {
                print("isDark = \(isDark(image: image))")
            }
        
            measureTime {
                print("isDarkOptimized = \(isDarkOptimized(image: image))")
            }
//        Before optimization:
//          Initial:
//          isDark = false
//          Took 0.8521819114685059 seconds
        
//        After optimization: image[i][j] -> image[j][i] - reduce twice cause the cache memory rules
//          Start:
//          isDark = true
//          Took 0.45027804374694824 seconds
    }
}

// MARK: - Task 4
//4) В ігровій індустрії часто доводиться мати справу з тригонометричними ф-ми.
//Ваша задача пришвидшити код який обчислює sin(x) за допомогою ряду Тейлора.
//Типові приклади оптимізацій https://ocw.mit.edu/courses/6-172-performance-engineering-of-software-systems-fall-2018/resources/lecture-2-bentley-rules-for-optimizing-work/.

//void sinx(int N, int terms, float[] x, float[] result) {
//      for (int i = 0; i < N; i++) {
//          float value = x[i];
//          float numer = x[i] * x[i] * x[i];
//          int denom = 6; // 3!
//          int sign = -1;
//          for (int j = 1; j <= terms; j++) {
//               value += sign * numer / denom;
//               numer *= x[i] * x[i];
//               denom *= (2*j+2) * (2*j+3);
//               sign *= -1;
//          }
//          result[i] = value;
//     }
//}
fileprivate extension ViewController {
    enum RadianConstants {
       static let terms = 15
       static let N = 10000
    }
    
    
    struct RadianDataSource {
        static func genarage() -> [Float] {
            var radians: [Float] = []
            
            for _ in 0..<RadianConstants.N {
                radians.append(Float.random(in: 0..<1))
            }
            return radians
        }
    }
    
    func sinx(terms: Int, x: [Float]) -> [Float] {
        let N = RadianConstants.N
        var result: [Float] = []
        for i in 0..<N {
            var value: Float = x[i]
            var numer: Float = x[i] * x[i] * x[i]
            var denom: Float = 6 //3!
            var sign: Float = -1
            
            for j in 1...terms {
                value += sign * numer / denom
                numer *= x[i] * x[i]
                sign *= -1
                denom *= Float((2 * j + 2) * (2 * j + 3))
            }
            result.append(value)
        }
        return result
    }

//    1. винесіть кешування за межі циклу for j
//    2. винесіть ділення за межі циклу for j
//    3. numer *= x[i] * x[i] можна закешувати
//    4. sign *= -1 можна швидше і теж за межами циклу по j

    
    func sinxOptimized(terms: Int, x: [Float]) -> [Float] {
        let N = RadianConstants.N
        var result: [Float] = []
        
        var denomValues: [Float] = [-6]
        for d in 1...terms  {
            let denom = -1 /  denomValues[d - 1] * Float((2 * d + 2) * (2 * d + 3))
            denomValues.append(denom)
        }
        
        for i in 0..<N {
            var value: Float = x[i]
            let numerXnumer = x[i] * x[i]
            var numer: Float = x[i] * x[i] * x[i]
            
            for j in 1...terms {
                value +=  numer * denomValues[j]
                numer *= numerXnumer
            }
            result.append(value)
        }
        return result
    }
    
    func startMesureCalculateSinX() {
        let x = RadianDataSource.genarage()
        measureTime {
            sinx(terms: RadianConstants.terms, x: x)         // Took 0.03337204456329346 seconds
        }
                                                                //diff 0.0013 => 4%
        measureTime {
            sinxOptimized(terms: RadianConstants.terms, x: x)// Took 0.032032012939453125 seconds
        }
    }
}
