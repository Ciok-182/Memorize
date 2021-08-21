//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Jorge Encinas on 22/06/21.
//  Copyright © 2021 Jorge Encinas. All rights reserved.
//

import Foundation

extension Array where Element : Identifiable{
    func firstIndex(matching: Element) -> Int {
        for index in 0 ..< self.count {
            if self[index].id == matching.id{
                return index
            }
        }
        return 0
    }
}
