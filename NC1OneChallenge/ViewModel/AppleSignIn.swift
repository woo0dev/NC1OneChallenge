import SwiftUI
import CryptoKit
import AuthenticationServices
import FirebaseAuth
import Firebase
import FirebaseFirestore

class AppleAuthCoordinator: NSObject {
    var currentNonce: String?
    let window: UIWindow?
    @Binding var isSignIn: Bool
    
    let db = Firestore.firestore()
    
    init(window: UIWindow?, isSignIn: Binding<Bool>) {
        self.window = window
        self._isSignIn = isSignIn
    }
    
    func startAppleLogin() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
}

extension AppleAuthCoordinator: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                self.isSignIn = false
            }
            if let _ = appleIDCredential.email {
                print("111111 ================= 첫 로그인")
                db.collection("User").document(Auth.auth().currentUser!.uid).setData(["\(Auth.auth().currentUser!.uid)": ["uid": Auth.auth().currentUser!.uid, "name": "\(appleIDCredential.fullName!.familyName!)"+"\(appleIDCredential.fullName!.givenName!)"]])
            } else {
                print("222222 ================== 로그인 했었음")
            }
        }
    }
}

extension AppleAuthCoordinator: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        window!
    }
}

struct WindowKey: EnvironmentKey {
    struct Value {
        weak var value: UIWindow?
    }
    
    static let defaultValue: Value = .init(value: nil)
}

extension EnvironmentValues {
    var window: UIWindow? {
        get {
            return self[WindowKey.self].value
        }
        set {
            self[WindowKey.self] = .init(value: newValue)
        }
    }
}

struct QuickSignInWithApple: UIViewRepresentable {
    typealias UIViewType = ASAuthorizationAppleIDButton
    
    func makeUIView(context: Context) -> UIViewType {
        return ASAuthorizationAppleIDButton()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

func getUserInfo(_ completion: @escaping (_ data: User?) -> Void) {
    let uid = Auth.auth().currentUser?.uid != nil ? Auth.auth().currentUser!.uid : ""
    var user = User(uid: "", name: "")
    
    let g = DispatchGroup()
    g.enter()
    
    Firestore.firestore().collection("User").document(uid).getDocument { document, error in
        if let document = document, document.exists {
            user = User(uid: uid, name: document["name"] as? String ?? "")
            g.leave()
        } else {
            print("Document does not exist")
            completion(nil)
            g.leave()
        }
        g.notify(queue: .main) {
            completion(user)
        }
        return
    }
}
