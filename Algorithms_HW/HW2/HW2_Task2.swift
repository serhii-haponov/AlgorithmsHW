//
//  HW2_Task2.swift
//  Algorithms_HW2
//
//  Created by Serhii Haponov on 17.08.2022.
//

import Foundation

// MARK: - Task 2
//2) Javelin важить Х кг, NLAW - Y кг, Bayraktar - Z кг.
//Напишіть програму яка визначить скільки різних варіантів “подарунків” для русні вагою рівно W кг може зробити NATO. На вхід подається чотири цілих числа X, Y, Z та W (1 ≤ X, Y, Z ≤ 100, 1 ≤ W ≤ 1000))
//Вхід
//10 25 15 40
//Вихід містить одне ціле число – кількість варіантів подарунків
//3

fileprivate struct WeaponDelivery {
    let Javelin: Int
    let NLAW: Int
    let Bayraktar: Int
    let totalWeight: Int
}

fileprivate struct DeliveryDataSource {
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


struct HW2_Task2 {
    func startCalculateNumberVariety() {
//        let ds = DeliveryDataSource.genarate()
        let defaultDS = DeliveryDataSource.defaultValue()
        let veriery = calculateWeaponVariety(weaponDelivery: defaultDS)
        print(veriery)
    }
}

fileprivate extension HW2_Task2 {
    
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
}
