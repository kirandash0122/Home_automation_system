//Linking essential library
#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <DNSServer.h>
#include <WiFiManager.h>
#include <ArduinoJson.h>
#include <FirebaseESP8266.h>
//defining Firebase Host and Authentication
#define FIREBASE_HOST "smarthomesystem-7fc71-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "med4TKpUkQ8vBOGyKN3Tj5sYNSlTqrdP1akTDLtf"

FirebaseData fbdo;
int l1=0;
int l=0;
int led =D1;     // LED pin
int button = D0; // push button is connected
int temp = 0;    // temporary variable for reading the button pin status
WiFiManager wifiManager;

void setup() {
// put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(led, OUTPUT);   // declare LED as output
  pinMode(button, INPUT); // declare push button as input
  pinMode(D2,OUTPUT);//D2 as output
  pinMode(D4,OUTPUT);//D4 as output
  pinMode(D5,OUTPUT);//D5 as output, indicates the connection of wifi

  digitalWrite(D2,HIGH);
  digitalWrite(D4,HIGH);
  digitalWrite(D5,LOW);
  Serial.println("Conecting.....");
  //Auto connect to previously connected wifi
  wifiManager.autoConnect("Access POint","12345");
  Serial.println("connected");

 
  if(WiFi.status()==WL_CONNECTED){
    Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);//begin firebase if nodemcu connected
    delay(500);
    //blinking of led indicates connection of wifi
    digitalWrite(D5,HIGH);
    delay(500);
    digitalWrite(D5,LOW);
    delay(500);
    digitalWrite(D5,HIGH);
    }
else{
  digitalWrite(D5,LOW);
}
}

void loop() {
// put your main code here, to run repeatedly
  
temp = digitalRead(button);
//push button switch program for configuring wifi
    
if (temp == HIGH) {//if push button is pressed
    digitalWrite(led, HIGH);//green led is turened on
    wifiManager.startConfigPortal("Access Point") ;//start configuration portal
    delay(1000);
}
else {
    digitalWrite(led, LOW);
}

if(WiFi.status()==WL_CONNECTED){//if nodemcu connected to wifi
 Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);//begin firebase
 digitalWrite(D5,HIGH);//red led blinks
 delay(500);
 digitalWrite(D5,LOW);
 delay(500);
 digitalWrite(D5,HIGH);
 QueryFilter query1;

//Build query using specified child node key "bedroom_AC" under "name"
  query1.orderBy("name");
  query1.equalTo("bedroom_LED");

if (Firebase.getJSON(fbdo, "/smarthome100/bedroom", query1))
{
  //Success, then try to read the JSON payload value
  String s=fbdo.jsonString(); 
  Serial.println(s);
   l=s.length();
  Serial.println(l);
  Serial.println(s[l-6]);
  if(s[l-6]=='t'){
    digitalWrite(D2,LOW);
    Serial.print("bedroom bulb is ON");
  }
  else{
    digitalWrite(D2,HIGH);
    Serial.print("bedroom bulb is OFF");
  }
}

QueryFilter query2;

//Build query using specified child node key "bedroom_AC" under "name"
  query2.orderBy("name");
  query2.equalTo("bedroom_FAN");


if (Firebase.getJSON(fbdo, "/smarthome101/bedroom", query2))
{
  //Success, then try to read the JSON payload value
  String s1=fbdo.jsonString(); 
  Serial.println(s1);
  l1=s1.length();
  Serial.println(l1);
  Serial.println(s1[l1-6]);
  if(s1[l1-6]=='t'){
    digitalWrite(D4,LOW);
    Serial.print("bedroom fan  is ON");
  }
  else{
    digitalWrite(D4,HIGH);
    Serial.print("bedroom fan is OFF");
  }
}


query1.clear();
query2.clear();

}
else{
  digitalWrite(D5,LOW);
}
}