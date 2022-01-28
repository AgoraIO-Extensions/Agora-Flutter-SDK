extension BanubaSdkManager {
    class AppStateHandler {
        private var tokens = [AnyObject]()
        private let notificationCenter: NotificationCenter
        init(
            notificationCenter: NotificationCenter
        ) {
            self.notificationCenter = notificationCenter
        }
        
        func add(name:NSNotification.Name, handler:@escaping (Notification)->Void) {
            let token = notificationCenter.addObserver(
                forName: name,
                object: nil,
                queue: nil,
                using: handler
            )
            tokens.append(token)
        }
        
        func removeAll() {
            tokens.forEach { token in
                notificationCenter.removeObserver(token)
            }
            tokens.removeAll()
        }
        
        deinit {
            removeAll()
        }
    }
}
