import Foundation

@objc public class WatermarkDrawSettings: NSObject {
    public let translatePos: CGPoint
    public let rotationAngle: CGFloat
    public let drawRect: CGRect
    
    init(
        translatePos: CGPoint,
        rotationAngle: CGFloat,
        drawRect: CGRect
    ) {
        self.translatePos = translatePos
        self.rotationAngle = rotationAngle
        self.drawRect = drawRect
    }
}

@objc public enum WatermarkCornerPosition: Int {
    case topLeft
    case topRight
    case bottomRight
    case bottomLeft
}

/// Watermark placement coulb be configured by normalized position (0..1 for x, y based on final pixel buffer size),
/// or by specifying corner and fixed pixel offset from it.
/// Size could be configured by specifying fixed pixel width, or by normalized value (0..1 from final pixel buffer width),
/// height is always calculated using aspect ratio of provided watermark image.
@objc public class WatermarkInfo: NSObject {
    internal let image: UIImage
    private var isCornerPositioned: Bool
    private var isNormalizedSizeUsed: Bool
    private var cornerPosition: WatermarkCornerPosition = .bottomLeft
    private var cornerOffset: CGPoint = .zero
    private var normalizedPosition: CGPoint = .zero
    private var targetWidth: CGFloat = 0.0
    private var targetNormalizedWidth: CGFloat = 0.0
    
    @objc public init(
        image: UIImage,
        corner: WatermarkCornerPosition,
        offset: CGPoint,
        targetWidth: CGFloat
    ) {
        isCornerPositioned = true
        isNormalizedSizeUsed = false
        self.image = image
        self.cornerPosition = corner
        self.cornerOffset = offset
        self.targetWidth = targetWidth
    }
    
    @objc public init(
        image: UIImage,
        corner: WatermarkCornerPosition,
        offset: CGPoint,
        targetNormalizedWidth: CGFloat
    ) {
        isCornerPositioned = true
        isNormalizedSizeUsed = true
        self.image = image
        self.cornerPosition = corner
        self.cornerOffset = offset
        self.targetNormalizedWidth = targetNormalizedWidth
    }
    
    @objc public init(
        image: UIImage,
        normalizedPosition: CGPoint,
        targetWidth: CGFloat
    ) {
        isCornerPositioned = false
        isNormalizedSizeUsed = false
        self.image = image
        self.normalizedPosition = normalizedPosition
        self.targetWidth = targetWidth
    }
    
    @objc public init(
        image: UIImage,
        normalizedPosition: CGPoint,
        targetNormalizedWidth: CGFloat
    ) {
        isCornerPositioned = false
        isNormalizedSizeUsed = true
        self.image = image
        self.normalizedPosition = normalizedPosition
        self.targetNormalizedWidth = targetNormalizedWidth
    }
    
    @objc public func drawSettingsWithBoundsSize(_ boundsSize: CGSize, outputSettings: OutputSettings) -> WatermarkDrawSettings {
        let aspectRatio = image.size.width / image.size.height
        let width = isNormalizedSizeUsed ? boundsSize.width * targetNormalizedWidth : targetWidth
        let height = width / aspectRatio
        let size = CGSize(width: width, height: height)
        var center: CGPoint = .zero
        
        // Watermark pixel buffer is always created in portrait, but if final video or snapshot should be in landscape, we should compensate this
        // by rendering image onto watermark pixel buffer at other position with applied rotation.
        // (e.g. watermark in bottomleft corner for landscapeleft will be placed topleft corner, rotated by 90 degrees CW)
        if isCornerPositioned {
            let rotatedOffset = outputSettings.deviceOrientation.isLandscape ? CGPoint(
                x: cornerOffset.y,
                y: cornerOffset.x) : cornerOffset
            let rotatedSize = outputSettings.deviceOrientation.isLandscape ? CGSize(
                width: size.height,
                height: size.width) : size
            let rotatedCorner = cornerPosition.adjustWithDeviceOrientation(outputSettings.deviceOrientation)
            center.x = rotatedCorner.isLeftAligned ? rotatedOffset.x + rotatedSize.width / 2.0 :
                boundsSize.width - rotatedOffset.x - rotatedSize.width / 2.0
            center.y = rotatedCorner.isTopAligned ? boundsSize.height - rotatedOffset.y - rotatedSize.height / 2.0 :
                rotatedOffset.y + rotatedSize.height / 2.0
        } else {
            switch outputSettings.deviceOrientation {
            case .landscapeRight:
                center.x = boundsSize.width * normalizedPosition.y
                center.y = boundsSize.height * (1.0 - normalizedPosition.x)
            case .landscapeLeft:
                center.x = boundsSize.width * (1.0 - normalizedPosition.y)
                center.y = boundsSize.height * normalizedPosition.x
            default:
                center.x = boundsSize.width * normalizedPosition.x
                center.y = boundsSize.height * normalizedPosition.y
            }
        }
        let rect = CGRect(origin: CGPoint(x: -size.width / 2.0, y: -size.height / 2.0), size: size)
        let angle = rotationAngleWithSettings(outputSettings)
        return WatermarkDrawSettings(translatePos: center, rotationAngle: angle, drawRect: rect)
    }
    
    private func rotationAngleWithSettings(_ settings: OutputSettings) -> CGFloat {
        switch settings.deviceOrientation {
        case .landscapeLeft:
            return .pi / 2.0
        case .landscapeRight:
            return -.pi / 2.0
        default:
            return 0.0
        }
    }
}

fileprivate extension WatermarkCornerPosition {
    func adjustWithDeviceOrientation(_ orientation: UIDeviceOrientation) -> WatermarkCornerPosition {
        let sides: [WatermarkCornerPosition] = [.topLeft, .topRight, .bottomLeft, .bottomRight]
        guard let currentIndex = sides.firstIndex(of: self) else { return self }
        switch orientation {
        case .landscapeLeft:
            let prevIndex = currentIndex - 1
            return (prevIndex >= 0) ? sides[prevIndex] : sides[sides.count - 1]
        case .landscapeRight:
            let nextIndex = currentIndex + 1
            return (nextIndex < sides.count) ? sides[nextIndex] : sides[0]
        default:
            return self
        }
    }
    var isLeftAligned: Bool {
        return self == .topLeft || self == .bottomLeft
    }
    var isTopAligned: Bool {
        return self == .topLeft || self == .topRight
    }
}
