# translate_swedish

A Simple translation app for Swedish to English written in flutter. It uses GCP cloud translation API for the text input translations and Google MLKit for text recognition and translation on device.

## Getting Started

If you want to use this project locally, then add your GCP cloud API translation key to the `example.env` file (found in root directory) and then rename it to `.env`. Then you can go through the process of installing the app, same as any other flutter project. Be warned however that due to the limitations of MLKit, this code will run only on 64 bit devices on iOS and has a minimum API requirement of 21 on Android
