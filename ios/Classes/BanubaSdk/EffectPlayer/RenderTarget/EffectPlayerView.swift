import BanubaEffectPlayer
import QuartzCore

@objc public class EffectPlayerView: UIView {
    // https://developer.apple.com/documentation/metal/drawable_objects/creating_a_custom_metal_view
    @objc internal var effectPlayer: BNBEffectPlayer?
    
    @objc public override init(frame: CGRect) {
        super.init(frame: frame)
        initCommon()
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCommon()
    }
    
    // TODO:
    // setPaused
    // setupCADisplayLinkForScreen
    // didMoveToWindow
    // stopRenderLoop/dealloc
    // resizeDrawable
    // didEnterBackground
    // willEnterForeground
    // runThread
    // setContentScaleFactor
    // layoutSubviews
    // setFrame
    // setBounds
    // delegate
    
    private var metalLayer: CAMetalLayer?
    internal var paused: Bool = false
    
    private func initCommon() {
        initGestures()
        metalLayer = (layer as! CAMetalLayer)
        layer.delegate = self
        isMultipleTouchEnabled = true
        // layer.contentsScale = UIScreen.main.scale
    }
    
    override public class var layerClass : AnyClass {
        return CAMetalLayer.self
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        inputManager?.onTouchesBegan(converTouches(touches))
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        inputManager?.onTouchesMoved(converTouches(touches))
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        inputManager?.onTouchesEnded(converTouches(touches))
    }

    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        inputManager?.onTouchesCancelled(converTouches(touches))
    }
    
    @objc public func onLongTapGesture(gesture: UITapGestureRecognizer) {
        if gesture.state != UITapGestureRecognizer.State.ended {
            inputManager?.onLongTapGesture(BNBTouch(gesture.location(in: self), view: self))
        } else {
            inputManager?.onGestureEnded("LongTap")
        }
    }
    
    @objc public func onDoubleTapGesture(gesture: UITapGestureRecognizer) {
        inputManager?.onDoubleTapGesture(BNBTouch(gesture.location(in: self), view: self))
        if gesture.state == UITapGestureRecognizer.State.ended {
            inputManager?.onGestureEnded("DoubleTap")
        }
    }
    
    @objc public func onScaleGesture(gesture: UIPinchGestureRecognizer) {
        if gesture.state != UIPinchGestureRecognizer.State.ended {
            inputManager?.onScaleGesture(Float(gesture.scale))
        } else {
            inputManager?.onGestureEnded("Scale")
        }
    }
    
    @objc public func onRotationGesture(gesture: UIRotationGestureRecognizer) {
        if gesture.state != UIRotationGestureRecognizer.State.ended {
            inputManager?.onRotationGesture(-Float(gesture.rotation) * 180 / .pi)
        } else {
            inputManager?.onGestureEnded("Rotation")
        }
    }
    
    @objc public func onSwipeGesture(gesture: UISwipeGestureRecognizer) {
            switch gesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                inputManager?.onSwipeGesture(1, dirY: 0)
                break
            case UISwipeGestureRecognizer.Direction.left:
                inputManager?.onSwipeGesture(-1, dirY: 0)
                break
            case UISwipeGestureRecognizer.Direction.up:
                inputManager?.onSwipeGesture(0, dirY: 1)
                break
            case UISwipeGestureRecognizer.Direction.down:
                inputManager?.onSwipeGesture(0, dirY: -1)
                break
            default:
                return
            }
        
        if gesture.state == UISwipeGestureRecognizer.State.ended {
            inputManager?.onGestureEnded("Swipe")
        }
    }
    
    fileprivate var inputManager: BNBInputManager? {
        get { return effectPlayer?.getInputManager() }
    }
    
    fileprivate func converTouches(_ touches: Set<UITouch>) -> [NSNumber: BNBTouch] {
        var result: [NSNumber: BNBTouch] = [:]
        for touch in touches {
            result[NSNumber(value: touch.id)] = BNBTouch(touch)
        }
        return result
    }
    
    private func initGestures() {
        self.layer.contentsScale = UIScreen.main.nativeScale
        self.isMultipleTouchEnabled = true
        
        let rightSwipeGestureRecognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(self.onSwipeGesture)
        )
        rightSwipeGestureRecognizer.direction = .right
        rightSwipeGestureRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(rightSwipeGestureRecognizer)

        let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(self.onSwipeGesture)
        )
        leftSwipeGestureRecognizer.direction = .left
        leftSwipeGestureRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(leftSwipeGestureRecognizer)

        let upSwipeGestureRecognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(self.onSwipeGesture)
        )
        upSwipeGestureRecognizer.direction = .up
        upSwipeGestureRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(upSwipeGestureRecognizer)

        let downSwipeGestureRecognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(self.onSwipeGesture)
        )
        downSwipeGestureRecognizer.direction = .down
        downSwipeGestureRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(downSwipeGestureRecognizer)
        
        let rotationGestureRecognizer = UIRotationGestureRecognizer(
            target: self,
            action: #selector(self.onRotationGesture)
        )
        addGestureRecognizer(rotationGestureRecognizer)
        rotationGestureRecognizer.cancelsTouchesInView = false
        
        let scaleGestureRecognizer = UIPinchGestureRecognizer(
            target: self,
            action: #selector(self.onScaleGesture)
        )
        addGestureRecognizer(scaleGestureRecognizer)
        scaleGestureRecognizer.cancelsTouchesInView = false
        
        let doubleTapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.onDoubleTapGesture)
        )
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTapGestureRecognizer)
        doubleTapGestureRecognizer.cancelsTouchesInView = true
        
        let longTapGestureRecognizer = UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.onLongTapGesture)
        )
        addGestureRecognizer(longTapGestureRecognizer)
        longTapGestureRecognizer.cancelsTouchesInView = false
    }
}
