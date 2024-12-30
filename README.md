# Mini Instapay App $

Mini Instapay is a user-friendly financial app designed to simplify money management. With intuitive features, it allows users to send and receive money seamlessly, manage bank accounts, analysis usage reports for better financial control and realtime notification.

## Table of contents 📑

- ### [Main Packages Used =>](#main-packages-used)
- ### [Folder Structure =>](#folder-structure)
- ### [Video Link =>](#video-link)
- ### [Screen Shots =>](#screen-shots)

## Main Packages Used 🛠

- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) -> to customize app icons.
- [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) -> for responsive layouts and scaling UI elements.
- [dartz](https://pub.dev/packages/dartz) -> to handle functional programming constructs like Either and Option.
- [dio](https://pub.dev/packages/dio) -> to integrate with APIs for HTTP requests.
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) -> for state management using the Bloc pattern.
- [modal_progress_hud_nsn](https://pub.dev/packages/modal_progress_hud_nsn) -> to display loading indicators over UI elements.
- [get_it](https://pub.dev/packages/get_it) -> for dependency injection and service locator patterns.
- [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) -> for securely storing sensitive data like tokens.
- [cached_network_image](https://pub.dev/packages/cached_network_image) -> to display and cache network images efficiently.
- [shared_preferences](https://pub.dev/packages/shared_preferences) -> to persist simple data like user preferences locally.
- [device_preview](https://pub.dev/packages/device_preview) -> to preview the app on multiple device configurations during development.
- [flutter_slidable](https://pub.dev/packages/flutter_slidable) -> to add slideable widgets for swipe actions like deleting or editing.
- [auto_size_text](https://pub.dev/packages/auto_size_text) -> to make text widgets auto-resize within their containers.
- [socket_io_client_flutter](https://pub.dev/packages/socket_io_client_flutter) -> to enable real-time communication using WebSockets.

## Folder Structure 📂

Here is the folder structure we have been using in this project:

```
lib
├── core
├── features
└── main.dart
```

### Core

This folder contains all services and tools related to the application

```
core
├── api_helper
├── app_theme
├── enums
├── errors
├── models
├── navigation_cubit
├── routes_manager
├── utils
└── widgets
```

### Features

This folder containes everything related to the screen of the application and the business logic of the application specificly state management.

```
features
├── account_management: Handles user account details, including editing personal information, managing linked credit cards, and viewing account status.
├── admin: Provides administrative tools for monitoring user activity, managing app configurations, and handling support requests.
├── auth: Manages user authentication, including login, registration, and secure session handling.
├── home_view: Displays an overview of user accounts, recent transactions, and quick access to essential features.
├── layout_view: Defines the app's main layout structure and navigation flow across different modules.
├── notifications: Manages in-app notifications and alerts for transactions, account updates, and important events.
├── onboarding: Guides new users through app features and setup, ensuring a smooth initial experience.
├── otp: Handles one-time password verification for secure account actions such as login or money transfers.
├── reports: Generates usage analysis, transaction history, and spending patterns for users.
├── settings_view: Provides customizable settings, including app preferences, security options, and daily limit adjustments.
├── splash_view: Displays the initial splash screen with the app logo while initializing resources.
├── transaction_module: Manages the core functionalities for sending, receiving, and tracking money transfers.
└── transactions: Shows all user transactions, including successful, pending, and failed operations, for reference.

```

# [Video Link](https://drive.google.com/file/d/13yGMExoYncJEW-BVtrdYLg-FRXv5n8gI/view?usp=sharing)

## Screen Shots 📸

<img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/1.PNG" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/2.PNG" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/3.PNG" width="300">

<img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/4.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/5.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/6.png" width="300">

<img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/7.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/8.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/9.png" width="300">

<img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/10.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/11.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/12.png" width="300">

<img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/13.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/14.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/15.png" width="300">

<img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/16.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/17.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/18.png" width="300">

<img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/19.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/20.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/21.png" width="300">

<img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/22.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/23.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/24.png" width="300">

<img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/25.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/26.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/27.png" width="300">

<img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/28.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/29.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/30.png" width="300">

<img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/31.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/32.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/33.png" width="300">

<img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/34.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/35.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/36.png" width="300">

<img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/37.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/38.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/39.png" width="300">

<img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/40.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/41.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/42.png" width="300">

<img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/43.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/44.png" width="300"><img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/45.png" width="300">

<img src="https://github.com/mostafamagde/mini_InstaPay/blob/screen_shots/screen_shots/46.PNG" width="300">
