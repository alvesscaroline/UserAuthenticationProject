import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isAuthenticated = false
    @State private var isRegistering = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            if isAuthenticated {
                // Tela principal após autenticação
                MainView(logoutAction: logout)
            } else {
                // Tela de login ou registro
                VStack {
                    
                    Spacer()
                    
                    Image("squirrel-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                    
                    Text("The Journal")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }

                    Button(action: {
                        if isRegistering {
                            register()
                        } else {
                            login()
                        }
                    }) {
                        Text(isRegistering ? "Register" : "Login")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }

                    Button(action: {
                        isRegistering.toggle()
                    }) {
                        Text(isRegistering ? "Already have an account? Login" : "Don't have an account? Register")
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Spacer()
                }
                .padding()
                .background(Color.black).edgesIgnoringSafeArea(.all)
                .navigationBarHidden(true)
            }
        }
    }

    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                isAuthenticated = true
            }
        }
    }

    private func register() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                isAuthenticated = true
            }
        }
    }

    private func logout() {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
            email = ""
            password = ""
        } catch let signOutError as NSError {
            errorMessage = signOutError.localizedDescription
        }
    }
}

struct MainView: View {
    var logoutAction: () -> Void

    var body: some View {
        VStack {
            Text("Welcome")
                .font(.largeTitle)
                .padding()

            Button(action: logoutAction) {
                Text("Logout")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ContentView()
}
