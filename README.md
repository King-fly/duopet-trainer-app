# DuoPet Trainer App 🐕🐱

A fun and engaging pet training application inspired by Duolingo's design style, helping pet owners train their dogs and cats effectively.

## Features ✨

- **Pet Selection**: Choose between dogs and cats, with options for young and adult pets
- **Emergency Guide**: Quick reference for common pet emergencies with step-by-step instructions
- **Training Plans**: Structured daily training plans with tips and duration guides
- **Taboo Training**: Learn what NOT to do when training your pet
- **Duolingo-Inspired Design**: Vibrant colors, 3D buttons, and a friendly interface

## Screenshots

<img src="./docs/library.png" width="200"><img src="./docs/trick.png" width="200"><img src="./docs/plan.png" width="200"><img src="./docs/my.png" width="200">

<img src="./docs/library_dark.png" width="200"><img src="./docs/trick_dark.png" width="200"><img src="./docs/plan_dark.png" width="200"><img src="./docs/my_dark.png" width="200">

## Tech Stack 🛠️

- **Framework**: SwiftUI
- **Language**: Swift 5.0+
- **Platform**: iOS 16+
- **State Management**: Combine with EnvironmentObject
- **Design System**: Custom Duolingo-inspired color palette and components

## Getting Started 🚀

### Prerequisites

- Xcode 15+
- iOS 16+ SDK

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/duopet-trainer-app.git
```

2. Open the project in Xcode:
```bash
open duopet-trainer-app.xcodeproj
```

3. Build and run on a simulator or device.

## Project Structure 📁

```
duopet-trainer-app/
├── Assets.xcassets/          # App icons and assets
├── Models/                   # Data models
│   ├── PetData.swift         # Mock data
│   └── PetModels.swift       # Type definitions
├── Store/                    # State management
│   └── AppState.swift        # Global app state
├── Theme/                    # Design system
│   └── DesignSystem.swift    # Colors, styles, components
├── Views/                    # UI views
│   ├── EmergencyView.swift   # Emergency guide screen
│   ├── MainTabView.swift     # Tab bar container
│   ├── PetSelectionView.swift# Pet selection screen
│   ├── PlanView.swift        # Training plan screen
│   ├── ProfileView.swift     # User profile screen
│   └── TabooView.swift       # Taboo training screen
├── ContentView.swift         # Root view
└── duopet_trainer_appApp.swift # App entry point
```

## Design System 🎨

The app uses a Duolingo-inspired color palette:

| Color | Hex | Usage |
|-------|-----|-------|
| Duo Green | #58CC02 | Primary button, success |
| Duo Blue | #1CB0F6 | Secondary button, info |
| Duo Yellow | #FFC800 | Warning, highlight |
| Duo Orange | #FF9600 | Important, attention |
| Duo Red | #FF4B4B | Danger, error |

## Usage 📱

1. **Select Your Pet**: Choose between dog or cat, and select the age
2. **Explore Training Plans**: Follow structured daily training plans
3. **Emergency Reference**: Access quick guides for common pet emergencies
4. **Learn Taboos**: Understand what to avoid during training

## Contributing 🤝

Contributions are welcome! Please feel free to:
- Submit bug reports
- Suggest new features
- Create pull requests

## License 📄

This project is for educational purposes.

---

🐾 Happy Training!