# GIGI Sports

스크린파크 골프장 예약을 위한 Flutter 앱 프로토타입입니다.

## 포함 화면

- 카카오, 네이버, 구글, 애플 로그인/회원가입
- 홈
- 프로필, 스코어카드, 스코어카드 상세, 내 정보 수정
- 예약 매장 목록, 지도형 매장 목록
- 카메라 QR 코드 인식

## 파일 구조

- `lib/main.dart`: 앱 시작점
- `lib/app_theme.dart`: 색상과 테마
- `lib/main_shell.dart`: 하단 탭 화면
- `lib/widgets/common_widgets.dart`: 공통 카드, 로고, 프로필 요약 위젯
- `lib/pages/login_page.dart`: 로그인/회원가입
- `lib/pages/home_page.dart`: 홈
- `lib/pages/profile_page.dart`: 프로필
- `lib/pages/edit_profile_page.dart`: 내 정보 수정
- `lib/pages/score_detail_page.dart`: 스코어카드 세부 정보
- `lib/pages/booking_page.dart`: 예약 매장 목록/지도
- `lib/pages/qr_scanner_page.dart`: QR 카메라 인식

## 실행

Flutter SDK가 설치된 환경에서 아래 순서로 실행하세요.

```powershell
flutter create .
flutter pub get
flutter run
```

현재 작업 환경에는 Flutter 명령이 설치되어 있지 않아 로컬 실행 검증은 하지 못했습니다.

## QR 카메라 권한

`flutter create .` 실행 후 iOS를 빌드한다면 `ios/Runner/Info.plist`에 카메라 사용 설명을 추가하세요.

```xml
<key>NSCameraUsageDescription</key>
<string>매장 QR 체크인을 위해 카메라를 사용합니다.</string>
```
