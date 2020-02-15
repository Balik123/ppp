//
//  pseudoaleatorio.swift
//  PPP
//
//  Created by Jose Olvera on 14/02/20.
//  Copyright © 2020 Jose Olvera. All rights reserved.
//

import Foundation

extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
