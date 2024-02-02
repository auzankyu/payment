# Swift Payment Application using QRCode
Hi! I'm really excited to share you the journey when I build a simple app using Swift UIKit. So, recently this week I received an assignment to build an app that can making some payment using QRCode. Before we start, I made some important points that will guide the development process:

Features:

- Scan QRCode and then pay
- Payment History
- Charts that showing the history

# Toolkit/Technology and External Library

1. Xcode 15.2
2. Support iOS 13+
3. Support Light mode or Dark Mode
4. Programatically UIKit + XIB
5. Dependency Injection using property wrapper
6. Swift concurrency for networking layer

for libraries we using as less as possible
1. [RxSwift](https://github.com/ReactiveX/RxSwift) - for reactive programming
2. [DGCharts](https://github.com/danielgindi/Charts) - for displaying chart

# Clean and Complete Architecture
We implement MVVM-R pattern but there are additional layer

Model - View - ViewModel - Router - Repository

We will implement business requirements in a maintainable, scalable and testable manner. So we need to have a clean architecture that can suit our needs.

# Project Structure
```
├──Managers/ 
|  ├──ScannerManager/
|  ├──UtilsManager/
|  ├──InjectionManager/
|  ├──APIClientManager/
├──Extensions/
├──CustomUIKit/
├──Features/ → MVVM in every single feature
|  ├──Transaction/
|  ├──QRCodeScanner/
|  ├──Home/
|  ├──History/
├──Core/
├──Podfile
```

# How to run
Run `pod install`
- this apps can run both using simulator and device (for simulator will skip the qrcode scanner)
- apps know that our balance is less than the price of the item from the merchant.
- note that we are using a dummy data using .json file for user profile (include balance that we have) and charts

# Scan this QRCode
| QRCode Example 1 | QRCode Example 2 | QRCode Example 3 | 
| --- | --- | --- |
|<img width="186" alt="qrcode_1" src="https://github.com/auzankyu/payment/assets/9339383/03206260-1bf7-44c1-ba31-f23bbc218a66">|<img width="192" alt="qrcode2" src="https://github.com/auzankyu/payment/assets/9339383/f0d8dc47-f80b-477e-b085-017df3005263">|<img width="192" alt="qrcode3" src="https://github.com/auzankyu/payment/assets/9339383/0192e696-5234-434f-ad5d-14d8f1523d5e">|


# Video Demo
https://github.com/auzankyu/payment/assets/9339383/83719623-c587-4dcf-8dcd-a819bc84b598

# Screenshoot
| Home | Open Camera | Transaction | Transaction Success |
| --- | --- | --- | --- |
|![IMG_7643](https://github.com/auzankyu/payment/assets/9339383/7fcdfbda-af0b-4b04-aa38-039408c5f475)|![IMG_7644](https://github.com/auzankyu/payment/assets/9339383/19b83d38-e11c-40e1-8e64-67854f17b1c3)|![IMG_7646](https://github.com/auzankyu/payment/assets/9339383/f8c8e239-9fea-42b2-a641-be2bfc1c98d9)|![IMG_7647](https://github.com/auzankyu/payment/assets/9339383/df6fce59-74d9-4ae4-b084-4a6ce5927ca9)|

| Payment History | History from Chart | Dark Mode
| --- | --- | --- |
|![IMG_7652](https://github.com/auzankyu/payment/assets/9339383/a0660781-2f5a-420c-a93d-24ec9869603c)|![IMG_7650](https://github.com/auzankyu/payment/assets/9339383/2277c80e-cc92-4611-997f-44c3d22bd3a9)|![IMG_7653](https://github.com/auzankyu/payment/assets/9339383/d3b32876-942e-484d-9b88-da57be199546)|


