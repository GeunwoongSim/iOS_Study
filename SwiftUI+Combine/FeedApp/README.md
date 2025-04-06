

## 메모 어플

|이름|이미지|내용|
|---|---|---|
|로그인 화면|<img src = "https://github.com/user-attachments/assets/614931d4-532e-4657-9bd2-c1e2e7aa6d5b" width ="250">|구글 소셜로그인 구현|
|피드 화면|<img src = "https://github.com/user-attachments/assets/ad771bbb-0376-47ea-871b-7168e262d25a" width ="250">|작성된 피드중 가장 최신 피드부터 확인가능|
|피드 작성화면|<img src = "https://github.com/user-attachments/assets/bd19d585-5d4c-4f81-916b-c34fe315581b" width ="250">|이미지 피커를 통해서 사진 선택가능|
|마이 페이지화면|<img src = "https://github.com/user-attachments/assets/5ec64bb9-8a59-4204-a676-b4e88099d634" width ="250">|자신이 작성한 피드확인가능, 피드순서 변경, 닉네임 변경, 로그아웃 기능|

## 주요 기능

1. 로그인 화면
    - 회원가입 - 구글로그인
2. 탭바
    - 탭별 이미지
    - 터치 시 이벤트 발생
3. 피드 홈
    - 피드 표시
    - 사용자 닉네임 표시
    - 피드 새로고침
4. 피드 작성
    - 작성페이지 내부 이미지 피커
    - Image + TextEditor로 내용 작성
5. 마이페이지
    - 작성한 피드 확인
    - 사용자 닉네임 네비게이션 i표시
    - 로그아웃
    - 정렬 방식 변경

## 프레임워크

- SwiftUI
- Combine

## 라이브러리

- Firebase
- GoogleSignIn

## 프로젝트 구성
```bash
📦FeedApp
 ┣ 📂App
 ┃ ┣ 📜FeedApp.swift
 ┃ ┣ 📜GoogleService-Info.plist
 ┃ ┗ 📜Info.plist
 ┣ 📂Data
 ┃ ┣ 📜AuthManager.swift
 ┃ ┣ 📜Feed.swift
 ┃ ┣ 📜FirestoreManager.swift
 ┃ ┗ 📜GoogleSignInManager.swift
 ┗ 📂Presentation
 ┃ ┣ 📂Feed
 ┃ ┃ ┣ 📜FeedHomeView.swift
 ┃ ┃ ┣ 📜FeedHomeViewModel.swift
 ┃ ┃ ┗ 📜FeedView.swift
 ┃ ┣ 📂Login
 ┃ ┃ ┣ 📜LoginView.swift
 ┃ ┃ ┗ 📜LoginViewModel.swift
 ┃ ┣ 📂MyPage
 ┃ ┃ ┣ 📜MyPageView.swift
 ┃ ┃ ┗ 📜MyPageViewModel.swift
 ┃ ┣ 📂PostPage
 ┃ ┃ ┣ 📜CreatePostDetailView.swift
 ┃ ┃ ┣ 📜CreatePostView.swift
 ┃ ┃ ┣ 📜CreatePostViewModel.swift
 ┃ ┃ ┗ 📜EmbeddedImagePicker.swift
 ┃ ┗ 📜MainTabView.swift
```
