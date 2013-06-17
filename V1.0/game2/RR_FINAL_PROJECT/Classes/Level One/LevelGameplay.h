//
//  LevelGameplay.h
//  RR_FINAL_PROJECT
//
//  Created by Ronan Sean on 21/01/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "Constants.h"
#import "Stanley.h"
#import "HelpMenu.h"
#import "PauseMenu.h"
#import "ORourke.h"
@class TalkMenu;
@class Receipt;
@class Key;
@class TouchPicture;
@class TouchDoor;
@class InventoryMenu;

// This class extends the CDLongAudioSourceDelegate, and inherits from CCLayer.

@interface LevelGameplay : CCLayer <CDLongAudioSourceDelegate>
{
    // These vars will be used to contain the rectangle around the
    // character oRourke and the inventory key. 
    CGRect oRourkeRect;
    CGRect inventoryBoundingBox;
    
    // Vars for storing the screen size, width and height.
    CGSize screenSize;
    float halfScreenWidth;
    float halfScreenHeight;
    
    // Vars for storing the height or width returned from various
    // object's classes.
    float characterWidth;
    float receiptHeight;
    float keyHeight;
    float tempCharWidth;
    float tempCharHeight;
    float keyIsDraggableWidth;
    float keyIsDraggableHeight;
    
    // Various BOOLS used to perform checks throughout gameplay.
    // Names are mostly self explanatory.
    BOOL flashingIndicatorsIsVisible;
    BOOL helpMenuIsVisible;
    BOOL pauseMenuIsVisible;
    BOOL talkMenuIsVisible;
    
    BOOL inventoryMenuIsVisible;
    BOOL isPickingUpReceipt;
    BOOL isPickingUpKey;
    BOOL receiptTouchedFirstTime;
    BOOL keyTouchedFirstTime;
    BOOL hideReceiptFlashingIndicator;
    BOOL hideKeyFlashingIndicator;
    BOOL oRourkeIsInTheScene;
    BOOL isFirstTimeORourkeTouch;
    BOOL keyIsDraggable;
    BOOL oRourkeEnter;
    
    
    CDLongAudioSource *rightChannel;
    
    // This var will hold a reference to a sound taht is currently playing
    NSMutableArray *soundsIdArr;
    ALuint soundEffectID;
    
    // Pointers to all of the objects created in the gameplay layer.
    Stanley *stanley;
    
    
    
    
    ORourke *orourke;
    HelpMenu *helpMenu;
    PauseMenu *pauseMenu;
    InventoryMenu *inventoryMenu;
    TalkMenu *talkMenu;
    Receipt *receiptIcon;
    Key *keyIcon;
    TouchPicture *invisiPicture;
    TouchDoor *invisiDoor;
 
 
    // Sprites for the different graphics in the gameplay layer.
    CCSprite *glassCase;
    CCSprite *bust;
    CCSprite *dragInventoryKey;
    CCSprite *flashingIndiReceipt;
    CCSprite *flashingIndiKey;
    CCSprite *flashingIndiPicture;
    CCSprite *flashingIndiDoor;
    CCSprite *labelBack;
    
    // Menu items for the in-game menu.
    CCMenuItem *pauseIcon;
    CCMenuItem *helpIcon;
    CCMenuItem *inventoryIcon;
    
    // Menu for in game menu.
    CCMenu *levelMenu;
    
    // These vars  are used to store actions.
    id removeItemActionOne;
    id removeItemActionTwo;
    
    // A callback object.
    CCCallFunc *removeItemActionThree;
    id removeItemSequence;
    
    // True type font lables.
    CCLabelTTF *receiptAddedLabel;
    CCLabelTTF *keyAddedLabel;
    
    // Pointer to a NSUserDefaults object used to interact with the defaults system.
    NSUserDefaults *allTasksStatus;
    
    // Strings to be set for each task that is completed,
    // they wil be written to the defaults system in order to manage
    // gamestate.
    NSString *taskOne;
    NSString *taskTwo;
    NSString *taskThree;
    NSString *taskFour;
}

// All intance methods.

-(void)setGameState:(NSString *)taskToSet;
-(void)showOrHideInventoryMenu;

-(void)showOrHideHelpMenu;
-(void)showOrHidePauseMenu;
-(void)showOrHideTalkMenu;


-(void)moveStanForTalk;
-(void)enterOrExitOrourke;
-(void)checkDropZone;
-(void)makeInventoryKeyTouchable;
-(void)makeORourkeTouchable;
-(void)timerRemoveFlashIndicators;
-(void)swipeShowFlashIndicators;
-(void)removeLabelsAndResetActions;
-(void)removeItemAndAddToIventory;
-(void)pickUpItem;
-(void)itemToPickUpTouched:(NSString *) itemToPickUp;
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)playSound:(NSString *)soundIdentifier;
-(void)stopAllSounds;
-(void)initAllAudio;
-(void)initMenuAndIconsAndImages;

@end
