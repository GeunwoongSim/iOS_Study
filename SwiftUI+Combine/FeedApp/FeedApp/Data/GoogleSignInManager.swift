//
//  GoogleSignInManager.swift
//  FeedApp
//
//  Created by 심근웅 on 4/6/25.
//

import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn

final class GoogleSignInManager {
    
    // MARK: - Singleton 패턴
    static let shared = GoogleSignInManager()
    private init() { }
    
    /// 구글 로그인
    func signInGoogle() async throws -> User {
        
        // 필수 구성
        guard let clientID = FirebaseApp.app()?.options.clientID,
              let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = await windowScene.windows.first?.rootViewController else {
            throw NSError(domain: "config error", code: -1)
        }
        
        // config 설정
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootVC)
        
        let user = result.user
        let accessToken = user.accessToken.tokenString
        guard let idToken = user.idToken?.tokenString else {
            throw NSError(domain: "id token error", code: -1)
        }
        
        // 🔐 Firebase 자격 생성 후 로그인
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        let authResult = try await Auth.auth().signIn(with: credential)
        
        return authResult.user
    }
}
