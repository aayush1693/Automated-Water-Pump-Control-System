#include <WiFi.h>
#include <HTTPClient.h>

const char* ssid = "NTFiber-e0f7";
const char* password = "5vzSc7rf";
const char* serverURL1 = "http://expoproject.42web.io/tank_data_receiver.php";
const char* serverURL2 = "http://expoproject.42web.io/motor_status_sender.php";


// Pin definitions
const int relayPin = 2;          // Pin connected to the relay
const int triggerPin = 5;        // Pin connected to the ultrasonic sensor trigger
const int echoPin = 18;           // Pin connected to the ultrasonic sensor echo

// Create an instance of the WiFiClient class
WiFiClient client;

void sendTankData(int tankData) {
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
  }

  HTTPClient http;
  http.begin(serverURL1);
  http.addHeader("Content-Type", "application/x-www-form-urlencoded");

  String data = "data=" + String(tankData);
  
  int httpResponseCode = http.POST(data);

  if (httpResponseCode > 0) {
    String response = http.getString();
    Serial.println("Tank data sent to server. Response: " + response);
  } else {
    Serial.println("Error sending tank data. Error code: " + String(httpResponseCode));
  }

  

  http.end();
  WiFi.disconnect();
}
bool getMotorStatus() {
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
  }

  HTTPClient http;
  http.begin(serverURL2);

  int httpResponseCode = http.GET();

  bool motorStatus = false;

  if (httpResponseCode == HTTP_CODE_OK) {
    String response = http.getString();
    motorStatus = response.toInt();
    Serial.println("Received motor status from server: " + String(motorStatus));
  } else {
    Serial.println("Error getting motor status. Error code: " + String(httpResponseCode));
  }

  http.end();
  WiFi.disconnect();

  return motorStatus;
}

void setup() {
  Serial.begin(115200);

  pinMode(relayPin, OUTPUT);     // Set relay pin as output
  pinMode(triggerPin, OUTPUT);   // Set trigger pin as output
  pinMode(echoPin, INPUT);       // Set echo pin as input

  // Initialize relay as off
  digitalWrite(relayPin, LOW);

  // Start Wi-Fi connection
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  Serial.println("Connected to WiFi");

  // Print ESP32 IP address
  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());
}

void loop() {
  // Read ultrasonic sensor value
  float distance = readUltrasonicSensor();

  // Calculate water level percentage
  int waterLevel = calculateWaterLevel(distance);

  // Control relay based on water level
  if (waterLevel >= 10 && waterLevel <= 100) {
    digitalWrite(relayPin, HIGH); // Turn on the relay
    Serial.println("Relay: ON");
  } else {
    digitalWrite(relayPin, LOW); // Turn off the relay
    Serial.println("Relay: OFF");
  }

  // Display tank status based on water level
  if (waterLevel == 100) {
    Serial.println("Your tank is full");
  } else if (waterLevel == 10) {
    Serial.println("Your tank is going to be empty");
  }

  // Send water level data to the server
  sendTankData(waterLevel);
  if (getMotorStatus()){
    digitalWrite(relayPin, HIGH); // Turn on the relay
    Serial.println("Relay: ON");
  }
  else {
    digitalWrite(relayPin, LOW); // Turn off the relay
    Serial.println("Relay: OFF");
    }

  delay(5000); // Delay between readings (adjust as needed)
}

float readUltrasonicSensor() {
  // Generate ultrasonic pulse
  digitalWrite(triggerPin, LOW);
  delayMicroseconds(2);
  digitalWrite(triggerPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(triggerPin, LOW);

  // Measure the pulse duration
  float duration = pulseIn(echoPin, HIGH);

  // Calculate the distance based on the speed of sound
  // float speedOfSound = 343.0; // Speed of sound in meters per second
  // float distance = (duration / 2.0) * (speedOfSound / 10000.0);
  float distance = (duration / 2.0) / 29.1;
  return distance;
}

int calculateWaterLevel(float distance) {
  // Assuming the height of the water tank is 1 meter
  float tankHeight = 100; // Height of the water tank in centimeters

  // Calculate the water level percentage
  int waterLevel = (1 - (distance / tankHeight)) * 100;

  return waterLevel;
}

}
