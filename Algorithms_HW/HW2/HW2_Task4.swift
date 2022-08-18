//
//  HW2_Task4.swift
//  Algorithms_HW2
//
//  Created by Serhii Haponov on 17.08.2022.
//

import Foundation


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

   fileprivate enum RadianConstants {
       static let terms = 15
       static let N = 10000
    }
    
    
   fileprivate struct RadianDataSource {
        static func genarage() -> [Float] {
            var radians: [Float] = []
            
            for _ in 0..<RadianConstants.N {
                radians.append(Float.random(in: 0..<1))
            }
            return radians
        }
    }

struct HW2_Task4 {
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
    
private extension HW2_Task4 {
    
@discardableResult func sinx(terms: Int, x: [Float]) -> [Float] {
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

    
@discardableResult func sinxOptimized(terms: Int, x: [Float]) -> [Float] {
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
}
