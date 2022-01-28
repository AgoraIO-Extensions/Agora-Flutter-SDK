import BanubaEffectPlayer

extension BNBTouch {
    convenience init?(_ touch: UITouch) {
        guard let view = touch.view else { return nil }
        let location = BNBTouch.normalize(
            position: touch.location(in: touch.view),
            view: view
        )
        self.init(
            x: Float(location.x),
            y: Float(location.y),
            id: touch.id
        )
    }
    
    convenience init(_ position: CGPoint, view: UIView) {
        let location = BNBTouch.normalize(
            position: position,
            view: view
        )
        self.init(
            x: Float(location.x),
            y: Float(location.y),
            id: 0
        )
    }
    
    static private func normalize(position: CGPoint, view: UIView) -> CGPoint {
        let viewSize = view.bounds.size
        var location = position
        location.x = location.x / ((viewSize.width ) / 2) - 1
        location.y = -(location.y / ((viewSize.height ) / 2) - 1)
        return location
    }
}
