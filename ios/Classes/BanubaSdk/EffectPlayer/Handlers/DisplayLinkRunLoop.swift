extension BanubaSdkManager {
    //TODO: Check Performance
    class DisplayLinkRunLoop {
        private var alive = true
        private var preRender = [() -> Void]()
        private var postRender = [() -> Void]()
        private let renderWork: () -> Bool
        private var thread: Thread?
        
        public var renderThread: Thread? {
            if !isStoped {
                print("DisplayLinkRunLoop: Runloop is running, any tasks in " +
                    "renderThread will not be executed till Runloop is stopped")
            }
            return thread
        }
        
        internal var isStoped = true
        
        init(
            label: String,
            framerate: Int,
            renderWork work: @escaping () -> Bool
        ) {
            self.renderWork = work
            self.start(framerate: framerate, label: label)
        }
        
        deinit {
            alive = false
        }
        
        func addPreRender(preRenderWork:@escaping () -> Void) {
            if isStoped {
                preRender.append(preRenderWork)
            }
        }
        
        func addPostRender(postRenderWork:@escaping () -> Void) {
            if isStoped {
                postRender.append(postRenderWork)
            }
        }
        
        private func start(framerate: Int, label: String) {
            thread = Thread(block: { [weak self] in
                guard let `self` = self else { return }
                let runLoop = RunLoop.current
                let displayLink = CADisplayLink(target: self, selector: #selector(self.doWork))
                displayLink.preferredFramesPerSecond = framerate
                displayLink.add(to: runLoop, forMode: .default)
                defer { displayLink.invalidate() }
                let distantFuture = Date.distantFuture
                repeat {
                    runLoop.run(mode: .default, before: distantFuture)
                } while self.alive
            })
            thread?.name = label
            thread?.qualityOfService = .userInteractive
            thread?.start()
        }
        
        func removeAllHandlers() {
            preRender = []
            postRender = []
        }
        
        @objc func doWork() {
            if isStoped { return }
            
            preRender.forEach { work in
                work()
            }
            let drawedSuccessfully = renderWork()
            if !drawedSuccessfully {
                return
            }
            postRender.forEach { work in
                work()
            }
        }
    }
}
