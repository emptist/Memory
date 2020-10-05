//
//  Array+Indentifiable.swift
//  Memory
//
//  Created by jk on 2020/6/4.
//  Copyright © 2020 ssl. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching:Element) -> Optional<Int> {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
    
}
