//
//  TimerExtensions.swift
//  Extensions
//
//  Created by LiuYue on 08/08/2017.
//  Copyright © 2017 devliu.com. All rights reserved.
//

import Foundation

extension Timer: NamespaceWrappable {}
extension TypeWrapper where T == Timer {
    public static func scheduledTimerWithTimeInterval(_ timeInterval: TimeInterval, repeats: Bool, callback: @escaping ((Timer) -> Void)) -> Timer {
        let callbackWrapper = CallbackWrapper(callback)
        return Timer.scheduledTimer(timeInterval: timeInterval, target: Timer.self, selector: #selector(Timer.execCallback(_:)), userInfo: callbackWrapper, repeats: repeats)
    }

    public static func timerWithTimeInterval(_ timeInterval: TimeInterval, repeats: Bool, callback: @escaping ((Timer) -> Void)) -> Timer {
        let callbackWrapper = CallbackWrapper(callback)
        return Timer(timeInterval: timeInterval, target: Timer.self, selector: #selector(Timer.execCallback(_:)), userInfo: callbackWrapper, repeats: repeats)
    }
}

extension Timer {
    @objc static func execCallback(_ timer: Timer) {
        if let callbackWrapper = timer.userInfo as? CallbackWrapper {
            callbackWrapper.callback(timer)
        }
    }
}

private class CallbackWrapper {
    var callback: ((Timer) -> Void)
    init(_ callback: @escaping ((Timer) -> Void)) {
        self.callback = callback
    }
}
