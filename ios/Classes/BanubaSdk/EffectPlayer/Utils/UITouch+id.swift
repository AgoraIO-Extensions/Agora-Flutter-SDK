import Foundation

extension UITouch {
    public var id: Int64 {
        get { return Int64(Unmanaged.passUnretained(self).toOpaque().hashValue) }
    }
}
