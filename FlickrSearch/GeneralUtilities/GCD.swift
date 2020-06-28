//
//  GCD.swift
//  FlickrSearch
//
//  Created by Nivesh on 28/06/20.
//  Copyright © 2020 Nivesh. All rights reserved.
//

import UIKit
class GCD {
    
    static func runAsynch(closure: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            closure()
        }
    }
    
    static func runOnMainThread(closure: @escaping () -> Void) {
        DispatchQueue.main.async {
            closure()
        }
    }
}
