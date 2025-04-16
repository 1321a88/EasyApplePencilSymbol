# EasyApplePencilDrawingApp

This is a simple drawing app using Apple Pencil with support for different drawing modes (pen and eraser), pressure-sensitive line widths, and the ability to clear the canvas. It is implemented using the MVVM pattern and provides an interactive interface for users to draw and erase freely.

## Project Structure

### 1. **App Directory**
- **App.swift**: The main entry point for the application. It initializes and starts the SwiftUI view lifecycle.
- **ContentView.swift**: The main UI component where the drawing canvas and controls are placed. It integrates the drawing logic and drawing tools (pen/eraser and line width).

### 2. **DrawingViewModel.swift**
- This file contains the `DrawingViewModel` class, which is the heart of the app's logic. It handles touch events (start, move, end), drawing mode changes, line width adjustment, and erasing lines.

### 3. **Extention.swift**
- This file contains additional extensions used across the app, such as extending `CGPoint` to include a `distance(to:)` method to calculate the distance between two points.

### 4. **Line.swift**
- Defines the `Line` data model, which represents a drawn line consisting of multiple points.

## How to Use

### 1. Open the project in Xcode
   - Open `EasyApplePencilDrawingApp.xcodeproj` in Xcode.

### 2. Build it on your iOS device
   - Ensure your device is connected and selected as the target device.
   - Make sure your Xcode project is using Swift 6 (or later) as the Swift version.
   - Press the **Run** button (the play icon) in Xcode to build and run the app on your iOS device.

### 3. Using the App
   - **Drawing Mode**: You can switch between the **pen** mode and **eraser** mode by tapping a toggle button.
   - **Pen Mode**: In this mode, you can draw freehand lines with variable widths based on the pressure applied by Apple Pencil.
   - **Eraser Mode**: In this mode, you can erase parts of your drawing by touching the canvas with the eraser tool.
   - **Clear Canvas**: You can clear the entire drawing by using the provided clear button.

### 4. Pressure Sensitivity
   - The app adjusts the **line width** based on the pressure applied by the Apple Pencil. Heavier pressure results in thicker lines, and lighter pressure results in thinner lines.

### 5. Erase Lines
   - When in **eraser mode**, you can remove drawn lines by touching them. The app detects whether the touch intersects with any line and removes it accordingly.

## Dependencies
- **SwiftUI** for UI layout and interactions.
- Requires **Swift 6** (or later) for compatibility.

## Features
- Supports **Apple Pencil** for precise drawing.
- **Pressure-sensitive** line widths based on the Apple Pencil's pressure.
- **Toggle between pen and eraser** modes.
- **Clear canvas** functionality.
- Simple and intuitive user interface.

## How to Contribute
- Fork this repository and make changes to improve it.
- Submit a pull request if you'd like to contribute back.

## License
- This project is open-source and licensed under the GPL3.0 License.

## Acknowledgements
- SwiftUI for UI development.
- Apple Pencil for precise drawing capabilities.
