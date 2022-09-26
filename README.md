## Description
This is a `Flutter` application that implements the mobile client for the **self-parking car**. This software is part of the [JavaScript self-parking car project](https://github.com/gcornetta/self-parking-car).

## Configuration
You can configure the app to connect to the server running on the **Raspberry-pi robot car** through an environment variable stored in the `.env`file in the application root directory. Refer to `.env.example` file to understand the file format.

## Software requirements
This software has been originally developed and tested with `Flutter v.2.8.1` and `Dart v.2.15.1` on `Visual Studio Code` and recently updated to work with `Flutter v.3.3.2` and `Dart v.2.18.1`. You need to install the following VSCode plugins:
1. Dart (Dart language support and debugger for Visual Studio Code). I have installed `v.3.48.4`.
2. Flutter (Flutter support and debugger for Visual Studio Code) .I have installed `v.3.48.0`.

Flutter relies on `Xcode` to generate code for IoS devices and on `Android Studio` to generate code for Android devices. Installing and configuring flutter is a long and tedious process. Please refer to the [official documentation](https://docs.flutter.dev/get-started/install) to install Flutter.
