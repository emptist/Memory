//
//  Array+OnlyOne.swift
//  Memory
//
//  Created by jk on 2020/6/5.
//  Copyright © 2020 ssl. All rights reserved.
//

import Foundation

extension Array {
    var onlyThingOrNil: Element? {
        count == 1 ? first : nil
    }
}
