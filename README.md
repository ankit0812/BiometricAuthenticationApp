# BiometricAuthenticationApp

A lightweight UIKit-based iOS demo that showcases how to implement Face ID / Touch ID authentication using the Repository and MVVM patterns. This project securely stores and retrieves tokens from the Keychain protected by biometric authentication.

✨ Features
Face ID / Touch ID login using LocalAuthentication

Secure token storage in Keychain with .userPresence access control

Clean architecture: MVVM + Use Case + Repository pattern

UIKit interface with closure-based state handling (no Combine)

iOS 14+ compatible with LAContext support

🛠 Requirements
iOS 14.0+
Xcode 14+

Physical device for biometric testing

📝 Note
Don't forget to set NSFaceIDUsageDescription in your Info.plist:
<key>NSFaceIDUsageDescription</key>
<string>We use Face ID to securely authenticate your login.</string>
