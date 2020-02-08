//
//  stringSeparator.swift
//  PPP
//
//  Created by Jose Olvera on 08/02/20.
//  Copyright © 2020 Jose Olvera. All rights reserved.
//

import Foundation
import UIKit

extension String {

    func separate(every: Int, with separator: String) -> String {
        return String(stride(from: 0, to: Array(self).count, by: every).map {
            Array(Array(self)[$0..<min($0 + every, Array(self).count)])
        }.joined(separator: separator))
    }
}
