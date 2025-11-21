# Project Blueprint: SMS to Telegram Forwarder

## 1. Overview

This project is an Android application that automatically forwards incoming SMS messages to a specified Telegram chat. It's designed as a lightweight, installable APK for personal use.

### Core Capabilities:
- Listens for incoming SMS messages in the background.
- Forwards SMS content (sender, message body, timestamp) to a user-configured Telegram bot and chat.
- Provides a simple UI to configure the Telegram Bot Token and Chat ID.
- Uses WorkManager for reliable, asynchronous message sending with automatic retries.
- Logs forwarded messages to a local file for debugging.

## 2. Application Outline

### 2.1. Project Structure & Components

- **`app/build.gradle`**: Defines Android build configuration and dependencies.
- **`app/src/main/AndroidManifest.xml`**: Declares app components (Activities, Receivers) and required permissions (`RECEIVE_SMS`, `INTERNET`).
- **`app/src/main/java/com/example/smsforwarder/MainActivity.kt`**: The main user interface.
    - Allows users to enter and save their Telegram Bot Token and Chat ID using SharedPreferences.
    - Provides a button to request the `RECEIVE_SMS` permission at runtime.
    - Includes a "Test Send" button to verify the configuration.
    - Displays the current status of the `RECEIVE_SMS` permission.
- **`app/src/main/java/com/example/smsforwarder/SmsReceiver.kt`**: A `BroadcastReceiver` that triggers on `android.provider.Telephony.SMS_RECEIVED`.
    - Parses incoming `SmsMessage` objects.
    - Constructs the message to be forwarded.
    - Enqueues a `TelegramSendWorker` to handle the network request.
- **`app/src/main/java/com/example/smsforwarder/TelegramSendWorker.kt`**: A `CoroutineWorker` for background tasks.
    - Receives the message details via `WorkManager`'s input `Data`.
    - Uses OkHttp to send the message to the Telegram Bot API.
    - Implements `Result.retry()` for automatic retries on network failure.
- **`app/srcika/main/java/com/example/smsforwarder/LocalLogger.kt`**: A utility object for logging.
    - Appends log messages to a simple text file (`forward_log.txt`) in the app's internal storage.
- **`app/src/main/res/layout/activity_main.xml`**: The XML layout for `MainActivity`.
    - Contains `EditText` fields for Bot Token and Chat ID, `Button`s for saving, testing, and requesting permissions, and a `TextView` for status messages.

### 2.2. Features & Logic

- **Permissions**:
    - Requests `RECEIVE_SMS` and `INTERNET` in the manifest.
    - `MainActivity` handles the runtime request for `RECEIVE_SMS`.
- **Configuration**:
    - Bot Token and Chat ID are stored persistently using `SharedPreferences`.
- **SMS Handling**:
    - The `SmsReceiver` is registered in the manifest with a high priority intent filter to intercept SMS messages.
- **Forwarding**:
    - The forwarding logic is delegated to a `WorkManager` task to ensure it runs reliably, even if the app is in the background. This also handles network retries automatically.
- **Logging**:
    - All forwarding attempts (success or failure) are logged to a local file for easy debugging.

## 3. Current Task: Initial Project Setup

The current task is to create the initial MVP (Minimum Viable Product) structure for the SMS Forwarder application.

### Steps:
1. Create the `app/build.gradle` file with the specified dependencies.
2. Create the Android Manifest at `app/src/main/AndroidManifest.xml`.
3. Create the layout file at `app/src/main/res/layout/activity_main.xml`.
4. Create the Kotlin source files in `app/src/main/java/com/example/smsforwarder/`:
    - `MainActivity.kt`
    - `SmsReceiver.kt`
    - `TelegramSendWorker.kt`
    - `LocalLogger.kt`
