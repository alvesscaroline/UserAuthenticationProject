import SwiftUI
import Firebase

@main
struct UserAuthenticationApp: App {
    init() {
            // Configura o Firebase logo na inicialização do aplicativo
            FirebaseApp.configure()
            print ("Configured Firebase!")
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
