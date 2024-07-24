// Include required libraries  
#include <Wire.h>
#include <hd44780.h>                       
#include <hd44780ioClass/hd44780_I2Cexp.h> 
#if defined(ESP32)
#include <WiFi.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#endif
#include <Firebase_ESP_Client.h>
#include <addons/TokenHelper.h>
#include <DHT.h>  // Include the DHT sensor library

const int LCD_COLS = 16;
const int LCD_ROWS = 2;
hd44780_I2Cexp lcd;

//Variables
int h;  //Stores humidity value
int t; //Stores temperature value
int motorPin = D4; // pin that turns on the motor
int blinkPin = D6; // trun on when watering is on 
 // pin that turns on the LED watering iot led
int ledPin = D7; // system watering led (application wateing switch status )
int ledFertilizer = D3; // fertilizer
int ledMainSw = D8;

// Declare a variable to store the LED control value
bool ledControlValue;
bool furtilizersw;
bool mainSw;

//delays
int watertime = 0.05; // how long it will be watering
int waittime = 0.05; // how long to wait between watering 
int watering;

// Define DHT sensor parameters
#define DHTPIN D5
#define DHTTYPE DHT11

// Define WiFi credentials
#define WIFI_SSID "Salmalyaya"
#define WIFI_PASSWORD "dinuka99"

// Define Firebase API Key, Project ID, and user credentials
#define API_KEY "AIzaSyCb5AUJ8G3k9ZrXUXg3iiw17JVOJ6nq3lU"
#define FIREBASE_PROJECT_ID "aquo-f9d38"
#define DATABASE_URL "https://aquo-f9d38.firebaseio.com"
#define USER_EMAIL "dilshan.cc5@gmail.com"
#define USER_PASSWORD "12341234"


FirebaseData firebaseData;
// Define Firebase Data object, Firebase authentication, and configuration
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

// Initialize the DHT sensor
DHT dht(DHTPIN, DHTTYPE);

void setup() {
 
  lcd.begin(LCD_COLS, LCD_ROWS);
  pinMode(motorPin, OUTPUT); // set Pin 3 to an output
  pinMode(blinkPin, OUTPUT); // set pin 13 to an output
  pinMode(A0, INPUT);
  pinMode(ledPin, OUTPUT);
  pinMode( ledFertilizer, OUTPUT);
  pinMode( ledMainSw, OUTPUT);
  digitalWrite(motorPin, HIGH); // set the moter value inverse becourse of the relay module is work inverse, when signl is 0 relay value is 1 


  // Initialize serial communication for debugging
  Serial.begin(9600);

  // Initialize the DHT sensor
  dht.begin();

// LCD Screen welcome note
lcd.clear();
lcd.setCursor(4,0);
lcd.print("WELCOME");
delay(1000);
lcd.clear();
char lcdword1[100] = "Watering    ";
for(int i=0;i<11;i++){
  lcd.setCursor((2+i),0);
  lcd.print(lcdword1[i]);
  delay(150);
}

char lcdword2[100] = " System   ";

for(int i=0;i<8;i++){
lcd.setCursor((4+i),1);
lcd.print(lcdword2[i]);
delay(150);
}

delay(1000);
lcd.clear();
delay(500); 

//________________________________________________________

  // Connect to Wi-Fi
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED) {
    lcd.clear();
    lcd.setCursor(0,0);
    lcd.print("Connecting Wi-Fi");

    Serial.print(".");
    lcd.setCursor(0,1);
    lcd.print("..");

    delay(200);
    lcd.setCursor(0,1);
    lcd.print("...");
    delay(200);

  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  // Print Firebase client version
  Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

  // Assign the API key
  config.api_key = API_KEY;

  // Assign the user sign-in credentials
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;

  // Assign the callback function for the long-running token generation task
  config.token_status_callback = tokenStatusCallback;  // see addons/TokenHelper.h

  // Begin Firebase with configuration and authentication
  Firebase.begin(&config, &auth);

  // Reconnect to Wi-Fi if necessary
  Firebase.reconnectWiFi(true);
}

void loop() { 

  float temperature = dht.readTemperature();
  float humidity = dht.readHumidity();
  float moisture;
    h = dht.readHumidity();
    t = dht.readTemperature();


  // Define the path to the Firestore document
  String documentPath = "EspData/DHT11";

  // Create a FirebaseJson object for storing data
  FirebaseJson content;
//get documet main switch from firebase 


// get document start main sw

if (Firebase.Firestore.getDocument(&fbdo, FIREBASE_PROJECT_ID, "", documentPath.c_str(), "")) {
    Serial.printf("ok\n \n\n", fbdo.payload().c_str());

    // Create a FirebaseJson object and set content with received payload
    FirebaseJson payload;
    payload.setJsonData(fbdo.payload().c_str());

    // Get the data from FirebaseJson object 
    FirebaseJsonData jsonData;
    if (payload.get(jsonData, "fields/MainSwitchStatus/stringValue", true)) {
      // Serial.println(jsonData.stringValue);
      
      // Assign the Firestore value to the variable
      mainSw = (jsonData.stringValue == "on");

      // Control LED based on Firestore value
      digitalWrite(ledMainSw, mainSw ? HIGH : LOW);
      Serial.print("Main switch is: ");
      Serial.println(mainSw);
    } else {
      Serial.println("Failed to read LED control value from Firestore JSON");
    }
}

// get document start main sw END

// get document start watering control by app

if (Firebase.Firestore.getDocument(&fbdo, FIREBASE_PROJECT_ID, "", documentPath.c_str(), "")) {
    Serial.printf("ok\n \n\n", fbdo.payload().c_str());

    // Create a FirebaseJson object and set content with received payload
    FirebaseJson payload;
    payload.setJsonData(fbdo.payload().c_str());

    // Get the data from FirebaseJson object 
    FirebaseJsonData jsonData;
    if (payload.get(jsonData, "fields/pump/stringValue", true)) {
      // Serial.println(jsonData.stringValue);
      
      // Assign the Firestore value to the variable
      ledControlValue = (jsonData.stringValue == "on");

      // Control LED based on Firestore value
      digitalWrite(ledPin, ledControlValue ? HIGH : LOW);
      Serial.print("App Watering SW is: ");
      Serial.println(ledControlValue);
    } else {
      Serial.println("Failed to read LED control value from Firestore JSON");
    }
}

// get document END_______________________________________________

// get document start fertilizer

if (Firebase.Firestore.getDocument(&fbdo, FIREBASE_PROJECT_ID, "", documentPath.c_str(), "")) {
    Serial.printf("ok\n \n\n", fbdo.payload().c_str());

    // Create a FirebaseJson object and set content with received payload
    FirebaseJson payload;
    payload.setJsonData(fbdo.payload().c_str());

    // Get the data from FirebaseJson object 
    FirebaseJsonData jsonData;
    if (payload.get(jsonData, "fields/FertilizerSwitchStatus/stringValue", true)) {
      // Serial.println(jsonData.stringValue);
      
      // Assign the Firestore value to the variable
      furtilizersw = (jsonData.stringValue == "on");

      // Control LED based on Firestore value
      digitalWrite(ledFertilizer, furtilizersw ? HIGH : LOW);
      Serial.print("Furtilizer switch is: ");
      Serial.println(furtilizersw);
    } else {
      Serial.println("Failed to read LED control value from Firestore JSON");
    }
}

// get document start fertilizer END


//----------watering-------------------
{ 
  digitalWrite(motorPin, HIGH); 
  digitalWrite(blinkPin, LOW);
  int moisturePin = analogRead(A0); //read analog value of moisture sensor
  moisture = ( 100 - ( (moisturePin / 1024.00) * 100 )0); //convert analog value to percentage
  Serial.print("Soil Moisture: ");
  Serial.println(moisture);

  if (moisture < 15 && ledControlValue == 1) { //change the moisture threshold level based on your calibration values
    digitalWrite(motorPin, LOW); // turn on the motor
    digitalWrite(blinkPin, HIGH); // turn on the LED
    lcd.setCursor(0,0);
    lcd.clear();
    lcd.print("Watering : ON ");
    Serial.print("Watering : ON \n");
    watering = 1;
    

    //------- print watering status on lec screen 
    lcd.setCursor(0, 0); 
    lcd.setCursor(0, 1);
    lcd.print("T:");
    lcd.print(t);
    lcd.print("C");

     
    lcd.setCursor(11, 1);
    lcd.print("H:");
    lcd.print(h);
    lcd.print("%");
    //-------------------

    delay(watertime * 100);      // multiply to translate seconds to milliseconds
  }
  else {
    digitalWrite(motorPin, HIGH);  // turn off the motor
    digitalWrite(blinkPin, LOW);  // turn off the LED
    lcd.clear();
    lcd.setCursor(0,0);
    lcd.print("Watering : OFF ");
    Serial.print("Watering : OFF \n");
    watering = 0;

        //------- lcd screen 
    lcd.setCursor(0, 0);
    
    lcd.setCursor(0, 1);
    lcd.print("T:");
    lcd.print(t);
    lcd.print("C");

     
    lcd.setCursor(11, 1);
    lcd.print("H:");
    lcd.print(h);
    lcd.print("%");
    //-------------------
    
    delay(waittime * 100);      // multiply by 60000 to translate minutes to milliseconds 
  }
}
// End watering _______________________________________________________________________

// Send data to firestore database_____________________________________________________

  // Print temperature and humidity values
  Serial.print("temperature: ");
  Serial.println(temperature);
  Serial.print("humidity:");
  Serial.println(humidity);



  // Check if the values are valid (not NaN)
  if (!isnan(temperature) && !isnan( humidity)) {
    // Set the 'Temperature' and 'Humidity' fields in the FirebaseJson object
    content.set("fields/Temperature/stringValue", String(temperature, 2));
    content.set("fields/Humidity/stringValue", String(humidity, 2));
    content.set("fields/Moisture/stringValue", String(moisture, 2));
    content.set("fields/Watering/stringValue", String(watering, 2));

    Serial.print("Update/Add DHT Data... ");

    // Use the patchDocument method to update the Temperature and Humidity Firestore document
    if (Firebase.Firestore.patchDocument(&fbdo, FIREBASE_PROJECT_ID, "", documentPath.c_str(), content.raw(), "Temperature") && Firebase.Firestore.patchDocument(&fbdo, FIREBASE_PROJECT_ID, "", documentPath.c_str(), content.raw(), "Humidity") && Firebase.Firestore.patchDocument(&fbdo, FIREBASE_PROJECT_ID, "", documentPath.c_str(), content.raw(), "Moisture")   && Firebase.Firestore.patchDocument(&fbdo, FIREBASE_PROJECT_ID, "", documentPath.c_str(), content.raw(), "Watering" )){
      Serial.printf("ok\n  \n\n", fbdo.payload().c_str());   // put %s when need to print firebase json file "ok\n %s \n\n"
      } else {
            Serial.println(fbdo.errorReason());
          }
  } else {
      Serial.println("Failed to read DHT data.");
  }

  // Delay before the next reading
  delay(100);


  {    
    //Print temp and humidity values to Lcd screen
    Serial.print("Humidity: ");
    Serial.print(h);
    Serial.print(" %, Temp: ");
    Serial.print(t);
    Serial.println(" ° Celsius");

    lcd.setCursor(0, 0);
    lcd.setCursor(0, 1);
    lcd.print("T:");
    lcd.print(t);
    lcd.print("C");

    lcd.setCursor(11, 1);
    lcd.print("H:");
    lcd.print(h);
    lcd.print("%");
    
    delay(100); //Delay 1 sec. 
  
  }


}
