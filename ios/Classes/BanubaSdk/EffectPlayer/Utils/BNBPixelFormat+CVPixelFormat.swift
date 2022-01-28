import BanubaEffectPlayer

extension BNBPixelFormat {
    init?(pixelFormat: OSType) {
        switch pixelFormat {
        case kCVPixelFormatType_32BGRA:
            self = .bgra
        case kCVPixelFormatType_32ARGB:
            self = .argb
        case kCVPixelFormatType_32RGBA:
            self = .rgba
        case kCVPixelFormatType_24BGR:
            self = .bgr
        case kCVPixelFormatType_24RGB:
            self = .rgb
        default:
            return nil
        }
    }
}
