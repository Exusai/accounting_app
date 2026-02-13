# Accounting App

A modern, responsive personal finance management application built with Flutter.

## Features

### 📊 Responsive Dashboard
-   **Multi-device Support**: Adapts seamlessly between mobile (Bottom Navigation) and desktop/web (Navigation Rail) layouts.
-   **Side-by-Side Layout**: On large screens, summary cards, charts, and accounts are displayed side-by-side for optimal space utilization.
-   **Sliver-based Scrolling**: High-performance scrolling combining charts and lists into a single cohesive view.

### 💰 Finance Tracking
-   **Summary Cards**: Quick overview of total Income, Expenses, and current Balance.
-   **Expense Breakdown**: Interactive Pie Chart visualizing spending by category.
-   **Account Balances**: Track balances across multiple accounts (Cash, Credit Cards, Savings), automatically sorted by balance.

### 📝 Transaction Management
-   **Detailed History**: Searchable transaction table with columns for Date, Name, Category, Amount, and Account.
-   **Recent-First Sorting**: Transactions are automatically ordered by date, showing the latest activity at the top.
-   **Smart Filtering**: Automatically excludes internal movements ("movimiento") from income/expense summaries for accurate reporting.

### 🛠 Technical Excellence
-   **Internationalization (i18n)**: Full support for English and Spanish.
-   **Theming**: Beautiful Light and Dark modes.
-   **Modern Architecture**: Built using `flutter_bloc` for robust state management and `fl_chart` for data visualization.

## Getting Started

### Prerequisites
-   Flutter SDK (^3.6.0)
-   Dart SDK

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-repo/accounting_app.git
    cd accounting_app
    ```

2.  **Fetch dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Generate Localizations**:
    ```bash
    flutter gen-l10n
    ```

4.  **Run the application**:
    ```bash
    flutter run
    ```

## Tech Stack
-   **UI Framework**: [Flutter](https://flutter.dev)
-   **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc)
-   **Charts**: [fl_chart](https://pub.dev/packages/fl_chart)
-   **Localization**: [intl](https://pub.dev/packages/intl)
-   **Networking**: [dio](https://pub.dev/packages/dio)
