# Wasty Reviews App

A modern Flutter demo app for managing and analyzing reviews, featuring local storage 

---

## Features

- View and filter reviews
- Reply to reviews (admin mode)
- Mark reviews as important
- Sentiment tagging (Positive, Neutral, Negative)
- Analytics dashboard with charts
- **Data persists locally** (using SharedPreferences)
- Unit/widget tests for main UI components

---

## Setup Instructions

### 1. **Clone the repository**

```bash
git clone <your-repo-url>
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


#### Description of Approach

State management:
The app uses Flutter Riverpod for robust and scalable state management (all view models and providers).

Data storage:
Replies, important flags, and sentiments are persisted locally using [SharedPreferences].
This ensures user interactions remain even after the app is closed.

UI/UX:

Bottom navigation for quick switching between "Reviews" and "Analytics".

Simple, responsive layout with support for admin actions via toggle.

Analytics visualized using charts (e.g., [fl_chart]).

Testing:
Core widgets (ReviewCard, ReviewListScreen, AnalyticsScreen) have dedicated widget tests ensuring reliability and correct UI logic.

#### Stack
Flutter

Riverpod

SharedPreferences

fl_chart

[flutter_test]