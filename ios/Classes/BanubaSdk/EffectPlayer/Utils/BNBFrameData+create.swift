import BanubaEffectPlayer
#if BNB_ENABLE_ARKIT
import ARKit

@available(iOS 11.0, *)
fileprivate let auMapping: [BNBActionUnitsIndices: ARFaceAnchor.BlendShapeLocation] = [
    // N.B. Left and right blend shapes are intentionally exchanged to
    // get avatars mirrored in selfie camera.
    .browDownLeft: .browDownRight,
    .browDownRight: .browDownLeft,
    .browInnerUp: .browInnerUp,
    .browOuterUpLeft: .browOuterUpRight,
    .browOuterUpRight: .browOuterUpLeft,
    .cheekPuff: .cheekPuff,
    .cheekSquintLeft: .cheekSquintRight,
    .cheekSquintRight: .cheekSquintLeft,
    .jawForward: .jawForward,
    .jawLeft: .jawRight,
    .jawRight: .jawLeft,
    .jawOpen: .jawOpen,
    .mouthClose: .mouthClose,
    .mouthFunnel: .mouthFunnel,
    .mouthPucker: .mouthPucker,
    .mouthLeft: .mouthRight,
    .mouthRight: .mouthLeft,
    .mouthSmileLeft: .mouthSmileRight,
    .mouthSmileRight: .mouthSmileLeft,
    .mouthDimpleLeft: .mouthDimpleRight,
    .mouthDimpleRight: .mouthDimpleLeft,
    .mouthRollUpper: .mouthRollUpper,
    .mouthShrugUpper: .mouthShrugUpper,
    .mouthShrugLower: .mouthShrugLower,
    .mouthRollLower: .mouthRollLower,
    .mouthFrownLeft: .mouthFrownRight,
    .mouthFrownRight: .mouthFrownLeft,
    .mouthUpperUpLeft: .mouthUpperUpRight,
    .mouthUpperUpRight: .mouthUpperUpLeft,
    .mouthLowerDownLeft: .mouthLowerDownRight,
    .mouthLowerDownRight: .mouthLowerDownLeft,
    .noseSneerLeft: .noseSneerRight,
    .noseSneerRight: .noseSneerLeft,
    .mouthPressLeft: .mouthPressRight,
    .mouthPressRight: .mouthPressLeft,
    .mouthStretchLeft: .mouthStretchRight,
    .mouthStretchRight: .mouthStretchLeft,
    .eyeBlinkLeft: .eyeBlinkRight,
    .eyeBlinkRight: .eyeBlinkLeft,
    .eyeWideLeft: .eyeWideRight,
    .eyeWideRight: .eyeWideLeft,
    .eyeSquintLeft: .eyeSquintRight,
    .eyeSquintRight: .eyeSquintLeft,
    .eyeLookDownLeft: .eyeLookDownRight,
    .eyeLookInLeft: .eyeLookInRight,
    .eyeLookOutLeft: .eyeLookOutRight,
    .eyeLookUpLeft: .eyeLookUpRight,
    .eyeLookDownRight: .eyeLookDownLeft,
    .eyeLookInRight: .eyeLookInLeft,
    .eyeLookOutRight: .eyeLookOutLeft,
    .eyeLookUpRight: .eyeLookUpLeft,
]
#endif

public extension BNBFrameData {
#if BNB_ENABLE_ARKIT
    @available(iOS 11.0, *)
    class func create(
        arFrame: ARFrame,
        useBanubaTracking: Bool,
        faceOrientation: Int = 0,
        cameraOrientation: BNBCameraOrientation = .deg90,
        requireMirroring: Bool = false,
        fieldOfView: Float = 60
    ) -> BNBFrameData? {
        guard let result = BNBFrameData.create() else { return nil }
        var faces: [BNBExternalFaceData] = []
        var actionUnits:[BNBActionUnits] = []
        if !useBanubaTracking {
            let w = CVPixelBufferGetWidth(arFrame.capturedImage)
            let h = CVPixelBufferGetHeight(arFrame.capturedImage)
            var viewport = CGSize(width: w, height: h)
            if cameraOrientation == .deg90 || cameraOrientation == .deg270 {
                viewport = CGSize(width: viewport.height, height: viewport.width)
            }
            for anchor in arFrame.anchors {
                if let faceAnchor = anchor as? ARFaceAnchor {
                    if faceAnchor.isTracked {
                        var vertices: [NSNumber] = []
                        var modelMat: [NSNumber] = []
                        var projMat: [NSNumber] = []
                        var viewMat: [NSNumber] = []
                        for vertex in faceAnchor.geometry.vertices {
                            vertices.append(NSNumber(value: vertex.x))
                            vertices.append(NSNumber(value: vertex.y))
                            vertices.append(NSNumber(value: vertex.z))
                        }
                        let xScale = faceAnchor.geometry.vertices[966].x/(71.618797/1000)
                        let extraVerts: [Float] = [
                            xScale * 0.000000/1000, 116.709084/1000, 18.051502/1000,
                            xScale * -75.060562/1000, 57.503582/1000, -38.533001/1000,
                            xScale * -73.339676/1000, 65.751793/1000, -32.907364/1000,
                            xScale * -36.016483/1000, 106.806671/1000, 14.475857/1000,
                            xScale * -69.515556/1000, 77.520935/1000, -24.329739/1000,
                            xScale * -45.072258/1000, 99.882362/1000, 10.985046/1000,
                            xScale * -54.397713/1000, 90.367744/1000, 6.182373/1000,
                            xScale * -64.656601/1000, 87.207291/1000, -15.772982/1000,
                            xScale * -59.360752/1000, 89.464897/1000, -4.057968/1000,
                            xScale * -24.505180/1000, 112.117401/1000, 16.789211/1000,
                            xScale * -12.537230/1000, 115.459961/1000, 17.794365/1000,
                            xScale * -74.785294/1000, 42.050625/1000, -41.487011/1000,
                            xScale * 75.060562/1000, 57.503582/1000, -38.533001/1000,
                            xScale * 73.339676/1000, 65.751793/1000, -32.907364/1000,
                            xScale * 36.016483/1000, 106.806671/1000, 14.475857/1000,
                            xScale * 69.515556/1000, 77.520935/1000, -24.329739/1000,
                            xScale * 45.072258/1000, 99.882362/1000, 10.985046/1000,
                            xScale * 54.397713/1000, 90.367744/1000, 6.182373/1000,
                            xScale * 64.656601/1000, 87.207291/1000, -15.772982/1000,
                            xScale * 59.360752/1000, 89.464897/1000, -4.057968/1000,
                            xScale * 24.505180/1000, 112.117401/1000, 16.789211/1000,
                            xScale * 12.537230/1000, 115.459961/1000, 17.794365/1000,
                            xScale * 74.785294/1000, 42.050625/1000, -41.487011/1000]
                        for ev in extraVerts {
                            vertices.append(NSNumber(value: ev))
                        }
                        let at = faceAnchor.transform
                        for col in 0...3 {
                            for row in 0...3 {
                                modelMat.append(NSNumber(value: at[col, row]))
                            }
                        }
                        let pm = arFrame.camera.projectionMatrix(
                            for: UIInterfaceOrientation.portrait,
                            viewportSize: viewport,
                            zNear: 0.001,
                            zFar: 1000.0
                        )
                        for col in 0...3 {
                            for row in 0...3 {
                                projMat.append(NSNumber(value: pm[col, row]))
                            }
                        }
                        let vm = arFrame.camera.viewMatrix(for: UIInterfaceOrientation.portrait)
                        for col in 0...3 {
                            for row in 0...3 {
                                viewMat.append(NSNumber(value: vm[col, row]))
                            }
                        }
                        let efd = BNBExternalFaceData(
                            vertices: vertices,
                            modelMat: modelMat,
                            viewMat: viewMat,
                            projMat: projMat
                        )
                        faces.append(efd)
                        assert(auMapping.count == BNBActionUnitsIndices.totalAuCount.rawValue)
                        var aus = [NSNumber]()
                        aus.reserveCapacity(BNBActionUnitsIndices.totalAuCount.rawValue)
                        for i in 0..<BNBActionUnitsIndices.totalAuCount.rawValue {
                            guard let au = BNBActionUnitsIndices.init(rawValue: i) else { return nil }
                            aus.append(faceAnchor.blendShapes[auMapping[au] ?? ARFaceAnchor.BlendShapeLocation.eyeLookDownRight] ?? 0)
                        }
                        // TODO: rot?
                        actionUnits.append(BNBActionUnits(rotX: 0, rotY: 0, rotZ: 0, units: aus))
                    }
                }
            }
        }
        let image = BNBFullImageData(
            arFrame.capturedImage,
            cameraOrientation: cameraOrientation,
            requireMirroring: requireMirroring,
            faceOrientation: faceOrientation,
            fieldOfView: fieldOfView
        )
        result.addFullImg(image)
        if !useBanubaTracking {
            result.addExternalFace(.arKit, data: faces)
            result.add(BNBActionUnitsData(faces: actionUnits))
        }
        return result
    }
#endif
    
    class func create(
        cvBuffer: CVPixelBuffer,
        faceOrientation: Int = 0,
        cameraOrientation: BNBCameraOrientation = .deg90,
        requireMirroring: Bool = false,
        fieldOfView: Float = 60
    ) -> BNBFrameData? {
        guard let result = BNBFrameData.create() else { return nil }
        let image = BNBFullImageData(
            cvBuffer,
            cameraOrientation: cameraOrientation,
            requireMirroring: requireMirroring,
            faceOrientation: faceOrientation,
            fieldOfView: fieldOfView
        )
        result.addFullImg(image)
        return result
    }
}
