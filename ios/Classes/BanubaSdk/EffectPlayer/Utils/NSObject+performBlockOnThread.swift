import Foundation

public extension NSObject {

               
    func performSync(onThread: Thread?, block: @convention(block) @escaping ()->Void) {
        guard let thread = onThread else { return }
        perform(#selector(fire(block:)), on: thread, with: block, waitUntilDone: true)
    }
    
    func performAsync(onThread: Thread?, block:  @convention(block) @escaping ()->Void) {
        guard let thread = onThread else { return }
        perform(#selector(fire(block:)), on: thread, with: block, waitUntilDone: false)
    }
    
    
    @objc private func fire(block: @convention(block) ()->Void) {
        block()
    }
}
