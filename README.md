# Mango Diseases Detector

An Android app developed with Flutter that leverages a Convolutional Neural Network (CNN) model to detect diseases in mango plants based on images of their leaves. This app is designed to help farmers quickly and accurately diagnose potential diseases in mango crops, enabling them to take timely action for effective disease management.

## Project Overview

The Mango Diseases Detector app allows users to capture or upload an image of a mango leaf, which is then analyzed by a pre-trained CNN model integrated into the app. The model identifies the type of disease, if present, and provides a diagnosis to the user.

### Key Features
- **Image-based Disease Detection**: Uses image analysis to detect common diseases in mango plants.
- **CNN Integration**: Employs a TensorFlow-based CNN model fine-tuned for accuracy and speed to ensure reliable disease prediction.
- **User-Friendly Interface**: Farmers can easily capture photos of mango leaves and receive instant feedback on disease diagnosis.
- **Disease Management Guidance**: The app provides actionable insights to help users understand and manage detected diseases.

## Tech Stack

- **Flutter**: Provides a smooth, cross-platform experience for Android.
- **TensorFlow**: Powers the CNN model for mango disease classification and prediction.
- **CNN Model**: Trained for image-based disease classification with optimized accuracy and reduced latency.

## Getting Started

### Prerequisites
- Ensure that Flutter is installed on your machine. Refer to the [Flutter Installation Guide](https://docs.flutter.dev/get-started/install) for instructions.

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/LazarusJunior/mango_diseases_detector.git
   cd mango_diseases_detector
2. Install dependencies:
   ```bash   
   flutter pub get
3. Run the app
   ```bash
    flutter run
   

