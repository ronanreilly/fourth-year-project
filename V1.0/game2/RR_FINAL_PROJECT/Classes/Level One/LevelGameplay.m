//
//  LevelGameplay.m
//  RR_FINAL_PROJECT
//
//  Created by Ronan Sean on 21/01/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
// Class Description Below:
//
// This class is were all the action happens. This class contains instances of all the objects, charcter, stanley,
// receipt, key, touch, picture, touch door, inventory menu and talk menu. This layer is the layer that the user interacts with.
// It handles its own touch events and manages general gameplay, gamestate and audio.
//
//

#import "LevelGameplay.h"
#import "Receipt.h"
#import "Key.h"
#import "TouchPicture.h"
#import "TouchDoor.h"
#import "InventoryMenu.h"
#import "TalkMenu.h"
#import "EndGameMenuScene.h"

@implementation LevelGameplay

// Dealloc all objects created when this class is removed.
-(void) dealloc
{
    [super dealloc];
    [stanley dealloc];
    [orourke dealloc];
    [helpMenu dealloc];
    [pauseMenu dealloc];
    [inventoryMenu dealloc];
    [keyIcon dealloc];
    [receiptIcon dealloc];
    [invisiPicture dealloc];
    [invisiDoor dealloc];
    [talkMenu dealloc];
    [soundsIdArr dealloc];
}

#pragma mark Game State Setter

// This method takes a string. Strings passed to this method are used
// to identify what task has been completed. These strings are defined in the
// Contants.h file. When a match is found this method will write a string
// that is also defined in Constants.h with a key pair to the default system
// Using NSUserDefaults interface.
//
// The technuiques used to write to the default system in this method were taken and adpated from the tutorial
// below by Bob Euland:
// http://bobueland.com/cocos2d/2011/how-to-save-data-in-a-plist/
//
-(void)setGameState:(NSString *)taskToSet
{
    CCLOG(@"LEVEL GAMEPLAY setGameState CALLED");
    // Check if string passed to this method is equal to kTaskOne
    // from the contants file. 
    if ([taskToSet isEqual: kTaskOne])
    {
        // If it is write it to the users default database. 
        [allTasksStatus setObject:kTaskOne forKey:@"TaskOneDone"];
        // Writes any modifications to the persistent domains to disk and updates // From Apple Doc
        // all unmodified persistent domains to what is on disk.
        [allTasksStatus synchronize];
        // Assigning the string task one the value just written to the database.
        // This can be used for checks during gameplay.
        taskOne = [allTasksStatus objectForKey:@"TaskOneDone"];
        
        // The process is the same for the rest of these checks.
    }
    else if ([taskToSet isEqual: KTaskTwo])
    {
        [allTasksStatus setObject:KTaskTwo forKey:@"TaskTwoDone"];
        [allTasksStatus synchronize];
        taskTwo = [allTasksStatus objectForKey:@"TaskTwoDone"];
    }
    else if ([taskToSet isEqual: KTaskThree])
    {
        [allTasksStatus setObject:KTaskThree forKey:@"TaskThreeDone"];
        [allTasksStatus synchronize];
        taskThree = [allTasksStatus objectForKey:@"TaskThreeDone"];
    }
    else if ([taskToSet isEqual: kTaskFour])
    {
        [allTasksStatus setObject:kTaskFour forKey:@"TaskFourDone"];
        [allTasksStatus synchronize];
        taskFour = [allTasksStatus objectForKey:@"TaskFourDone"];
        // SLIGHT DIFFERENCE HERE.
        // Last task is completed so load the end game scene.
        [[CCDirector sharedDirector] pushScene:[EndGameMenuScene node]];
    }
}

#pragma mark Show or Hide Menu Methods

// All of these four methods are used to hide or show
// in game menus.

// This menu method is slightly different than the other three.
-(void)showOrHideInventoryMenu
{
    CCLOG(@"LEVEL GAMEPLAY showOrHideHelpMenu CALLED");
    // Stop any sounds.
    [self stopAllSounds];
    // Play preloaded sound effect for this button.
    [self playSound:aButtonOneSound];
    if(pauseMenuIsVisible == YES) // Check is pause menu is on screen, if true, remove it. 
    {
        [pauseMenu addOrRemoveThisMenu];
        pauseMenuIsVisible = NO;
    }
    if (helpMenuIsVisible ==YES) // Check is help menu is on screen, if true, remove it.
    {
        [helpMenu addOrRemoveThisMenu];
        helpMenuIsVisible = NO;
    }
    if(talkMenuIsVisible == YES) // Check is talk menu  on screen, if true, remove it.
    {
        [talkMenu addOrRemoveThisMenu];
        talkMenuIsVisible = NO;
    }
    if (inventoryMenuIsVisible == NO) // If inventory menu is not already visible.
    {
        [self stopAllSounds];
        // Play sound defined in Contants.h
        [self playSound:aLevelGameplayMenuShow];
        // Call the inventory menu show or hide method.
        [inventoryMenu addOrRemoveThisMenu];
        // Set bool to show if this menu is visible.
        inventoryMenuIsVisible = YES;
        
        NSString *temp1 = @"done1";
        NSString *temp2 = @"done2";
        
        // This whole check will only go ahead if the key has been picked up.
        // If the key only has been picked up then the key is the first item in the menu.
        // If the receipt and key have been picked up then the key is the secon item in the
        // inventory menu.
        if ([taskTwo isEqual:KTaskTwo])
        {
            // KEY YES -- RECEIPT NO
            if ([taskTwo isEqual:KTaskTwo] && taskOne != temp1)
            {
                [inventoryMenu moveKey];
                
                // Positions are different on iPad and iPhone.
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    dragInventoryKey.position = ccp((halfScreenWidth) - (90), (halfScreenHeight) + (240));
                }
                else
                {
                    dragInventoryKey.position = ccp((halfScreenWidth) - (50), (halfScreenHeight) + (100));
                }
            }
            // RECEIPT YES -- KEY YES
            if ([taskOne isEqual:kTaskOne] && taskTwo == temp2)
            {
                [inventoryMenu moveKey];
                // Positions are different on iPad and iPhone.
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    dragInventoryKey.position = ccp((halfScreenWidth) + (90), (halfScreenHeight) + (240));
                }
                else
                {
                    dragInventoryKey.position = ccp((halfScreenWidth) + (50), (halfScreenHeight) + (100));
                }
            }
        }
        // KEY NO -- RECEIPT NO
        else if (taskOne != temp1 && taskTwo != temp2)
        {
            dragInventoryKey.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        }
    }
    else
    {
        // The menu is already visble so remove it.
        
        [self stopAllSounds];
        [self playSound:aLevelGameplayMenuShow];
        [inventoryMenu addOrRemoveThisMenu];
        inventoryMenuIsVisible = NO;
        dragInventoryKey.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
    }
}

// See above for description of how these methods work.

-(void)showOrHideHelpMenu
{
    CCLOG(@"LEVEL GAMEPLAY showOrHideHelpMenu CALLED");
    [self stopAllSounds];
    [self playSound:aButtonOneSound];
    if(pauseMenuIsVisible == YES)
    {
        [pauseMenu addOrRemoveThisMenu];
        pauseMenuIsVisible = NO;
        dragInventoryKey.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
    }
    if (inventoryMenuIsVisible == YES)
    {
        [inventoryMenu addOrRemoveThisMenu];
        inventoryMenuIsVisible = NO;
        dragInventoryKey.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
    }
    if(talkMenuIsVisible == YES)
    {
        [talkMenu addOrRemoveThisMenu];
        talkMenuIsVisible = NO;
        dragInventoryKey.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
    }
    if (helpMenuIsVisible == NO)
    {
        [self stopAllSounds];
        [self playSound:aLevelGameplayMenuShow];
        [helpMenu addOrRemoveThisMenu];
        helpMenuIsVisible = YES;
    }
    else
    {
        [self stopAllSounds];
        [self playSound:aLevelGameplayMenuShow];
        [helpMenu addOrRemoveThisMenu];
        helpMenuIsVisible = NO;
    }
}

// See above for description of how these methods work.

-(void)showOrHidePauseMenu
{
    CCLOG(@"LEVEL GAMEPLAY showOrHidePauseMenu CALLED");
    // Stop any sounds playing.
    [self stopAllSounds];
    // Play the pre-defined sound for showing or hiding a menu from the constants file.
    [self playSound:aButtonOneSound];
    // If the inventory menu is visible remove it before showing the pause menu.
    if(inventoryMenuIsVisible == YES)
    {
        [inventoryMenu addOrRemoveThisMenu];
        inventoryMenuIsVisible = NO;
        dragInventoryKey.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
    }
    // If the help menu is visible remove it before showing the pause menu.
    if (helpMenuIsVisible == YES)
    {
        [helpMenu addOrRemoveThisMenu];
        helpMenuIsVisible = NO;
    }
    // If the talk menu is visible remove it before showing the pause menu.
    if(talkMenuIsVisible == YES)
    {
        [talkMenu addOrRemoveThisMenu];
        talkMenuIsVisible = NO;
        dragInventoryKey.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
    }
    // If the pause menu is not visible call the pause menu's addOrRemoveThisMenu method.
    if (pauseMenuIsVisible == NO)
    {
        // Stop any sound that is currently playing.
        [self stopAllSounds];
        // Play the pre-defined sound for showing or hiding a menu from the constants file.
        [self playSound:aLevelGameplayMenuShow];
        [pauseMenu addOrRemoveThisMenu];
        // Set the boolean that keeps track of wheter this menu is visible to true. 
        pauseMenuIsVisible = YES;  
    }
    else
    // if the pause menu is already visible remove it and set its boolean to keep track wheter this menu is visible to false.
    {
        // Stop any sound that is currently playing.
        [self stopAllSounds];
        // Play the pre-defined sound for showing or hiding a menu from the constants file.
        [self playSound:aLevelGameplayMenuShow];
        // Call the pause menu's addOrRemoveThisMenu method to remove the menu.
        [pauseMenu addOrRemoveThisMenu];
        // Set the boolean that keeps track of wheter this menu is visible to false.
        pauseMenuIsVisible = NO;
    }
}

// See above for description of how these methods work.

-(void)showOrHideTalkMenu
{
    CCLOG(@"LEVEL GAMEPLAY showOrHidePauseMenu CALLED");
    [self stopAllSounds];
    [self playSound:aButtonOneSound];
    if(inventoryMenuIsVisible == YES)
    {
        [inventoryMenu addOrRemoveThisMenu];
        inventoryMenuIsVisible = NO;
        dragInventoryKey.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
    }
    if (helpMenuIsVisible == YES) {
        [helpMenu addOrRemoveThisMenu];
        helpMenuIsVisible = NO;
    }
    if (pauseMenuIsVisible == YES) {
        [pauseMenu addOrRemoveThisMenu];
        pauseMenuIsVisible = NO;
    }
    if (talkMenuIsVisible == NO) {
        [self stopAllSounds];
        [self playSound:aLevelGameplayMenuShow];
        [talkMenu addOrRemoveThisMenu];
        talkMenuIsVisible = YES;
        dragInventoryKey.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
    }
    else
    {
        [self stopAllSounds];
        [self playSound:aLevelGameplayMenuShow];
        [talkMenu addOrRemoveThisMenu];
        talkMenuIsVisible = NO;
    }
}

#pragma mark ORourke Control

// This method is called when the user touches the oRourke character.
// its is an attempt to have Stanley face the oRourke character when
// they are in conversation.

-(void)moveStanForTalk
{
    CCLOG(@"LEVEL GAMEPLAY moveStanForTalk CALLED");
    
    // If Stanley is behind oRourke.
    if (stanley.position.x > orourke.position.x)
    {
        CCLOG(@"GREATER THAN");
        [self stopAllActions]; // Stop all actions in this layer.
        [stanley stopActions]; // Stop any actions currently running in stanleys class.
        [self stopAllSounds]; // Stop all Sounds.
        [stanley walkLeft]; // Call Stanley's walk left animation method.
        // Move to a position in front of oRourke.
        [stanley runAction:[CCMoveTo actionWithDuration:1.75 position:ccp((orourke.position.x - glassCase.contentSize.width),
                                                                          (stanley.position.y))]];
    }
    // If Stanley is on front of oRourke.
    else if (stanley.position.x < orourke.position.x)
    {   // See above for description
        CCLOG(@"LESS THAN");
        [self stopAllActions]; // Stop all actions in this layer.
        [stanley stopActions]; // Stop any actions currently running in stanleys class.
        [self stopAllSounds]; // Stop all Sounds.
        [stanley walkRight]; // Call Stanley's walk right animation method.
        // Move to a position in front of oRourke.
        [stanley runAction:[CCMoveTo actionWithDuration:1.75 position:ccp((orourke.position.x - glassCase.contentSize.width),
                                                                          (stanley.position.y))]];
    }
    else if ((stanley.position.x)  ==  (orourke.position.x - glassCase.contentSize.width))
    {
        CCLOG(@"IN POSITION");
        [self stopAllActions];
        [stanley stopActions];
        [stanley stopAllActions];
    }
}

// This method looks after oRourkes entry and exit. The first time the method is called ORourke enters.
// the second time he leaves. It is called the first time from the inventory setGameState method when both the key
// and receipt have been picked up.
-(void)enterOrExitOrourke
{
    CCLOG(@"LEVEL GAMEPLAY enterOrExitOrourke CALLED");
    
    // If on iPad
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // He is not on screen yet.
        if (oRourkeIsInTheScene == NO)
        {
            // oRourke is positioned of the screen originally.
            
            [self stopAllActions]; // stop any actions for this layer.
            [orourke stopActions]; // stop any actions in oRourkes class.
            [stanley stopActions]; // Stop any actions in Stanleys class.
            [self stopAllSounds]; // stop any sounds.
            [self playSound:aLevelGameplayWalkRight]; // Play his entry audio.
            [orourke walkLeft]; // Call ORourkes walk left animation.
            // Run an action to move him on screen over 1.5 seconds.
            [orourke runAction:[CCMoveTo actionWithDuration:1.5 position:ccp((bust.position.x - bust.contentSize.width),
                                                                             (screenSize.height) * (0.35f))]];
            oRourkeIsInTheScene = YES;
            //Used to check if he is on screen.
            oRourkeEnter = YES;
            // Wait 4 seconds before making oRourke touchable.
            [self performSelector:@selector(makeORourkeTouchable) withObject:nil afterDelay:4.0];
        }
        // The opposite to above, make him leave. 
        else if (oRourkeIsInTheScene == YES)
        {
            [self stopAllActions];
            [orourke stopActions];
            [stanley stopActions];
            [self playSound:aLevelGameplayWalkRight];
            [orourke walkRight];
            [orourke runAction:[CCMoveTo actionWithDuration:2.5 position:ccp((screenSize.width) + (glassCase.contentSize.width * 2),
                                                                             (screenSize.height) * (0.35f))]];
            talkMenu.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            oRourkeIsInTheScene = NO;
            oRourkeEnter = NO;
        }
    }
    // If on iPhone execute this code.
    // SEE ABOVE FOR DESCRIPTION
    else
    {
        if (oRourkeIsInTheScene == NO)
        {
            [self stopAllActions];
            [orourke stopActions];
            [stanley stopActions];
            [self stopAllSounds];
            [self playSound:aLevelGameplayWalkRight];
            [orourke walkLeft];
            [orourke runAction:[CCMoveTo actionWithDuration:2.0 position:ccp((bust.position.x - bust.contentSize.width), (screenSize.height) *(0.32f))]];
            oRourkeIsInTheScene = YES;
            oRourkeEnter = YES;
            
            // PLAY OROURKE ENTER AUDIO
        }
        else if (oRourkeIsInTheScene == YES)
        {
            [self stopAllActions];
            [orourke stopActions];
            [stanley stopActions];
            [self playSound:aLevelGameplayWalkRight];
            [orourke walkRight];
            [orourke runAction:[CCMoveTo actionWithDuration:2.5 position:ccp(screenSize.width + (halfScreenWidth), (screenSize.height) * (0.32f))]];
            talkMenu.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            oRourkeIsInTheScene = NO;
            oRourkeEnter = NO;
        }
    }
    [self performSelector:@selector(makeORourkeTouchable) withObject:nil afterDelay:4.0];
}

// This method gets oRourkes width and height from his class
// and uses the results to make a rectangle around oRourkes final resting place
// so he can be touched. This will allow for the user to bring up or hide the
// talk menu.
-(void)makeORourkeTouchable
{
    CCLOG(@"LEVEL GAMEPLAY makeORourkeTouchable CALLED");
    // Get oRourkes height and store the result here.
    tempCharHeight = [orourke returnCharacterHeight];
    // Get oRourkes width and store the result here.
    tempCharWidth = [orourke returnCharacterWidth];
    CCLOG(@"ORourke height is %f and his height is %f", tempCharHeight, tempCharWidth);
    
    // Make a CGRect around oRourke.
    oRourkeRect =  CGRectMake(orourke.position.x, orourke.position.y, tempCharWidth, tempCharWidth);
    
    if (oRourkeEnter == YES) {
        [self stopAllSounds];
        [self playSound:aLevelGameplayORourkeEnter];
        oRourkeEnter = NO;
    }
}

// This method is called when the user drops the inventory key object from the ccTouchesEnded method. This method
// performs checks to determine what tasks are complete. If it determines that tasks one two and three are not complete
// its snaps the key back to its position in the inventory menu.

#pragma mark Key Drop Zone Checker & Control
-(void)checkDropZone
{
    CCLOG(@"LEVEL GAMEPLAY checkDropZone CALLED");
    
    // These strings are used to compare against the tasks written to the defaults system.
    NSString *temp1; temp1 = @"done1";
    NSString *temp2; temp2 = @"done2";
    NSString *temp3; temp3 = @"done3";
    
    // CHECK ONE --
    // TASKS ONE TWO AND THREE ARE COMPLETE:
    if (taskOne == temp1 && taskTwo == temp2 && taskThree == temp3) {
        // is application on iPad?
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            // If the key has been dropped at the correct position or drop zone.
            if (((dragInventoryKey.position.x) == (screenSize.width - keyIsDraggableWidth)) &&
                ((dragInventoryKey.position.y) <= ((screenSize.height/2) - 20) +   (keyIsDraggableHeight/2)))
            {
                // Stop any sound playing.
                [self stopAllSounds];
                // Play the pre-defined audio clip from the constants file, this sound is a door opening.
                [self playSound:aLevelGameplayKeyDroppedOk];
                [self stopAllSounds];
                // Play the pre-defined audio clip from the constants file, saying the key fits.
                [self playSound:aLevelGameplayKeyFinalFits];
                // Set the game states final task.
                [self setGameState:kTaskFour];
                CCLOG(@"GAME COMPLETED");
            }
            // If the key has not been dropped on the right drop zone.
            else
            {
                // PLAY AUDIO TO SAY NAH I DONT THINK SO.
                CCLOG(@"KEY IS IN WRONG PLACE");
                // Stop any sound playing.
                [self stopAllSounds];
                // Play the pre-defined audio clip from the constants file, saying the key does not fit.
                [self playSound:aLevelGameplayKeyNo];
                // Snap the key back to it's position in the inventory menu.
                dragInventoryKey.position = ccp((halfScreenWidth) + (90), (halfScreenHeight) + (240));
                // Make the key touchable again.
                [self makeInventoryKeyTouchable];
            }
        }
        // Or IPhone?
        // This is the same as the code above but is only executed on iPhone.
        else
        {
            if (((dragInventoryKey.position.x) == (screenSize.width - keyIsDraggableWidth)) &&
                ((dragInventoryKey.position.y) <= ((screenSize.height/2) - 10) +   (keyIsDraggableHeight/2)))
            {
                [self stopAllSounds];
                [self playSound:aLevelGameplayKeyDroppedOk];
                [self stopAllSounds];
                [self playSound:aLevelGameplayKeyFinalFits];
                [self setGameState:kTaskFour];
                [self setGameState:kTaskFour];
                CCLOG(@"GAME COMPLETED");
            }
            else
            {
                // PLAY AUDIO TO SAY NAH I DONT THINK SO
                CCLOG(@"KEY IS IN WRONG PLACE");
                
                [self stopAllSounds];
                [self playSound:aLevelGameplayKeyNo];
                
                dragInventoryKey.position = ccp((halfScreenWidth) + (50), (halfScreenHeight) + (100));
                [self makeInventoryKeyTouchable];
            }
        }
    }
    // CHECK TWO --
    // TASKS ONE NOT COMPLETE, TASK TWO COMPLETE AND TASK THREE NOT COMPLETE:
    else if (taskOne != temp1 && taskTwo == temp2 && taskThree != temp3 )
    {
        CCLOG(@"JUST KEY");
        // is application on iPad?
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            // Snap the inevtory key back to the inventory menu.
            dragInventoryKey.position = ccp((halfScreenWidth) - (90), (halfScreenHeight) + (240));
            [self stopAllSounds];
            // Play the pre-defined audio clip from the constants file, saying the key does not fit.
            [self playSound:aLevelGameplayKeyNotReady];
        }
        // is application on iPhone?
        // This is the same as the code above but is only executed on iPhone.
        else
        {
            dragInventoryKey.position = ccp((halfScreenWidth) - (50), (halfScreenHeight) + (100));
            [self stopAllSounds];
            [self playSound:aLevelGameplayKeyNotReady];
        }
    }
    // CHECK TWO --
    // TASKs ONE COMPLETE, TASK TWO COMPLETE AND TASK THREE NOT COMPLETE:
    else if (taskOne == taskOne && taskTwo == temp2 && taskThree != temp3)
    {
        CCLOG(@"KEY AND RECEIPT");
        // is application on iPad?
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            // Snap the inevtory key back to the inventory menu.
            dragInventoryKey.position = ccp((halfScreenWidth) + (90), (halfScreenHeight) + (240));
            [self stopAllSounds];
            // Play the pre-defined audio clip from the constants file, saying the key does not fit.
            [self playSound:aLevelGameplayKeyNotReady];;
        }
        // is application on iPhone?
        // This is the same as the code above but is only executed on iPhone.
        else
        {
            dragInventoryKey.position = ccp((halfScreenWidth) + (50), (halfScreenHeight) + (100));
            [self stopAllSounds];
            [self playSound:aLevelGameplayKeyNotReady];
        }
    }
}

// This method creates a CGRect around the inventory key object.

-(void)makeInventoryKeyTouchable
{
    CCLOG(@"LEVEL GAMEPLAY makeInventoryKeyTouchable CALLED");
    // Get the key sprites width and strore it here.
    keyIsDraggableWidth = dragInventoryKey.contentSize.width/2;
    // Get the key sprites height and strore it here.
    keyIsDraggableHeight = dragInventoryKey.contentSize.height/2;
    
    CCLOG(@"Inventory Key height is %f and his width is %f", keyIsDraggableHeight, keyIsDraggableWidth);
    
    // Create a CGRect around the key sprite.
    inventoryBoundingBox =  CGRectMake((dragInventoryKey.position.x) - (keyIsDraggableWidth),
                                       (dragInventoryKey.position.y - keyIsDraggableHeight), (dragInventoryKey.contentSize.width), (dragInventoryKey.contentSize.height));
}

#pragma mark Flash Indicators Control

-(void)timerRemoveFlashIndicators
{
     CCLOG(@"LEVEL GAMEPLAY timerRemoveFlashIndicators CALLED");
     [self stopAllActions];
     [stanley stopActions];
     flashingIndicatorsIsVisible = NO;
     CCLOG(@"FLASHING INDICATORS ARE VISIBLE!");
 
     if (hideReceiptFlashingIndicator && hideKeyFlashingIndicator)
     {
         flashingIndiDoor.opacity = 0;
         flashingIndiPicture.opacity = 0;
     }
     else if (hideReceiptFlashingIndicator)
     {
         flashingIndiDoor.opacity = 0;
         flashingIndiPicture.opacity = 0;
         flashingIndiKey.opacity = 0;
     }
     else if (hideKeyFlashingIndicator)
     {
         flashingIndiDoor.opacity = 0;
         flashingIndiPicture.opacity = 0;
         flashingIndiReceipt.opacity = 0;
     }
     else
     {
         flashingIndiDoor.opacity = 0;
         flashingIndiPicture.opacity = 0;
         flashingIndiKey.opacity = 0;
         flashingIndiReceipt.opacity = 0;
     }
 }

// This method is called to show the flashing inidicators
// by increasing their opacity from 0 to 255.
-(void)swipeShowFlashIndicators
{
    CCLOG(@"LEVEL GAMEPLAY swipeShowFlashIndicators CALLED");
    // Stop any actions this class is running.
    [self stopAllActions];
    // stop any actions currently running on the Staney object.
    [stanley stopActions];
    // Used to check if flashing indicators are visible, set it to true.
    flashingIndicatorsIsVisible = YES;
    
    if (flashingIndicatorsIsVisible)
    {
        CCLOG(@"FLASHING INDICATORS ARE VISIBLE!");
        // If the key & receipt have been picked up.
        if (hideReceiptFlashingIndicator && hideKeyFlashingIndicator)
        {
            // Only show the flashing indicators at the door and picture.
            flashingIndiDoor.opacity = 255;
            flashingIndiPicture.opacity = 255;
        }
        // If the receipt has been picked up and the key has not.
        else if (hideReceiptFlashingIndicator)
        {
            // Only show the flashing indicators at the door, picture and key.
            flashingIndiDoor.opacity = 255;
            flashingIndiPicture.opacity = 255;
            flashingIndiKey.opacity = 255;
        }
        // If the key has been picked up and the receipt has not.
        else if (hideKeyFlashingIndicator)
        {
            // Only show the flashing indicators at the door, picture and receipt.
            flashingIndiDoor.opacity = 255;
            flashingIndiPicture.opacity = 255;
            flashingIndiReceipt.opacity = 255;
        }
        // If neither the key or receipt has been picked up show all four flashing indicators.
        else
        {
            flashingIndiDoor.opacity = 255;
            flashingIndiPicture.opacity = 255;
            flashingIndiKey.opacity = 255;
            flashingIndiReceipt.opacity = 255;
        }
    }
    // Call the method to remove the flashing indicators after 6 seconds.
    [self performSelector:@selector(timerRemoveFlashIndicators) withObject:nil afterDelay:6.0];
}

#pragma mark Picking Up Item Control

// This method is called two seconds after the removeItemAndAddToInventory method executes.
// This is the final step this class takes when adding an object to the inventory.
// This method removes the label that informs the user that an item has been added to the inventory,
// plays the sound that is used when a menu is shown or hidden, sets the variables that informs the
// pickUpItem method that one of these objects is being picked up: to false and sets the variables
// that informs the swipeShowFlashIndicators and timerRemoveFlashIndicators wheter to show the
// flashingIndicator for the receipt or key.

-(void)removeLabelsAndResetActions
{
    [self stopAllActions]; // Stop any actions this class is running.
    [stanley stopActions]; // Stop any actions running on Stanley.
    
    // Reset all actions for the pickUpItem method.
    removeItemActionOne = nil;
    removeItemActionTwo = nil;
    removeItemActionThree = nil;
    removeItemSequence = nil;
    
    // If it is the receipt that was picked up.
    if (isPickingUpReceipt)
    {
        [self stopAllSounds]; // Stop any sound that is playing.
        [self playSound:aLevelGameplayMenuShow]; // plays a sound for showing a menu.
        // Move the receipt label off the screen.
        receiptAddedLabel.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        // Set this to false, so the removeItemAndAddToIventory and pick up methods pickUpItem
        // know that the receipt is picked up already.
        isPickingUpReceipt = NO;
        // Set this to true so the swipeShowFlashIndicators and timerRemoveFlashIndicators methods know that
        // the receipt flashing indicator is no longer needed.
        hideReceiptFlashingIndicator = YES;
    }
    // If it is the key that was picked up.
    // The code below does the same thing as the code
    // that was explained above. No need to repeat the description.
    else if (isPickingUpKey)
    {
        [self stopAllSounds];
        [self playSound:aLevelGameplayMenuShow];
        keyAddedLabel.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        isPickingUpKey = NO;
        hideKeyFlashingIndicator = YES;
        
    }
    labelBack.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
}

// This method removes an object that has been picked up from this layer. It also plays a sound
// and displays a label to inform the user that the object has been added to the inventory.
// It finally calls a method that removes the label, flashing indicator and plays a sound for the removing
// of the label. This method is called from a callback in the pickUpItem method.

-(void)removeItemAndAddToIventory
{
    CCLOG(@"LEVEL GAMEPLAY removeItemAndAddToIventory CALLED");
    // Is it the receipt to be added to the inventory.
    if (isPickingUpReceipt)
    {
        // Remove the receipt icon object.
        [self removeChildByTag:kReceiptIconTagVale];
        // Remove the flashing indicator for the receipt object.
        [self removeChildByTag:kFlashIndicator3TagValue];
        
        // Is app running on iPad?
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [self stopAllSounds]; // Stop any sounds playing.
            [self playSound:aLevelGameplayMenuShow]; // Play the sound for when a menu is shown.
            // Position the label to inform the user that the receipt is added to the inventory.
            receiptAddedLabel.position = ccp((halfScreenWidth), (halfScreenHeight) + (glassCase.contentSize.height) - (100));
            labelBack.position = ccp((halfScreenWidth), (halfScreenHeight) + (glassCase.contentSize.height) - (100));
            // Play the sound for informing the user that an item has been added to the inventory.
            [self playSound:aLevelGameplayInvItemAdded];
            // Call the inventory menus add item method. Pass pre-defined string from the constants class
            // that informs the inventroy what item is to be added.
            [inventoryMenu AddItem:kRemoveObjectTypeReceipt];
        }
        // Or iPhone?
        // Code is the same as above it just uses different assets.
        else
        {
            [self stopAllSounds];
            [self playSound:aLevelGameplayMenuShow];
            receiptAddedLabel.position = ccp((halfScreenWidth), (halfScreenHeight) + (glassCase.contentSize.height/2));
            labelBack.position = ccp((halfScreenWidth), (halfScreenHeight) + (glassCase.contentSize.height/2));
            [self playSound:aLevelGameplayInvItemAdded];
            [inventoryMenu AddItem:kRemoveObjectTypeReceipt];
        }
    }
    // Is it the key to be added to the inventory.
    // Code is the same as was described above for the receipt object
    // No Need to repeat the description.
    else if (isPickingUpKey)
    {
        [self removeChildByTag:kKeyIconTagVale];
        [self removeChildByTag:kFlashIndicator4TagValue];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [self stopAllSounds];
            [self playSound:aLevelGameplayMenuShow];
            keyAddedLabel.position = ccp((halfScreenWidth), (halfScreenHeight) + (glassCase.contentSize.height) - (100));
            labelBack.position = ccp(halfScreenWidth, (halfScreenHeight) + (glassCase.contentSize.height) - (100));
            [self playSound:aLevelGameplayInvItemAdded];
            [inventoryMenu AddItem:kRemoveObjectTypeKey];
        }
        else
        {
            [self stopAllSounds];
            [self playSound:aLevelGameplayMenuShow];
            keyAddedLabel.position = ccp((halfScreenWidth), (halfScreenHeight) + (glassCase.contentSize.height/2));
            labelBack.position = ccp((halfScreenWidth), (halfScreenHeight) + (glassCase.contentSize.height/2));[self playSound:aLevelGameplayInvItemAdded];
            [self playSound:aLevelGameplayInvItemAdded];
            [inventoryMenu AddItem:kRemoveObjectTypeKey];
        }
    }
    [self performSelector:@selector(removeLabelsAndResetActions) withObject:nil afterDelay:2.0];
}

// This method is called from the itemToPickUpTouched once Stanley has gotten
// to the item to be picked up. It moves the receipt to the inventory icon and then
// calls the method that adds the item to the inventory.

-(void)pickUpItem
{
    // Is it the receipt to be picked up.
    CCLOG(@"LEVEL GAMEPLAY pickUpItem CALLED");
    if (isPickingUpReceipt == YES)
    {
        // Get the height of the receipt object by calling it's returnObjectHeight
        // method and storing the result here.
        receiptHeight = [receiptIcon returnObjectHeight];
        CCLOG(@"Receipt height %f", receiptHeight);
        
        // When an object is moving towards the inventory icon, it takes two actions that are run in a sequence.
        
        // The first action moves the receipt icon straight up on the y-axis in half a second.
        removeItemActionOne = [CCMoveTo actionWithDuration:0.5
                                                  position:ccp(receiptIcon.position.x, (receiptHeight) * (4))];
        // This second moves the receipt icon over to the middle of the inventory icon.
        removeItemActionTwo = [CCMoveTo actionWithDuration:0.5
                                                  position:ccp(inventoryIcon.position.x, inventoryIcon.position.y)];
        // Finally a callback is used call the method that adds the receipt to the inventory.
        removeItemActionThree = [CCCallFunc actionWithTarget:self
                                                    selector:@selector(removeItemAndAddToIventory)];
        // Put the above into a sequence.
        removeItemSequence = [CCSequence actions: removeItemActionOne, removeItemActionTwo, removeItemActionThree, nil];
        
        // Run the sequnce on the receipt object.
        [receiptIcon runAction:removeItemSequence];
        
    }
    // Code below is the same as the code above, so it is not explained
    // so as to avoid repitition.
    else if (isPickingUpKey == YES)
    {
        keyHeight = [keyIcon returnObjectHeight];
        CCLOG(@"Key height %f", keyHeight);
        
        removeItemActionOne = [CCMoveTo actionWithDuration:0.5
                                                  position:ccp(keyIcon.position.x, (keyHeight) * (4))];
        removeItemActionTwo = [CCMoveTo actionWithDuration:0.5
                                                  position:ccp(inventoryIcon.position.x, inventoryIcon.position.y)];
        removeItemActionThree = [CCCallFunc actionWithTarget:self
                                                    selector:@selector(removeItemAndAddToIventory)];
        
        removeItemSequence = [CCSequence actions: removeItemActionOne, removeItemActionTwo, removeItemActionThree, nil];
        [keyIcon runAction:removeItemSequence];
    }
}

// This method is called from the key or receipt objects ccTouchesBegan method.
// The method is passed a string from either object so it can identify what object
// was touched and needs to be picked up.

-(void)itemToPickUpTouched:(NSString *) itemToPickUp
{
    CCLOG(@"LEVEL GAMEPLAY receiptTouched CALLED");
    // If the string passed is equal to the string used in the constants file to
    // identify receipt object touched.
    if ([itemToPickUp isEqual: kRemoveObjectTypeReceipt])
    {
        // If the key object has just been picked and its label is still on screen, remove it.
        labelBack.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        keyAddedLabel.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        
        // If this is the first time the key was touched.
        if (receiptTouchedFirstTime == YES)
        {
            // Stop any sounds playing.
            [self stopAllSounds];
            // Play the sound to describe the receipt object as defined in Constants.
            [self playSound:aLevelGameplayReceiptDescript];
            // Set this to false so next time the receipt is touched, it can be picked up.
            receiptTouchedFirstTime = NO;
            // Remove the inventory from the screen if it is visible.
            if (inventoryMenuIsVisible)
            {
                [self showOrHideInventoryMenu];
            }
        }
        // If this is the second time the receipt is touched, it can be picked up.
        else
        {
            CCLOG(@"LEVEL GAMEPLAY receiptTouched CALLED");
            // Receipt is being picked up.
            isPickingUpReceipt = YES;
            // Remove the inevtory menu if it is visible.
            if (inventoryMenuIsVisible)
            {
                [self showOrHideInventoryMenu];
            }
            // If Stanley is to the right of the receipt.
            if ((stanley.position.x > receiptIcon.position.x))
            {
                CCLOG(@"RECEIPT WAS TOUCHED!");
                CCLOG(@"HE IS TO THE RIGHT OF THE RECEIPT");
                [self stopAllActions]; // Stop any actions running in this class playing.
                [stanley stopActions]; // Stop any actions currently running on Stanley.
                [self stopAllSounds]; // Stop all sounds.
                [self playSound:aLevelGameplayWalkRight]; // Play the walking sound.
                // Call Stanleys method that runs the walk left and pick up animation sequence. 
                [stanley walkLeftAndPickUp];
                // Move Stanley to the receipt location, whilst the animation is running.
                [stanley runAction:[CCMoveTo actionWithDuration:1.25 position:ccp(receiptIcon.position.x, stanley.position.y)]];
                // Call the pickUpItem method afetr 4 second, giving Stanley time to get to the
                // receipt before it starts to move.
                [self performSelector:@selector(pickUpItem) withObject:nil afterDelay:4.0];
            }
            // The code described above, is the same as the code below lines 840 to 849.
            // // If Stanley is to the left of the receipt.
            else if (stanley.position.x < receiptIcon.position.x)
            {
                isPickingUpReceipt = YES;
                CCLOG(@"RECEIPT WAS TOUCHED!");
                CCLOG(@"HE IS TO THE LEFT OF THE RECEIPT");
                [self stopAllSounds];
                [self playSound:aLevelGameplayWalkRight];
                [stanley walkRightAndPickUp];
                [stanley runAction:[CCMoveTo actionWithDuration:1.25 position:ccp(receiptIcon.position.x, stanley.position.y)]];
                [self performSelector:@selector(pickUpItem) withObject:nil afterDelay:4.0];
            }
        }
    }
    
    // This code below is called when the key object is touched.
    // It is the same as the code above for when the receipt is touched.
    // So it will not be described again to avoid repitition.
    else if ([itemToPickUp isEqual: kRemoveObjectTypeKey])
    {
        labelBack.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        receiptAddedLabel.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        if (keyTouchedFirstTime)
        {
            [self stopAllSounds];
            [self playSound:aLevelGameplayKeyDescript];
            keyTouchedFirstTime = NO;
            if (inventoryMenuIsVisible)
            {
                [self showOrHideInventoryMenu];
            }
        }
        else{
            CCLOG(@"LEVEL GAMEPLAY keyTouched CALLED");
            isPickingUpKey = YES;
            if (inventoryMenuIsVisible)
            {
                [self showOrHideInventoryMenu];
            }
            if ((stanley.position.x > keyIcon.position.x))
            {
                CCLOG(@"KEY WAS TOUCHED!");
                CCLOG(@"HE IS TO THE RIGHT OF THE KEY");
                [self stopAllActions];
                [stanley stopActions];
                
                [self stopAllSounds];
                [self playSound:aLevelGameplayWalkRight];
                [self stopAllSounds];
                [self playSound:aLevelGameplayWalkRight];
                [stanley walkLeftAndPickUp];
                [stanley runAction:[CCMoveTo actionWithDuration:1.25 position:ccp(keyIcon.position.x, stanley.position.y)]];
                [self performSelector:@selector(pickUpItem) withObject:nil afterDelay:3.25];
            }
            else if (stanley.position.x < keyIcon.position.x)
            {
                CCLOG(@"KEY WAS TOUCHED!");
                CCLOG(@"HE IS TO THE LEFT OF THE RECEIPT");
                [stanley walkRightAndPickUp];
                [stanley runAction:[CCMoveTo actionWithDuration:1.25 position:ccp(keyIcon.position.x, stanley.position.y)]];
                [self performSelector:@selector(pickUpItem) withObject:nil afterDelay:3.25];
            }
        }
    }
}

#pragma mark Touch Handlers

// This method is called at the instant the user first touches the screen.

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* myTouch = [touches anyObject];
    CGPoint location = [myTouch locationInView:[myTouch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    // Call the method that creates a CGRect around the key.
    [self makeInventoryKeyTouchable];
    
    // Check to see if the touched location is inside the CGRect
    // around the key.
    if (CGRectContainsPoint(inventoryBoundingBox, location))
    {
        // Set this Boolean so we know that the key is being touched.
        keyIsDraggable = YES;
        [self stopAllSounds];
        // Play the audio description of the inventory key. 
        [self playSound:aLevelGameplayKeyInvDescript];
    }
}

// This method is called when the user swipes a finger on the screen
// or when they drag the key object from the inventory menu.

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCLOG(@"LEVEL GAMEPLAY ccTouchesMoved CALLED");
    // Stop any actions currently runnning in this class.
    [self stopAllActions];
    // Stop any actions currently running on Stanley.
    [stanley stopActions];
    // Make the inventory object key touchable. 
    [self makeInventoryKeyTouchable];
    
    // Store the touch object at this location, regardless of what object is touched.
    UITouch *myTouch = [touches anyObject];
    // Create a point, x and y co-ord's from the above UITouch object's locaton in our view.
    CGPoint point = [myTouch locationInView:[myTouch view]];
    // Convert the above points, or multi touches to the co-ordinates for the layout of this game (landscape).
    point = [[CCDirector sharedDirector] convertToGL:point];
    
    // If the user touched the key and still touches it.
    // This code below will be executed.
    if (keyIsDraggable == YES)
    {
        CCLOG(@"Inventory Key is Being Dragged!");
        // Stop any actions currently running on Stanley.
        [stanley stopActions];
        // Stop any actions currently running in this class.
        [self stopAllActions];
        
        // Temp variables for storing the x and y
        // position of the current touched location.
        int width = point.x;
        int height = point.y;
        
        // Has the key been dragged of the screen to the right.
        if (screenSize.width - keyIsDraggableWidth < width)
        {
            // Take the width of the inventory key away from the x location
            // stored in width.
            width = screenSize.width - keyIsDraggableWidth;
        }
        // If the key has being dragged out of the screen at the top.
        if (screenSize.height - keyIsDraggableHeight < height)
        {
            // Take the height of the inventory key away from the y location
            // stored in height.
            height = screenSize.height - keyIsDraggableHeight;
        }
        if (keyIsDraggableHeight > height)
        {
            height = keyIsDraggableHeight;
        }
        if (keyIsDraggableWidth > width)
        {
            width = keyIsDraggableWidth;
        }
        [dragInventoryKey setPosition:ccp(width, height)];
    }
    else
    {
        // Call the method to show the flashing indicators.
        [self swipeShowFlashIndicators];
    }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCLOG(@"LEVEL GAMEPLAY ccTouchesBegan CALLED");
    // Stop all actions from Stanleys class.
    [stanley stopActions];
    // Make the ORourke object touchable.
    [self makeORourkeTouchable];
    // Make Inventory key touchable.
    [self makeInventoryKeyTouchable];
    
    // Store the touch object at this location, regardless of what object is touched.
    UITouch *myTouch = [touches anyObject];
    // Create a point, x and y co-ord's from the above UITouch object's locaton in our view.
    CGPoint location = [myTouch locationInView:[myTouch view]];
    // Convert the above points, or multi touches to the co-ordinates for the layout of this game (landscape).
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    // Getting the width of Stanley's sprite, from his class.
    characterWidth = [stanley returnCharacterWidth];
    
    // When the user is finished dragging the key.
    // This code will be executed.
    if (keyIsDraggable)
    {
        // Stop any actions running in the Stanley class.
        [stanley stopActions];
        // stop nay actions running in this class.
        [self stopAllActions];
        // Reset this to false so the next time the key is touched it can be dragged
        keyIsDraggable = NO;
        
        // Call the method that checks wheter they key can be dropped yet.
        [self checkDropZone];
    }
    else
    {   // If the touched location is inside the CGRect around ORourke.
        if (CGRectContainsPoint(oRourkeRect, location))
        {
            CCLOG(@"ORourke Touched");
            [self stopAllActions]; // Stop any actions this class is running.
            [stanley stopActions]; // Stop any actions the Stanley class is currently running.
            
            // If this is the first time a touch lands inside the ORourke CGRect.
            if (isFirstTimeORourkeTouch)
            {
                // Play an audio description of ORourke.
                [self playSound:aLevelGameplayORourkeDescript];
                isFirstTimeORourkeTouch = NO;
                // Call the method to move Stanley into position for talk.
                [self moveStanForTalk];
            }
            else
            // If this is the second time a touch lands inside the ORourke CGRect.
            {
                // Call the method to show the talk menu.
                [self showOrHideTalkMenu];
                // // Call the method to move Stanley into position for talk.
                [self moveStanForTalk];
            }
        }
        else
        {
            // Touch Area 1
            // If the user touches a location that is less than the far left (0) plus half of Stanleys width.
            if (location.x < 0 + (characterWidth/2))
            {
                CCLOG(@"Off Screen To Left");
                // Stop any actions currenty running in Stanleys class.
                [stanley stopActions];
                // Stop any actions running in this class.
                [self stopAllActions];
                // Stop any sounds playing.
                [self stopAllSounds];
                // Play the walking sound defined in constants.
                [self playSound:aLevelGameplayWalkRight];
                // Call Stanleys walk left method to animate him.
                [stanley walkLeft];
                // Modify the location touched by the user, take half of stanley's width away so he
                // will not go off screen.
                location.x = location.x + (characterWidth/2) - (42.0f);
                // Move stanley to the location now stored at location.x, on the x axis only, over 2.5 seconds.
                [stanley runAction:[CCMoveTo actionWithDuration:2.5 position:ccp(location.x, stanley.position.y)]];
            }
            // Touch Area 2
            // If the user touches a location that is just less than stanleys x position but not less
            // than the far left (0) plus half of Stanleys width.
            else if (location.x < stanley.position.x)
            {
                CCLOG(@"Normal Touch Left");
                // Stop any actions currenty running in Stanleys class.
                [stanley stopActions];
                // Stop nay actions running in this class.
                [self stopAllActions];
                // Stop any sounds playing.
                [self stopAllSounds];
                // Play the walking sound defined in constants.
                [self playSound:aLevelGameplayWalkRight];
                // Call Stanleys walk left method to animate him.
                [stanley walkLeft];
                // Move stanley to the touched location stored in location.x over 1.25 seconds.
                [stanley runAction:[CCMoveTo actionWithDuration:1.25 position:ccp(location.x, stanley.position.y)]];
            }
            // Touch Area 3
            // If the user touches a location that is greater than stanleys x position and greater than the screen width
            // (far right edge) minus half of stanleys witdh.
            else if (location.x > screenSize.width - (characterWidth/2))
            {
                CCLOG(@"Off Screen To Right");
                // Stop any actions currenty running in Stanleys class.
                [stanley stopActions];
                // Stop any actions running in this class.
                [self stopAllActions];
                // Stop any sounds playing.
                [self stopAllSounds];
                // Play the walking sound defined in constants.
                [self playSound:aLevelGameplayWalkRight];
                // Call Satnley's walk right method to animate him.
                [stanley walkRight];
                // Modify the location.x touched by the user, take half of stanley's width away so he
                // will not go off screen.
                location.x = screenSize.width - (characterWidth/2) + (42.0f);
                // Move stanley to the location now stored at location.x, on the x axis only over 2.5 seconds.
                [stanley runAction:[CCMoveTo actionWithDuration:2.5 position:ccp(location.x, stanley.position.y)]];
            }
            // Touch Area 4
            // If the user touches a location that is greater than stanleys x position and not greater than the screen width
            // far right minus half of stanleys witdh.
            else if (location.x > stanley.position.x)
            {
                CCLOG(@"Normal Touch Right");
                // Stop any actions currenty running in Stanleys class.
                [stanley stopActions];
                // Stop any actions running in this class.
                [self stopAllActions];
                // Stop any sounds playing.
                [self stopAllSounds];
                // Play the walking sound defined in constants.
                [self playSound:aLevelGameplayWalkRight];
                // Call stanleys walk right method to animate him.
                [stanley walkRight];
                // Move stanley to the touched location stored in location.x over 1.25 seconds.
                [stanley runAction:[CCMoveTo actionWithDuration:1.25 position:ccp(location.x, stanley.position.y)]];
            }
        }
    }
}

#pragma mark Sound Control

-(void)playSound:(NSString *)soundIdentifier
{
    [[CDAudioManager sharedManager] stopBackgroundMusic];
    CCLOG(@"LEVEL GAMEPLAY playSound CALLED");
    [[SimpleAudioEngine sharedEngine] setEffectsVolume:1.0];
    
    soundEffectID = [[SimpleAudioEngine sharedEngine] playEffect:soundIdentifier];
    
    [soundsIdArr addObject:[NSString stringWithFormat:@"%i", soundEffectID]];
    
}

-(void)stopAllSounds
{
    CCLOG(@"LEVEL GAMEPLAY stopAllSounds CALLED");
    [[SimpleAudioEngine sharedEngine] setEffectsVolume:0.0];
    
    for (int i = 0; i<[soundsIdArr count]; i++)
    {
        [[SimpleAudioEngine sharedEngine] stopEffect:[[soundsIdArr objectAtIndex:i] intValue]];
    }
    
    [soundsIdArr removeAllObjects];
}

#pragma mark Graphics Initialisation

-(void)initMenuAndIconsAndImages
{
    CCLOG(@"LEVEL GAMEPLAY initMenuAndIcons CALLED");
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {

        pauseIcon = [CCMenuItemImage itemWithNormalImage:@"pause_icon-ipadhd.png"
                                           selectedImage:@"pause_icon_selected-ipadhd.png"
                                           disabledImage:nil
                                                  target:self selector:@selector(showOrHidePauseMenu)];
        helpIcon = [CCMenuItemImage itemWithNormalImage:@"help_icon-ipadhd.png"
                                          selectedImage:@"help_icon_selected-ipadhd.png"
                                          disabledImage:nil
                                                 target:self
                                               selector:@selector(showOrHideHelpMenu)];
        inventoryIcon = [CCMenuItemImage itemWithNormalImage:@"inventory_icon-ipadhd.png"
                                               selectedImage:@"inventory_icon_selected-ipadhd.png"
                                               disabledImage:nil
                                                      target:self
                                                    selector:@selector(showOrHideInventoryMenu)];
        
        levelMenu = [CCMenu menuWithItems:pauseIcon, helpIcon, inventoryIcon, nil];
        
        receiptAddedLabel = [CCLabelTTF labelWithString:@"Receipt Added To Inventory" fontName:@"Marker Felt" fontSize:30];
        keyAddedLabel = [CCLabelTTF labelWithString:@"Key Added To Inventory" fontName:@"Marker Felt" fontSize:30];
        labelBack = [CCSprite spriteWithFile:@"inventory_menu_background-ipadhd.png"];
        glassCase = [CCSprite spriteWithFile:@"level_glass_case-ipadhd.png"];
        bust = [CCSprite spriteWithFile:@"level_bust-ipadhd.png"];
        flashingIndiDoor = [CCSprite spriteWithFile:@"flash_indicator_1-ipadhd.png"];
        flashingIndiPicture = [CCSprite spriteWithFile:@"flash_indicator_2-ipadhd.png"];
        flashingIndiReceipt = [CCSprite spriteWithFile:@"flash_indicator_3-ipadhd.png"];
        flashingIndiKey = [CCSprite spriteWithFile:@"flash_indicator_4-ipadhd.png"];
        dragInventoryKey = [CCSprite spriteWithFile:@"inventory_key_icon-ipadhd.png"];
        
        orourke.position = ccp((screenSize.width) + (halfScreenWidth), (screenSize.height) * (0.35f));
        receiptAddedLabel.position = ccp((screenSize.width) * (4), (screenSize.height) * (4));
        keyAddedLabel.position = ccp((screenSize.width) * (4), (screenSize.height) * (4));
        labelBack.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        dragInventoryKey.position = ccp((screenSize.width) * (3), (halfScreenHeight) * (3));
        
        
        flashingIndiDoor.position = ccp((screenSize.width) - (61), (screenSize.height) - (430));
        flashingIndiPicture.position = ccp((halfScreenWidth) + (20), (halfScreenHeight) + (150));
        flashingIndiReceipt.position = ccp((halfScreenWidth) - (160), (halfScreenHeight) - (305));
        flashingIndiKey.position = ccp((halfScreenWidth) + (160), (halfScreenHeight) - (305));
        
        pauseIcon.position = ccp((60), (screenSize.height) - (50));
        helpIcon.position = ccp((screenSize.width) - (60), (screenSize.height) - (50));
        inventoryIcon.position = ccp((screenSize.width-81), 80);
        levelMenu.position = ccp(0, 0);
        
        invisiPicture.position = ccp((halfScreenWidth) + (20), (halfScreenHeight) + (140));;
        invisiDoor.position = ccp((screenSize.width) - (57), (screenSize.height) - (420));
        
        glassCase.position = ccp((halfScreenWidth) - (350), (halfScreenHeight) - (198));
        bust.position = ccp((screenSize.width) - (200) , (halfScreenHeight) - (94));
        
        
        keyIcon.position = ccp((halfScreenWidth) + (160), (halfScreenHeight) - (300));
        receiptIcon.position = ccp((halfScreenWidth) - (160), (halfScreenHeight) - (300));
    }
    else
    {
        pauseIcon = [CCMenuItemImage itemWithNormalImage:@"pause_icon-widehd.png"
                                           selectedImage:@"pause_icon_selected-widehd.png"
                                           disabledImage:nil
                                                  target:self
                                                selector:@selector(showOrHidePauseMenu)];
        helpIcon = [CCMenuItemImage itemWithNormalImage:@"help_icon-widehd.png"
                                          selectedImage:@"help_icon_selected-widehd.png"
                                          disabledImage:nil target:self selector:@selector(showOrHideHelpMenu)];
        inventoryIcon = [CCMenuItemImage itemWithNormalImage:@"inventory_icon-widehd.png"
                                               selectedImage:@"inventory_icon_selected-widehd.png"
                                               disabledImage:nil target:self selector:@selector(showOrHideInventoryMenu)];
        
        levelMenu = [CCMenu menuWithItems:pauseIcon, helpIcon, inventoryIcon, nil];
        
        receiptAddedLabel = [CCLabelTTF labelWithString:@"Receipt Added To Inventory" fontName:@"Marker Felt" fontSize:17];
        keyAddedLabel = [CCLabelTTF labelWithString:@"Key Added To Inventory" fontName:@"Marker Felt" fontSize:17];
        labelBack = [CCSprite spriteWithFile:@"inventory_menu_background-widehd.png"];
        
        glassCase = [CCSprite spriteWithFile:@"level_glass_case-widehd.png"];
        bust = [CCSprite spriteWithFile:@"level_bust-widehd.png"];
        
        flashingIndiDoor = [CCSprite spriteWithFile:@"flash_indicator_1-widehd.png"];
        flashingIndiPicture = [CCSprite spriteWithFile:@"flash_indicator_2-widehd.png"];
        flashingIndiReceipt = [CCSprite spriteWithFile:@"flash_indicator_3-widehd.png"];
        flashingIndiKey = [CCSprite spriteWithFile:@"flash_indicator_4-widehd.png"];
        dragInventoryKey = [CCSprite spriteWithFile:@"inventory_key_icon-widehd.png"];
        
        receiptAddedLabel.position = ccp((screenSize.width) * (4), (screenSize.height) * (4));
        keyAddedLabel.position = ccp((screenSize.width) * (4), (screenSize.height) * (4));
        labelBack.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        dragInventoryKey.position = ccp((screenSize.width) * (3), (halfScreenHeight) * (3));
        
        orourke.position = ccp((screenSize.width) + (halfScreenWidth), (screenSize.height) * (0.32f));
        flashingIndiDoor.position = ccp((halfScreenWidth) + (255), (halfScreenHeight) - (20));
        flashingIndiPicture.position = ccp((halfScreenWidth) + (15), (halfScreenHeight) + (60));
        flashingIndiReceipt.position = ccp((halfScreenWidth) - (100), (halfScreenHeight) - (134));
        flashingIndiKey.position = ccp((halfScreenWidth) + (60), (halfScreenHeight) - (134));
        
        pauseIcon.position = ccp((30), (screenSize.height) - (25));
        helpIcon.position = ccp((screenSize.width) - (30), (screenSize.height - (25)));
        inventoryIcon.position = ccp((screenSize.width) - (40), (40));
        levelMenu.position = ccp(0, 0);
        
        invisiPicture.position = ccp((halfScreenWidth) + (10), (halfScreenHeight) + (70));
        invisiDoor.position = ccp((halfScreenWidth) + (255), (halfScreenHeight) - (15));
        glassCase.position = ccp((halfScreenWidth) - (202), (halfScreenHeight) - (76));
        bust.position = ccp((screenSize.width) - (110) , (halfScreenHeight) - (44));
        
        keyIcon.position = ccp((screenSize.width/2) + (60), (halfScreenHeight) - (130));
        receiptIcon.position = ccp((halfScreenWidth) - (100), (halfScreenHeight) - (130));
    }
    
    [self addChild:labelBack z:kLabelBackZValue];
    [self addChild:receiptAddedLabel z:kItemAddedLabelZValue tag:kItemReceiptAddedLabelTagValue];
    [self addChild:keyAddedLabel z:kItemAddedLabelZValue tag:kItemKeyAddedLabelTagValue];
    
    [self addChild:flashingIndiDoor z:kFlashIndicator1Zvalue tag:kFlashIndicator1TagValue];
    [self addChild:flashingIndiPicture z:kFlashIndicator2Zvalue tag:kFlashIndicator2TagValue];
    [self addChild:flashingIndiReceipt z:kFlashIndicator3Zvalue tag:kFlashIndicator3TagValue];
    [self addChild:flashingIndiKey z:kFlashIndicator4Zvalue tag:kFlashIndicator4TagValue];
    
    [self addChild:dragInventoryKey z:kDragabbleKeyZValue];
    
    flashingIndiDoor.opacity = 0;
    flashingIndiPicture.opacity = 0;
    flashingIndiReceipt.opacity = 0;
    flashingIndiKey.opacity = 0;
    
    [self addChild:glassCase z:kGlassCaseZValue];
    [self addChild:bust z:kBustZValueZValue];
    
    
    [self addChild:levelMenu z:kMenuZValue tag:kMenuTagValue];
    
}

#pragma mark Audio Initialisation

-(void)initAllAudio
{
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayWalkRight];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayButton];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aButtonOneSound];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aButtonTwoSound];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aButtonThreeSound];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayMenuShow];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayInvItemAdded];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayReceiptDescript];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayKeyDescript];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayPictureDescript];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayDoorDescript];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayReceiptInvDescript];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayKeyInvDescript];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayKeyNotReady];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayKeyFinalFits];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayKeyDroppedOk];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayORourkeDescript];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayORourkeEnter];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayORourkeExit];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayPicTalk];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayCsiTalk];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayThugsTalk];
    [[SimpleAudioEngine sharedEngine] preloadEffect:aLevelGameplayStanResume];
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:aLevelGameplayKeyNo];
}

#pragma mark General Initialisation
-(id)init
{
    CCLOG(@"LEVEL GAMEPLAY LAYER INITIATED");
    self = [super init];
    if (self != nil)
    {
        screenSize = [CCDirector sharedDirector].winSize;
        halfScreenWidth = screenSize.width/2;
        halfScreenHeight = screenSize.height/2;
        
        [self setTouchEnabled:YES];
            
        [[CDAudioManager sharedManager] preloadBackgroundMusic:aLevelGameplayOnLoad];
        rightChannel = [[CDAudioManager sharedManager] audioSourceForChannel:kASC_Right];
        rightChannel.delegate = self;
        
        soundsIdArr = [NSMutableArray arrayWithCapacity:0];
        [soundsIdArr retain];
        
        flashingIndicatorsIsVisible = NO;
        helpMenuIsVisible = NO;
        pauseMenuIsVisible = NO;
        inventoryMenuIsVisible = NO;
        talkMenuIsVisible = NO;
        isPickingUpReceipt = NO;
        isPickingUpKey = NO;
        hideReceiptFlashingIndicator = NO;
        hideKeyFlashingIndicator = NO;
        receiptTouchedFirstTime = YES;
        keyTouchedFirstTime = YES;
        oRourkeIsInTheScene = NO;
        isFirstTimeORourkeTouch = YES;
        keyIsDraggable = NO;
        oRourkeEnter = NO;
        
        removeItemActionOne = nil;
        removeItemActionTwo = nil;
        removeItemActionThree = nil;
        removeItemSequence = nil;
        
        stanley = [[Stanley alloc] init];
        orourke = [[ORourke alloc] init];
        helpMenu = [[HelpMenu alloc] init];
        pauseMenu = [[PauseMenu alloc] init];
        inventoryMenu = [[InventoryMenu alloc] initWithLayer:self];
        talkMenu = [[TalkMenu alloc] initWithLayer:self];
        receiptIcon = [[Receipt alloc] initWithLayer:self];
        keyIcon = [[Key alloc] initWithLayer:self];
        invisiPicture = [[TouchPicture alloc] initWithLayer:self];
        invisiDoor = [[TouchDoor alloc] initWithLayer:self];
        
        [stanley setPosition:ccp(halfScreenWidth, (screenSize.height) * (0.35f))];
    
        [self addChild:stanley z:kStanleySpriteZValue tag:kStanleySpriteTagValue];
        [self addChild:orourke z:kORourkeSpriteZValue tag:kORourkeSpriteTagValue];
        [self addChild:receiptIcon z:kInvisiItemsZvalue tag:kReceiptIconTagVale];
        [self addChild:keyIcon z:kInvisiItemsZvalue tag:kKeyIconTagVale];
        [self addChild:invisiPicture z:kInvisiItemsZvalue tag:kInvisPictureTagValue];
        [self addChild:invisiDoor z:kInvisiItemsZvalue tag:kInvisDoorTagValue];
        [self addChild:helpMenu z:kAllInGameMenuBackZValues];
        [self addChild:pauseMenu z:kAllInGameMenuBackZValues];
        [self addChild:inventoryMenu z:kAllInGameMenuBackZValues];
        [self addChild:talkMenu z:kAllInGameMenuBackZValues];
        [self initMenuAndIconsAndImages];
        
        // Instantiate an NSUserDefaults object.
        allTasksStatus = [NSUserDefaults standardUserDefaults];
        
        // Reseting task value pairs from the default system
        // for the duration of implmentation and debugging.
        [allTasksStatus setObject:@"" forKey:@"TaskOneDone"];
        [allTasksStatus setObject:@"" forKey:@"TaskTwoDone"];
        [allTasksStatus setObject:@"" forKey:@"TaskThreeDone"];
        [allTasksStatus setObject:@"" forKey:@"TaskFourDone"];
        
        // Write reseted tasks from above to the defaults system
        [allTasksStatus synchronize];
        
        [self initAllAudio];
        
        [[CDAudioManager sharedManager] playBackgroundMusic:aLevelGameplayOnLoad loop:NO];
    }
    return self;
}

@end
