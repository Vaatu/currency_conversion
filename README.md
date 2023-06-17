# currency_conversion

This is a Flutter app that utilizes the [ExchangeRate API](https://exchangerate.host/#/#docs) to display the currency conversion history over a specified period of time. The app follows the clean architecture principles for a well-organized and maintainable codebase.

## Features

- Allows the user to input the start date and end date to define the desired period of time.
- Enables the user to select the base currency and the currency they want to convert to.
- Displays a modern and intuitive user interface.
- Implements pagination for the history data, showing 10 records per API call.

## Requirements

- Dart 3.7.8
- Flutter SDK

## Installation

1. Run the app on an emulator or a connected device
2. Use the app to input the desired start date, end date, base currency, and target currency.
3. Explore the currency conversion history over the specified period of time.


## Clean Architecture

The project is implemented following the principles of clean architecture to ensure a separation of concerns and a scalable codebase. It consists of the following layers:

- **Presentation**: Contains the UI components and handles user interactions. It communicates with the domain layer.
- **Domain**: Defines the core business logic and use cases of the app. It communicates with the data layer.
- **Data**: Handles the data retrieval and storage. It communicates with external APIs or databases.
- **Core**: Contains the shared code and utility classes used across different layers.

The clean architecture approach provides modularity, testability, and maintainability to the project.
