# Automated Water Pump Control System

## Introduction
This project is an IoT-based system designed for efficient water pump control, showcased at the 9th GCES IT Expo. The system leverages PHP, C++, and Dart to provide a seamless and automated solution for managing water pumps.

## Features
- **Automated Control**: Automatically manages the water pump based on predefined conditions.
- **IoT Integration**: Connects with IoT devices to monitor and control water levels remotely.
- **User Interface**: Provides a user-friendly interface for manual control and monitoring.
- **Data Logging**: Logs water usage data for analysis and optimization.
- **Alerts and Notifications**: Sends alerts for critical conditions like low water levels or pump failures.

## Setup and Installation
1. **Clone the repository**:
   ```sh
   git clone https://github.com/aayush1693/Automated-Water-Pump-Control-System.git
   ```
2. **Navigate to the project directory**:
   ```sh
   cd Automated-Water-Pump-Control-System
   ```
3. **Install dependencies**:
   - For the PHP components:
     ```sh
     composer install
     ```
   - For the Dart components:
     ```sh
     pub get
     ```
   - Ensure you have the necessary C++ libraries installed for the IoT hardware integration.

4. **Run the project**:
   - Start the PHP server:
     ```sh
     php -S localhost:8000
     ```
   - Compile and upload the C++ code to your IoT hardware.

## Usage
1. Access the user interface via `http://localhost:8000`.
2. Monitor the water levels and control the water pump manually if needed.
3. Check the logs and alerts for any critical updates.

## Contributing
Feel free to contribute to this project by opening issues or submitting pull requests. Ensure your contributions follow the project's coding standards and include appropriate tests.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

