 /*Pin layout used:
 * RST          D9       
 * SDA(SS)      D10        
 * MOSI         D11        
 * MISO         D12        
 * SCK          D13        
 * */
 
#include <SPI.h>
#include <MFRC522.h>

#define RST_PIN   9
#define SS_PIN    10

byte classicBuffer[3][16];

byte classicBlock, classicPtr;

byte classicCount = 0;

MFRC522::StatusCode status;

MFRC522 reader(SS_PIN, RST_PIN);
MFRC522::MIFARE_Key key;

void setup() {
  Serial.println("Tagger Reader (Basket) ...");
  SPI.begin();
  reader.PCD_Init();

  for(byte i=0; i < 6; i++){
    key.keyByte[i] = 0xFF;
  }

  initializeBuffer(3);
  
  Serial.begin(9600);
  Serial.println("Standing By...");
}

void loop() {
  if(reader.PICC_IsNewCardPresent() && reader.PICC_ReadCardSerial()){
    Serial.println("Card found...");
    status = (MFRC522::StatusCode) reader.PCD_Authenticate(MFRC522::PICC_CMD_MF_AUTH_KEY_A, 62, &key, &(reader.uid));

    if(status == MFRC522::STATUS_OK){
      //Authentication success

      bool isMasterCard = readMasterByte();
      
      if(!isMasterCard){
        //Not a master card but a regular tag 
        //Write data to arduino memory
        classicCount++;
        writeToClassicBuffer(reader.uid.uidByte);
      }
      else{
        //A master card! Dump data and note the number of tags
        Serial.println("Master Card Detected....");
        
        //Read master buffer
        byte masterBuffer[18];
        byte size = sizeof(masterBuffer);
        
        status = (MFRC522::StatusCode) reader.MIFARE_Read(62, masterBuffer, &size);

        if(status == MFRC522::STATUS_OK && classicCount > 0){
          masterBuffer[1] = classicCount;
          classicCount = 0;

          status = (MFRC522::StatusCode) reader.PCD_Authenticate(MFRC522::PICC_CMD_MF_AUTH_KEY_A, 62, &key, &(reader.uid));

          if(status == MFRC522::STATUS_OK){
            status = (MFRC522::StatusCode) reader.MIFARE_Write(62, masterBuffer, 16);
          }

          for(byte i = 0; i < 3; i++){
            status = (MFRC522::StatusCode) reader.PCD_Authenticate(MFRC522::PICC_CMD_MF_AUTH_KEY_A, i + 4, &key, &(reader.uid));
            status = (MFRC522::StatusCode) reader.MIFARE_Write(i + 4, classicBuffer[i], 16);

            if(status == MFRC522::STATUS_OK){
              Serial.println("Write success...");
            }
          }

          initializeBuffer(3);
        }
      }
    }
    else{
      //Authentication failed
      Serial.println("Authentication failure");
    }   
      
  }

  reader.PICC_HaltA();
  reader.PCD_StopCrypto1();  

}

bool readMasterByte(){
  //Master cards are the NFC cards which are used to transfer data from one arduino board to another
  //Whether the card is a master card or not is determined by reading the first byte of the 62nd memory block
  //If it has the hex value 0xFF then it is recognized as a master card. The function does that
  
  byte masterBuffer[18];
  byte size = sizeof(masterBuffer);  

  //Use block 62 as master data block which contains whether the nfc card is a master card
  status = (MFRC522::StatusCode) reader.MIFARE_Read(62, masterBuffer, &size);

  if(status == MFRC522::STATUS_OK){
    byte masterByte = masterBuffer[0];

    if(masterByte == 0xFF){
      return true;
    }
    else{
      return false;
    }
  }
  else{
    Serial.println("Read error");
  }

}

bool writeMasterBit(){
  //This is a utility function which makes a smart card a Master Card by writing to 62nd block
  byte masterBuffer[18];

  for(byte i = 0; i < 18; i++){
    masterBuffer[i] = 0;
  }
  
  masterBuffer[0] = 0xFF;

  status = (MFRC522::StatusCode) reader.MIFARE_Write(62, masterBuffer, 16);

  if(status == MFRC522::STATUS_OK){
    return true;
  }
  else{
    return false;
  }
}


void printBuffer(byte *buffer, byte size){
  for(byte i = 0; i < size; i++){
    Serial.print(buffer[i] < 0x10 ? "0" : "");
    Serial.print(buffer[i], HEX);
  }

  Serial.println();
}

void writeToClassicBuffer(byte *uid){
   
  if(classicPtr == 15){
    classicPtr = 0;
    classicBlock++;
  }

  for(byte i = 0; i < 4; i++){
    classicBuffer[classicBlock][classicPtr] = uid[i];
    classicPtr++;  
  }

  printBuffer(classicBuffer[classicBlock], 16);
  return;
}

void initializeBuffer(int numBlock){
  for(byte i = 0; i <  numBlock; i++){
    for(byte j = 0; j < 16; j++){
      classicBuffer[i][j]  = 0x00;
    }
  }
}

