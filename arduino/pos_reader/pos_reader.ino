 /*Pin layout used:
 * RST          48       
 * SDA(SS)      53        
 * MOSI         51        
 * MISO         50        
 * SCK          52        
 * */
#include <SPI.h>
#include <MFRC522.h>

#define RST_PIN      48
#define SS_PIN       53

MFRC522 reader(SS_PIN, RST_PIN);
MFRC522::StatusCode status;
MFRC522::MIFARE_Key key;

void setup() {
  SPI.begin();
  reader.PCD_Init();

  for(byte i=0; i < 6; i++){
    key.keyByte[i] = 0xFF;
  }
  
  Serial.begin(9600);
  Serial.println("Standing By...");
  
}

void loop() {
  if(reader.PICC_IsNewCardPresent() && reader.PICC_ReadCardSerial()){
    byte masterBuffer[18];
    byte size = sizeof(masterBuffer);
 
    status = (MFRC522::StatusCode) reader.PCD_Authenticate(MFRC522::PICC_CMD_MF_AUTH_KEY_A, 62, &key, &(reader.uid));

    if(status != MFRC522::STATUS_OK){
      //If authentication with the card fails return
      Serial.println("!");
      return;
    }

    status = (MFRC522::StatusCode) reader.MIFARE_Read(62, masterBuffer, &size);

    if(status == MFRC522::STATUS_OK){
      //Check whether the card is a Master Card
      
      if(masterBuffer[0] == 0xFF){
        byte count = masterBuffer[1];
        readFromMaster(count);
      }
    }

    reader.PICC_HaltA();
    reader.PCD_StopCrypto1();
    
  }
}

void readFromMaster(byte count){
  Serial.print("r");
  
  for(byte i = 0; i < 3; i++){
    byte buffer[18];    
    byte size = sizeof(buffer);
    
    status = (MFRC522::StatusCode) reader.PCD_Authenticate(MFRC522::PICC_CMD_MF_AUTH_KEY_A, i + 4, &key, &(reader.uid));

    if(status != MFRC522::STATUS_OK){
      Serial.print("!");
      return;
    }
    
    status = (MFRC522::StatusCode) reader.MIFARE_Read(i + 4, buffer, &size);

    if(status == MFRC522::STATUS_OK){
      for(byte j = 0; j < 16 && count > 0; j+=4){
        Serial.print("*");
        dump_byte_array(buffer, 4 + j, j);;
        count--;
      }
    }
  }

  Serial.print("s");
  return;
}

void dump_byte_array(byte *arr, byte size, byte start){
  for(byte i = start; i < size; i++){
    Serial.print(arr[i] < 0x10 ? "0" : "");
    Serial.print(arr[i], HEX);  
  }
}

