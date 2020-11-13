//
//  Array+Only.swift
//  Memorize
//
//  Created by Александр Фомичев on 14.11.2020.
//  Copyright © 2020 Fomichev Alexander. All rights reserved.
//

import Foundation

extension Array{
    var only: Element? {
        count == 1 ? first:nil
    }
}
