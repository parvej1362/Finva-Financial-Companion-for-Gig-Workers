# Finva - Smart Financial Companion for Gig Workers

Finva is a comprehensive financial platform designed specifically for the gig economy workforce. It leverages SMS parsing and real-time connectivity to provide insights, safety pots, and protection plans.

## 📱 App Highlights
- **Real-time Earnings Tracking**: Integrated with major platforms like Swiggy, Zomato, Zepto, and more.
- **Automated Safety Pot**: Build a financial buffer automatically from your daily earnings.
- **Smart Protection**: Personalized insurance and protection plans based on work patterns.
- **AI-Driven Insights**: Get daily advice to optimize your work hours and maximize income.
- **Stability Score**: Track your financial health and unlock access to instant support.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (v3.0+)
- Node.js (v18+)
- MongoDB

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/anigawade45/Finva-PathFinders.git
   ```

2. **Backend Setup**:
   ```bash
   cd backend
   npm install
   # Configure your .env file
   npm start
   ```

3. **Frontend Setup**:
   ```bash
   cd finva_frontend
   flutter pub get
   flutter run
   ```

## 📂 Project Structure

### 🖥️ Backend (`/backend`)
```text
backend/
├── controllers/      # Business logic (auth, earnings, safety pot)
├── models/           # Mongoose schemas (User, Earning, Insurance)
├── routes/           # API endpoints mapping
├── services/         # Helper functions (SMS parsing, stability score)
├── middleware/       # Auth guards and validation
├── inngest/          # Background worker tasks
├── db/               # Database connect config
├── server.js         # Entry point
└── package.json      # Dependencies
```

### 📱 Frontend (`/finva_frontend`)
```text
finva_frontend/
├── lib/
│   ├── screens/      # All UI views (HomeScreen, InsightsScreen)
│   ├── services/     # API handlers and business logic
│   ├── models/       # Serialization classes
│   ├── widgets/      # Reusable UI components
│   ├── theme/        # Global style and color system
│   └── main.dart     # App bootstrap
├── assets/           # Images, logos, and custom graphics
└── pubspec.yaml      # Flutter dependencies
```

## 📲 Download APK
You can find the latest build in the root directory: [Finva-v1.0.apk](https://drive.google.com/file/d/1PckSVIjAaqJxnJ_N1DKXeYXtkwyQ7-cb/view?usp=sharing) 

## Step To user finva
- Dowload apk from drive link
- Give the sms permission 


## 🛠️ Tech Stack
- **Frontend**: Flutter, Provider, fl_chart
- **Backend**: Node.js, Express, Mongoose, Inngest
- **Database**: MongoDB
- **Parsing**: Advanced SMS transaction logic for Indian gig workers.

---
Built with ❤️ by the Finva Team.
