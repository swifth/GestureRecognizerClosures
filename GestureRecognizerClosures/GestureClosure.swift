import UIKit

private var HandlerKey: UInt8 = 0

internal extension UIGestureRecognizer {

    internal convenience init<T: UIGestureRecognizer>(handler: @escaping (T) -> Void, type: T.Type) {
        let handler = ClosureHandler<T>(handler: handler)
        self.init(target: handler, action: ClosureHandlerSelector)
        handler.control = (self as! T)
        setHandler(handler)
    }

    internal func setHandler<T: UIGestureRecognizer>(_ handler: ClosureHandler<T>) {
        objc_setAssociatedObject(self, &HandlerKey, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    internal func handler<T>() -> ClosureHandler<T> {
        return objc_getAssociatedObject(self, &HandlerKey) as! ClosureHandler
    }
}
