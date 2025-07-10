# Aisle iOS App – Use Case Implementation

This project is a **use case implementation** for **Aisle**. The focus is on two main areas: **Login flow** and the **Notes tab**, where users can see who has shown interest in them.

---

## 📌 Use Case Summary

This iOS module simulates a key user journey inside the Aisle app, built using UIKit and Swift. It includes:

### 🔐 1. Login Flow (Authentication Use Case)

- Simulates a login screen where users can authenticate using their phone number.
- Handles OTP input, verification, and access token management.

### 📝 2. Notes Tab (Main Feature)

- Represents a dedicated screen where **users view profiles who sent them notes or liked them**.

#### Key Features in the Notes Tab:

- **Profile Header**
  - Displays the first user's name and age.
  - Loads a selected profile photo with a dark overlay and a short call-to-action (“Tap to review 50+ notes”).

- **Image Caching**
  - Implements `NSCache` for efficient image loading and reduced network usage.

- **Responsive Design**
  - Fully built using Auto Layout and programmatic views for clean and adaptable UI across devices.


---

## 🧱 Tech Stack

- **UIKit**
- **Swift 5**
- **MVC Architecture**
- **NSCache** for image optimization
- **UICollectionView** for dynamic profile display

---

## 🧪 Usage

- The `NotesViewController` can be embedded into your app after login.
- Pass a mock or real `NotesResponse` object to populate the view.
- Fully supports dynamic UI updates based on the available data.

---


