import processing.serial.*;

Serial arduinoPort;
String receivedMessage;
String[] positiveMessages = {
  "Great choices!\nKeep up the good work for a happy environment and a happy plant",
  "What you’re eating benefits everyone around you!\nKeep it up!",
  "Great nutritional values as well as saved resources in your food!\nThat’s how you should do it!",
};
String[] negativeMessages = {
  "That wasn’t the best choice for your plant.\nTo keep it growing and happy, buy something less resource-intensive next time.",
  "Keep your surroundings healthy by choosing better food next time.",
  "You can reduce your environmental impact by reducing the amount of red meat you bought.",
  "The plant suffers because of your choices.\nDo better next time ...",
  "You are doing a disservice to the community with your resource-intensive food choices.",
  "The food you’ve bought is proven to have a negative impact on the environment.\nDo better ..."
};
String[] provocativeNegMessages = {
  "You are destroying your environment with what you are doing!\nYour plant will die if you keep eating like that"
};
PFont font;
PShape sadPlant;
PShape happyPlant;

void setup() {
  String port = Serial.list()[2];
  arduinoPort = new Serial(this, port, 9600);
  
  font = createFont("custom.ttf",96);
  textFont(font);
  fullScreen();
  background(254, 239, 197);
  
  // Plant SVGs
  sadPlant = loadShape("plant_sad.svg");
  happyPlant = loadShape("plant_happy.svg");
}

void draw() {
  if (arduinoPort.available() > 0) {
    receivedMessage = arduinoPort.readStringUntil('\n');
    
    if (receivedMessage != null) {
      if (receivedMessage.contains("Pressed Negative")) {
        showMessageWithPicture(false);
      } else if (receivedMessage.contains("Pressed Positive")) {
        showMessageWithPicture(true);
      }
    }
  }
}

void showMessageWithPicture(boolean positive) {
  // Clear screen
  background(254, 239, 197);
  
  if (positive == true) {
    String positiveMessage = positiveMessages[int(random(positiveMessages.length - 1))];
    showText(positiveMessage);
    showPlantGraphic(false, true);
  } else {
    String negativeMessage = "";
    
    if (int(random(10)) > 7) {
      negativeMessage = provocativeNegMessages[0];
    } else {
      negativeMessage = negativeMessages[int(random(negativeMessages.length - 1))];
    }
    
    showPlantGraphic(true, false);
    showText(negativeMessage);
  }
}

void showText(String message) {
  fill(56,53,78);
  textAlign(CENTER);
  text(message, width*0.1, height*0.75, width*0.8, height*0.25); 
}

void showPlantGraphic(boolean sad, boolean happy) {
  float posX = width*0.4;
  float posY = height* 0.25;
  float shapeHeight = height*0.19;
  float shapeWidth = width*0.1;
  
  if (sad == true) {
    shape(sadPlant, posX, posY, shapeWidth, shapeHeight);
  } else if (happy == true) {
    shape(happyPlant, posX, posY, shapeWidth, shapeHeight);
  }
}
