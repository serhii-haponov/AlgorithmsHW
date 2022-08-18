//
//  HW2_Task3.swift
//  Algorithms_HW2
//
//  Created by Serhii Haponov on 17.08.2022.
//

import Foundation

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

fileprivate enum ImageConstants {
        static let N = 4096
    }
    
fileprivate struct ImageDataSource {
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

struct HW2_Task3 {
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
