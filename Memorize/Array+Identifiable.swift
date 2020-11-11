//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Александр Фомичев on 12.11.2020.
//  Copyright © 2020 Fomichev Alexander. All rights reserved.
//

import Foundation

extension Array where Element:Identifiable{
    func firstIndex(matching: Element) -> Int{
        for i in 0..<self.count{
            if self[i].id == matching.id{
                return i
            }
        }
        return 0 //TODO: Bogus
    }
}
