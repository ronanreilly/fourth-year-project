//
//  Constants.h
//  RR_FINAL_PROJECT
//
//  Created by Ronan Sean Reilly on 26/01/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#ifndef RR_FINAL_PROJECT_Constants_h
#define RR_FINAL_PROJECT_Constants_h

// TIDY FILE AND VALUES --- NB NB NB NB 

// Constants For:
// Level One.

#define kStanleySpriteZValue 60
#define kStanleySpriteTagValue 0
#define kORourkeSpriteZValue 40
#define kORourkeSpriteTagValue 2

#define kGlassCaseZValue 120
#define kBustZValueZValue 30
#define kInvisiItemsZvalue 300
#define kDragabbleKeyZValue 400

#define kInvisReceiptTagValue 4
#define kInvisKeyTagValue 6
#define kInvisPictureTagValue 8
#define kInvisDoorTagValue 10

#define kItemAddedLabelZValue 400
#define kLabelBackZValue 380
#define kItemReceiptAddedLabelTagValue 12
#define kItemKeyAddedLabelTagValue 14





#define kMenuZValue 100
#define kMenuTagValue 16



#define kReceiptIconZvalue 40
#define kReceiptIconTagVale 18

#define kKeyIconZValue 300
#define kKeyIconTagVale 300

#define kFlashIndicator1Zvalue 100
#define kFlashIndicator2Zvalue 100
#define kFlashIndicator3Zvalue 100
#define kFlashIndicator4Zvalue 100
#define kFlashIndicator1TagValue 20
#define kFlashIndicator2TagValue 22
#define kFlashIndicator3TagValue 24
#define kFlashIndicator4TagValue 26

#define kRemoveObjectTypeReceipt @"receipt"
#define kDescribeKeyOnFloor @"receipt_on_floor"
#define kRemoveObjectTypeKey @"key"
#define kDescribeReceiptOnFloor @"key_on_floor"
#define kDescribeObjectTypePicture @"picture"
#define kDescribeObjectTypeDoor @"door"
#define kDescribeObjectORourke @"orourke"
#define kKeyDoesNotGoThere @"no_keys_position"

// DESCRIBE CONSTANTS HERE


// IN GAME MENUS
#define kAllInGameMenuBackZValues 200
#define kAllInGameMenuItemZValues 250
#define kInventoryIcon1TagValue 28

// Constants For:
// Level One Pause Menu.


// Constants For:

// Main Menu Scene, End Game Menu Scene, In-Game Choose Menu Scene, Choose Level Menu Scene,
// Cut Scene.

#define kMainMenuBackgroundZValue 10
#define kMainMenuButtonZValues 20
#define kMainMenuZValue 20

#define kCutSceneAnimationZValue 20
#define kCutSceneTutMenu 1000
#define kCutSceneTimerBarBottomZValue 40
#define kCutSceneTimerBarTopZValue 60
#define kCutSceneMenuZValue 80


// GAME STATE IDENTIFIERS
#define kTaskOne @"done1"
#define KTaskTwo @"done2"
#define KTaskThree @"done3"
#define kTaskFour @"done4"



// AUDIO CONSTANTS

// Buttons
#define aButtonOneSound @"buttonOne.mp3"
#define aButtonTwoSound @"buttonTwo.mp3"
#define aButtonThreeSound @"ButtonThree.mp3"
#define aLevelGameplayButton @"inGameButton.mp3"

// Background Tracks
#define aChooseMenBackground @"chooseBackgroundMusic.mp3"
#define aEndGameMenBackground @"endGameCheer.mp3"
#define aMainMenBackground @"mainMenuBackgroundMusic.mp3"

// Cut Scene Audio
#define aCutSceneOnLoad @"cutSceneMain.mp3"
#define aCutSceneEnd @"endAnimation.mp3"

// Level Gameplay
#define aLevelGameplayOnLoad @"onLoadLevel.mp3"
#define aLevelGameplayDoorDescript @"doorDescript.mp3"
#define aLevelGameplayKeyDescript @"keyOnFloor.mp3"
#define aLevelGameplayReceiptDescript @"paperOnFloor.mp3"
#define aLevelGameplayPictureDescript @"pictureDescript.mp3"
#define aLevelGameplayReceiptInvDescript @"receiptInvDescript.mp3"
#define aLevelGameplayKeyInvDescript @"keyInvDescript.mp3"
#define aLevelGameplayORourkeDescript @"oRourkeDescript.mp3"

#define aLevelGameplayKeyDroppedOk @"keyDroppedOk.mp3"
#define aLevelGameplayKeyFinalFits @"keyFinalFits.mp3"
#define aLevelGameplayKeyNotReady @"keyNotReady.mp3"
#define aLevelGameplayKeyNo @"keyNotRightPos.mp3"

#define aLevelGameplayORourkeEnter @"oRourkeEnter.mp3"
#define aLevelGameplayORourkeExit @"oRourkeLeave.mp3"

#define aLevelGameplayMenuShow @"inGameMenuShow.mp3"
#define aLevelGameplayInvItemAdded @"inventoryItemAdded.mp3"

// Talk Menu Items
#define aLevelGameplayPicTalk @"pictureTalk.mp3"
#define aLevelGameplayThugsTalk @"thugsTalk.mp3"
#define aLevelGameplayCsiTalk @"csiTalk.mp3"

// Walk, Resume Game
#define aLevelGameplayStanResume @"stanResumeGame.mp3"
#define aLevelGameplayWalkLeft @"walkLeft.mp3"
#define aLevelGameplayWalkRight @"walkRight.mp3"




#endif
