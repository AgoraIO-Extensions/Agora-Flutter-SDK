import Foundation
import Accelerate

@objc public extension UIImage {
    
    /// This method doesn't use copying data, since it can heavily affect performance and memory usage
    /// (for high quality photos like 3024x4032 each copy of data has size ~30 Mb, and on slower devices making copy can take up to 0.2 sec).
    ///
    /// Common idea - we have NSData object which contains raw data, used for UIImage creation. Since we don't copy underlying data, we need to take control on
    /// lifetime of NSData object, otherwise internal content of UIImage will be destroyed.
    /// So, we manually transform NSData object into unmanaged pointer and increase its retain count by passRetained call, and in special callback of CGDataProvider,
    /// which will be called when UIImage is no longer needed, we release that unmanaged pointer by takeRetainedValue call, to prevent memory leaks.
    convenience init?(
        bgraDataNoCopy: NSData,
        width: Int,
        height: Int
    ) {
        let bufferLength = bgraDataNoCopy.length
        let imageDataPointer: UnsafePointer<UInt8> = bgraDataNoCopy.bytes.bindMemory(to: UInt8.self, capacity: bufferLength)
        let releaseImagePixelData: CGDataProviderReleaseDataCallback = { (info: UnsafeMutableRawPointer?, data: UnsafeRawPointer, size: Int) -> () in
            guard let dataObjPointer = info else { return }
            let _ = Unmanaged<NSData>.fromOpaque(dataObjPointer).takeRetainedValue()
        }
        let dataObjPointer = UnsafeMutableRawPointer(Unmanaged.passRetained(bgraDataNoCopy).toOpaque())
        guard let dataProvider = CGDataProvider(dataInfo: dataObjPointer, data: imageDataPointer, size: bufferLength, releaseData: releaseImagePixelData) else {
            let _ = Unmanaged<NSData>.fromOpaque(dataObjPointer).takeRetainedValue()
            return nil
        }
        let colorSpaceRef = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.noneSkipFirst.rawValue)
        guard let imageRef = CGImage(
            width: width,
            height: height,
            bitsPerComponent: 8,
            bitsPerPixel: 32,
            bytesPerRow: 4 * width,
            space: colorSpaceRef,
            bitmapInfo: bitmapInfo,
            provider: dataProvider,
            decode: nil,
            shouldInterpolate: false,
            intent: CGColorRenderingIntent.defaultIntent) else { return nil }
        self.init(
            cgImage: imageRef
        )
    }
    
    func makeBgraPixelBuffer() -> CVPixelBuffer? {
        let width = Int(size.width)
        let height = Int(size.height)
        var pixelBuffer: CVPixelBuffer?
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
                     kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        let status = CVPixelBufferCreate(
            kCFAllocatorDefault,
            width, height,
            kCVPixelFormatType_32BGRA,
            attrs,
            &pixelBuffer
        )
        guard status == kCVReturnSuccess, let buffer = pixelBuffer else { return nil }
        CVPixelBufferLockBaseAddress(buffer, [])
        let pixelBufferData = CVPixelBufferGetBaseAddress(buffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(buffer)
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.noneSkipFirst.rawValue)
        let cgContext = CGContext(
            data: pixelBufferData,
            width: width, height:
            height,
            bitsPerComponent: 8,
            bytesPerRow: bytesPerRow,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: bitmapInfo.rawValue
        )
        guard let context = cgContext else { return nil }
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1, y: -1)
        UIGraphicsPushContext(context)
        draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(buffer, [])
        return buffer
    }
}

fileprivate extension CVPixelBuffer {
    /// This method should be called between paired methods CVPixelBufferLockBaseAddress and CVPixelBufferUnlockBaseAddress,
    /// otherwise CVPixelBufferGetBaseAddress or CVPixelBufferGetBaseAddressOfPlane methods could work incorrectly.
    func makeImageBufferInfo(planeIndex: Int? = nil) -> vImage_Buffer {
        if let index = planeIndex {
            return vImage_Buffer(
                data: CVPixelBufferGetBaseAddressOfPlane(self, index),
                height: UInt(CVPixelBufferGetHeightOfPlane(self, index)),
                width: UInt(CVPixelBufferGetWidthOfPlane(self, index)),
                rowBytes: CVPixelBufferGetBytesPerRowOfPlane(self, index)
            )
        }
        return vImage_Buffer(
            data: CVPixelBufferGetBaseAddress(self),
            height: UInt(CVPixelBufferGetHeight(self)),
            width: UInt(CVPixelBufferGetWidth(self)),
            rowBytes: CVPixelBufferGetBytesPerRow(self)
        )
    }
}
