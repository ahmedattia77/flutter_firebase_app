# 📝 Firebase Notes App

A feature-rich Mobile Notes Application built with **Flutter** and **Firebase**, designed with clean state management using the **BLoC/Cubit** pattern. It provides seamless real-time authentication, note management, and swipe actions for an intuitive user experience.

---
## ✨ Take a look

https://github.com/user-attachments/assets/7e23d09f-1656-4d07-9a74-f92f229be0ce



## ✨ Features

- **🔐 User Authentication:** Secure email & password registration and login via Firebase Auth.
- **📌 Dynamic Notes Management (CRUD):**
  - **Create:** Add notes with custom titles, descriptions, and color choices.
  - **Read:** Fetch and order user notes chronologically from Cloud Firestore.
  - **Delete:** Interactive **Swipe-to-Delete** (left/right) functionality using `Dismissible`.
- **⚡ State Management:** Predictable state handling using `flutter_bloc` (Cubit).
- **🛤 Routing:** Declarative and structured route navigation with `onGenerateRoute`.

---

## 🛠️ Tech Stack & Packages

- **Framework:** [Flutter](https://flutter.dev/) (Dart)
- **State Management:** `flutter_bloc` (Cubit)
- **Backend & Database:** 
  - Firebase Authentication
  - Cloud Firestore
- **Architecture:** Feature-based modular structure

---

## 📂 Project Structure

```text
lib/
├── core/
│   ├── helper/          # Firebase helpers and utility classes
│   └── routing/         # App routes & route generator (AppRouter)
├── features/
│   ├── auth/            # Login & Register screens, Cubits, and logic
│   └── home/            # Home screen, Add/Delete Note functionality
│       ├── data/        # Note models & Firestore mapping
│       └── presentation/# Custom UI widgets & HomeCubit
└── main.dart            # App entry point & initialization
