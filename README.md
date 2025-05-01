# 🎮 Advanced Counter App

A highly sophisticated, feature-rich counter application built with Flutter and the BLoC pattern. Far beyond the standard counter app, this project showcases advanced state management techniques and polished user experiences.

![App Screenshots](screenshots/app_preview.png)

## ✨ Features

### 🔢 Advanced Counting
- Multiple counters with unique names
- Increment/decrement with tactile haptic feedback
- Bulk incrementing by custom amounts
- Negative numbers support
- Undo/Redo functionality with complete history tracking

### 🏆 Achievement System
- Unlock achievements as you reach milestones
- Fun, game-style notifications
- Both positive and negative count achievements
- Epic achievement titles and descriptions
- Progress tracking from beginner to legendary status

### 💯 Visually Delightful
- Confetti celebrations on milestone counts
- Smooth animations
- Dark/Light mode support
- Beautiful UI with modern design

### 🧠 Powerful Architecture
- Clean, maintainable code structure
- Robust error handling
- Comprehensive testing suite
- Performant even with extreme counter values

## 🏗️ Architecture

This app implements the BLoC (Business Logic Component) pattern for state management, offering:

### 📦 BLoC Implementation Highlights

#### CounterBloc
```dart
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  // Handles events and emits new states
}
```
- **Event-Based Architecture**: Clean separation of UI and business logic
- **Immutable State**: State objects that cannot be modified after creation
- **Advanced History Management**: Tracks counter history for undo/redo
- **Multiple Counter Support**: Manages multiple named counters simultaneously

#### AchievementsBloc
```dart
class AchievementsBloc extends Bloc<AchievementEvent, AchievementsState> {
  // Tracks and unlocks achievements based on counter states
}
```
- **Achievement Tracking**: Monitors counter values to unlock achievements
- **Notification System**: Shows and dismisses achievement notifications
- **Persistent Achievements**: Remembers unlocked achievements

## 🔧 Technical Details

### State Management 
- **BLoC Pattern**: Reactive programming paradigm
- **Clean Architecture**: Separation of concerns
- **Repository Pattern**: Data access abstraction
- **Dependency Injection**: For maintainability and testing

### Testing
- **Unit Tests**: Verifying business logic
- **Widget Tests**: Ensuring UI behaves correctly
- **Integration Tests**: Full user flow verification

### Performance
- **Efficient UI Rebuilds**: Only rebuilds what needs to change
- **Memory Management**: Handles large history stacks efficiently
- **Smooth Animations**: 60fps performance even on older devices

## 🚀 Getting Started

1. Clone the repository:
```bash
git clone https://github.com/Obleanx/Advanced_counterApp-Built-using-BLoC.git
```

2. Navigate to the project directory:
```bash
cd Advanced_counterApp-Built-using-BLoC
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## 🧪 Running Tests

```bash
flutter test
```

## 📚 Documentation

For more information on the app architecture and code structure, see [DOCUMENTATION.md](DOCUMENTATION.md).

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/Obleanx/Advanced_counterApp-Built-using-BLoC/issues).

## 📄 License

This project is MIT licensed - see the [LICENSE](LICENSE) file for details.

## 👏 Acknowledgements

- Flutter and Dart team
- BLoC library maintainers
- The open-source community

---

Built with ❤️ by [Obleanx](https://github.com/Obleanx)
