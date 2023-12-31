//
//  OnboardingView.swift
//  beFLE
//
//  Created by 송재훈 on 11/6/23.
//

import AuthenticationServices
import SwiftUI

/// 앱 시작 시 처음 보이는 화면
struct OnboardingView: View {
    var body: some View {
        ZStack {
            OnboardingImage
            VStack {
                Spacer()
                Banner
                LoginButton
                PreviewButton
                Spacer().frame(height: UIScreen.getHeight(68))
            }
        }
        .ignoresSafeArea()
    }
}

/// 화면 구성 컴포넌트
extension OnboardingView {
    /// 배경 이미지
    var OnboardingImage: some View {
        GeometryReader { geo in
            Image("LoginImage")
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
        }
    }
    
    /// 배너 텍스트
    var Banner: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("몸 좋은 사람들의\n운동일지 구독")
                    .font(.title1())
                    .foregroundColor(.label_900)
                    .padding(.bottom, 10)
                
                Text("Be my Influencer, beFLE")
                    .font(.bannerFont())
                    .foregroundColor(.label_700)
            }
            .padding(32)
            .padding(.bottom, 26)
            Spacer()
        }
    }
}

/// 버튼
extension OnboardingView {
    /// 로그인 버튼
    var LoginButton: some View {
        FloatingButton(size: .medium) {
            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = [.email]
            } onCompletion: { results in
                switch results {
                case .success(let result):
                    switch result.credential {
                    case let userCredential as ASAuthorizationAppleIDCredential:
                        let identifier = userCredential.user
                        let identityToken = String(data: userCredential.identityToken!, encoding: .utf8)
                        let authorizationCode = String(data: userCredential.authorizationCode!, encoding: .utf8)
                        
                        LaunchViewModel.shared.loginByAppleLogin(identifier: identifier, identityToken: identityToken!, authorizationCode: authorizationCode!)
                        
                    default:
                        break
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .signInWithAppleButtonStyle(.white)
            .clipShape(.rect(cornerRadius: 100))
            .font(.largeTitle)
        }
    }
    
    /// 둘러보기 버튼
    var PreviewButton: some View {
        Button {
            LaunchViewModel.shared.previewLogin()
        } label: {
            FloatingButton(size: .medium, color: .gray_600) {
                Text("둘러보기")
                    .foregroundColor(.green_main)
                    .font(.title1())
            }
        }
    }
}

struct OnboardingView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OnboardingView()
        }
    }
}
