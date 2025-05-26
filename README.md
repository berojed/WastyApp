#  Wasty Reviews App

A  Flutter demo app for managing and analyzing reviews with **persistent local storage**, state management, analytics, and admin mode.

---

##  Features

-  **View and filter reviews** (by rating)
-  **Reply to reviews** (admin mode only)
-  **Mark reviews as important**
-  **Sentiment tagging** (Positive, Neutral, Negative)
-  **Analytics dashboard with charts**
-  **Local persistence** using SharedPreferences
-  **Unit/widget tests** for all main components

---

##  Screenshots

<table>
  <tr>
    <td><img src="https://i.postimg.cc/YSYwzbG6/Screenshot-1748251501.png" alt="Reviews Screen" width="220"/></td>
    <td><img src="https://i.postimg.cc/cC9qLz2S/Screenshot-1748251512.png" alt="Sorting reviews by rating 1/2" width="220"/></td>
    <td><img src="https://i.postimg.cc/mDSf0kSh/Screenshot-1748251520.png" alt="Sorting reviews by rating 2/2" width="220"/></td>
    <td><img src="https://i.postimg.cc/26YNchhP/Screenshot-1748251527.png" alt="Admin mode" width="220"/></td>
    <td><img src="https://i.postimg.cc/8cPQDGy4/Screenshot-1748251548.png" alt="Reply as Admin 1/2" width="220"/></td>
    <td><img src="https://i.postimg.cc/xTZDrWLG/Screenshot-1748251551.png" alt="Reply as Admin 2/2" width="220"/></td>
    <td><img src="https://i.postimg.cc/wx0Y2tvG/Screenshot-1748251568.png" alt="Analytics screen" width="220"/></td>
    <td><img src="https://i.postimg.cc/NfFqzg2f/Screenshot-1748251581.png" alt="Toggle important" width="220"/></td>
  </tr>
  <tr>
    <td align="center">Reviews Screen</td>
    <td align="center">Sorting reviews by rating 1/2</td>
    <td align="center">Sorting reviews by rating 2/2</td>
    <td align="center">Admin mode</td>
    <td align="center">Reply as Admin 1/2</td>
    <td align="center">Reply as Admin 2/2</td>
    <td align="center">Analytics screen</td>
    <td align="center">Toggle important</td>
  </tr>
</table>

---

##  Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/berojed/WastyApp.git
cd wasty_reviews_app

```

### 2. **Install dependencies**

```bash
flutter pub get
```

### 2. **Run the app**

```bash
flutter run
```
---

##  Description of Approach

**State management**  
The app leverages **Flutter Riverpod** for robust, modular, and scalable state management. All business logic, view models, and UI state are managed using Riverpod providers, ensuring predictable app behavior and easy testability.

**Data storage**  
All replies, “important” flags, and sentiments are **persisted locally** using [SharedPreferences](https://pub.dev/packages/shared_preferences).  
This means user actions are saved and restored automatically—even after the app is closed and restarted.

**UI/UX**  
-  **Bottom navigation:** Switching between “Reviews” and “Analytics” screens  
-  **Admin toggle:** Enables/disables admin features (like replying to reviews) in real-time  
-  **Clean, responsive design:** Adapts to all devices and screen sizes  
-  **Analytics dashboard:** Review stats visualized with charts ([fl_chart](https://pub.dev/packages/fl_chart))

**Testing**  
Key widgets—**ReviewCard**, **ReviewListScreen**, **AnalyticsScreen**—are covered by dedicated widget tests, ensuring reliability and robustness.

---

##  Tech Stack

- **Flutter** – cross-platform UI toolkit
- **Riverpod** – state management
- **SharedPreferences** – local storage
- **fl_chart** – analytics charts
- **flutter_test** – widget/unit testing
