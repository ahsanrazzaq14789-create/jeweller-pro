JEWELLER PRO — ANDROID PROJECT

اہم:
یہ Flutter source project ہے، ابھی install ہونے والی APK نہیں۔
اس ZIP میں GitHub Actions کا cloud-build workflow بھی ہے، جس سے APK آن لائن بنائی جا سکتی ہے۔
اس کے لیے GitHub account اور project کو GitHub پر upload کرنا ہوگا؛ صرف موبائل سے بھی browser میں یہ کام ہو سکتا ہے۔

APK بنانے کے مراحل:
1) ZIP extract کریں۔
2) GitHub پر نیا repository بنائیں۔
3) اس folder کی تمام files repository میں upload کریں۔
4) GitHub repository میں Actions کھولیں۔
5) "Build Android APK" workflow منتخب کرکے Run workflow دبائیں۔
6) Build مکمل ہونے پر Artifacts سے jeweller-pro-android-apk.zip download کریں۔
7) ZIP کھول کر app-release.apk انسٹال کریں۔

نوٹ:
- یہ ابتدائی MVP/demo ہے۔
- فی الحال data app بند ہونے کے بعد محفوظ نہیں رہتا۔
- Cloud sync, login, subscriptions, PDF bills, full jewellery weight/purity calculations اور production-grade backup ابھی شامل نہیں۔
- پہلے APK build/install verify کریں، پھر modules کو مرحلہ وار مکمل کریں۔
