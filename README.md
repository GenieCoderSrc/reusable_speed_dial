# reusable_speed_dial

A Flutter package that provides a customizable and animated Speed Dial button, allowing you to add expandable action buttons in a compact floating button layout. Ideal for quick access to related actions.

## Features

- Create a floating action button that expands into multiple child buttons
- Animated appearance of child buttons
- Customize foreground and background colors
- Flexible child button configuration
- Custom open and close icons

## Getting Started

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  reusable_speed_dial: latest_version
```

Import it in your Dart file:

```dart
import 'package:reusable_speed_dial/speed_dial.dart';
import 'package:reusable_speed_dial/speed_dial_child.dart';
```

## Usage

```dart
SpeedDial(
  onOpenIcon: Icons.menu,
  onCloseIcon: Icons.close,
  openBackgroundColor: Colors.black,
  speedDialChildren: [
    SpeedDialChild(
      child: Icon(Icons.email),
      backgroundColor: Colors.red,
      onPressed: () => print('Email'),
    ),
    SpeedDialChild(
      child: Icon(Icons.phone),
      backgroundColor: Colors.green,
      onPressed: () => print('Call'),
    ),
  ],
)
```

## Constructor Parameters

### SpeedDial
- `onOpenIcon`: Icon when closed (default: `Icons.call`)
- `onCloseIcon`: Icon when opened (default: `Icons.cancel`)
- `openBackgroundColor`: Background color when opened
- `closedBackgroundColor`: Background color when closed
- `speedDialChildren`: List of `SpeedDialChild`
- `controller`: Optional custom animation controller

### SpeedDialChild
- `child`: Widget displayed inside the FAB
- `foregroundColor`: Icon color
- `backgroundColor`: FAB color
- `onPressed`: Callback when tapped
- `closeSpeedDialOnPressed`: Whether to auto-close after press (default: `true`)

## License

MIT License