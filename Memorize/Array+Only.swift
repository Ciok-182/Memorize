//
//  Array+Only.swift
//  Memorize
//
//  Created by Jorge Encinas on 22/08/21.
//  Copyright © 2021 Jorge Encinas. All rights reserved.
//

import Foundation

extension Array{
    var only: Element? {
        count == 1 ? first : nil
    }
}
