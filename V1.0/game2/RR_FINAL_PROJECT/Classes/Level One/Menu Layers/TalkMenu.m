//
//  PauseMenu.m
//  game2
//
//  Created by Ronan Sean on 14/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
// Class descript here

#import "TalkMenu.h"
#import "LevelGameplay.h"

@implementation TalkMenu

@synthesize gameplayLayer;

-(void)dealloc
{
    [super dealloc];
}

// This method is called each time a menu item is used. It perfroms
// a check to see if all of the menu items have been used. When all
// the items have been used this method plays the final bit of audio
// for the conversation, sets the gamestate and calls the method that
// will see the ORourke character leave the level.

#pragma mark All Talk Items Have Been Used
-(void)talkIsFinished
{
    CCLOG(@"TALK MENU LAYER isAllTalkFinished CALLED");
    // Are all the talk menu items used.
    if (isCsiTalkDone && isPictureTalkDone && isThugsTalkDone)
    {
        CCLOG(@"ALL TALK IS DONE");
        // Stop any sound playing.
        [gameplayLayer stopAllSounds];
        // Play the sound for ORourke leaving as pre-defined in the Constants file.
        [gameplayLayer playSound:aLevelGameplayORourkeExit];
        // set the game state, task three is now complete.
        [gameplayLayer setGameState:KTaskThree];
        // Wait the length of time that the above audio clip before calling the enterOrExitOrourke method.
        [gameplayLayer performSelector:@selector(enterOrExitOrourke) withObject:nil afterDelay:18.0];
    }
    else
    {
        CCLOG(@"STILL MORE TALK TO COME");
    }
}

// This method is called when a menu item is used. It perfoms a whole series of checks.
// The checks detect what menu item has been used and remove it from the screen.
// If one item has been used, it is removed and the background image is changed to one that is the size of two images.
// When two items have been used, one is removed and the background image is changed to one that is the size of one image.
//
// The whole point of this method is to remove an item from the menu when it is used, resort the positions for the
// remaining items and display a background image that be-fits the number of items left in the menu.
// When this method is called and there is only one item left it removes the item and the whole menu.

#pragma mark Sort and Re-Organise The Menu 
-(void)sortMenuItemsOrder
{
    // CSI YES, PICTURE NO, THUGS NO
    if (csiTalkDoneNowMove && !thugsTalkDoneAndMove && !pictureTalkDoneAndMove)
    {
        CCLOG(@"1");
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            csiTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBack.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackTwoItems.position = ccp((halfScreenWidth), (halfScreenHeight) + (220));
            pictureTalkIcon.position = ccp((halfScreenWidth) - (65), (halfScreenHeight) + (220));
            thugsTalkIcon.position = ccp((halfScreenWidth) + (80), (halfScreenHeight) + (220));
        }
        else
        {
            csiTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            pictureTalkIcon.position = ccp((halfScreenWidth) - (40), (halfScreenHeight) + (100));
            thugsTalkIcon.position = ccp((halfScreenWidth) + (45), (halfScreenHeight) + (100));
            menuBack.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackTwoItems.position =  ccp((halfScreenWidth), (halfScreenHeight) + (100));
        }
    }
    // PICTURE YES, THUGS NO, CSI NO
    else if (pictureTalkDoneAndMove && !thugsTalkDoneAndMove && !csiTalkDoneNowMove)
    {
        CCLOG(@"2");
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            pictureTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBack.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackTwoItems.position = ccp((halfScreenWidth), (screenSize.height/2) + 220);
            csiTalkIcon.position = ccp((halfScreenWidth) - (75), (screenSize.height/2) + (220));
            thugsTalkIcon.position = ccp((halfScreenWidth) + (60), (screenSize.height/2) + (220));
        }
        else
        {
            pictureTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            csiTalkIcon.position = ccp((halfScreenWidth) - (45), (halfScreenHeight) + (100));
            thugsTalkIcon.position = ccp((halfScreenWidth) + (40), (halfScreenHeight) + (100));
            menuBack.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackTwoItems.position = ccp((halfScreenWidth), (halfScreenHeight) + (100));
        }
    }
    //THUGS YES, CSI NO, PICTURE NO
    else if(thugsTalkDoneAndMove && !csiTalkDoneNowMove && !pictureTalkDoneAndMove)
    {
        CCLOG(@"3");
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            CCLOG(@"3");
            thugsTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBack.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackTwoItems.position = ccp((halfScreenWidth), (halfScreenHeight) + (220));
            csiTalkIcon.position = ccp((halfScreenWidth) - (75), (halfScreenHeight) + (220));
            pictureTalkIcon.position = ccp((halfScreenWidth) + 60, (halfScreenHeight) + (220));
        }
        else
        {
            thugsTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            csiTalkIcon.position = ccp((halfScreenWidth) - 50, (halfScreenHeight) + (100));
            pictureTalkIcon.position = ccp((halfScreenWidth) + 35, (halfScreenHeight) + (100));
            menuBack.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackTwoItems.position = ccp((halfScreenWidth), (halfScreenHeight) + (100));
        }
    }
    // CSI YES, PICTURE YES, THUGS NO
    else if (csiTalkDoneNowMove && pictureTalkDoneAndMove && !thugsTalkDoneAndMove)
    {
        CCLOG(@"4");
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            pictureTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            csiTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            thugsTalkIcon.position = ccp((halfScreenWidth), (halfScreenHeight) + (220));
            menuBackTwoItems.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackOneItems.position = ccp((halfScreenWidth), (halfScreenHeight) + (220));
        }
        else
        {
            csiTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            pictureTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            thugsTalkIcon.position = ccp((halfScreenWidth), (halfScreenHeight) + (100));
            menuBackTwoItems.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackOneItems.position = ccp((halfScreenWidth), (halfScreenHeight) + (100));
        }  
    CCLOG(@"THUGS A");
    }
    //CSI YES, PICTURE NO, THUG YES
    else if (csiTalkDoneNowMove && thugsTalkDoneAndMove && !pictureTalkDoneAndMove)
    {
        CCLOG(@"5");
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            csiTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            thugsTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            pictureTalkIcon.position = ccp((halfScreenWidth), (halfScreenHeight) + (220));
            menuBackTwoItems.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackOneItems.position = ccp((halfScreenWidth), (halfScreenHeight) + (220));
        }
        else
        {
            csiTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            thugsTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            pictureTalkIcon.position = ccp((halfScreenWidth), (halfScreenHeight) + (100));
            menuBackTwoItems.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackOneItems.position = ccp((halfScreenWidth), (halfScreenHeight) + (100));
        }
    CCLOG(@"PICTURE A");
    }
   // PICTURE YES, CSI YES, THUGS NO
    else if (pictureTalkDoneAndMove && csiTalkDoneNowMove && !thugsTalkDoneAndMove)
    {
        CCLOG(@"6");
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            pictureTalkIcon.position =  ccp((screenSize.width) * (3), (screenSize.height) * (3));
            csiTalkIcon.position =  ccp((screenSize.width) * (3), (screenSize.height) * (3));
            thugsTalkIcon.position = ccp((halfScreenWidth), (halfScreenHeight) + (220));
            menuBack.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackTwoItems.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackOneItems.position = ccp((halfScreenWidth), (halfScreenHeight) + (220));
        }
        else
        {
            pictureTalkIcon.position =  ccp((screenSize.width) * (3), (screenSize.height) * (3));
            csiTalkIcon.position =  ccp((screenSize.width) * (3), (screenSize.height) * (3));
            thugsTalkIcon.position = ccp((halfScreenWidth), (halfScreenHeight) + (100));
            menuBack.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackTwoItems.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackOneItems.position = ccp((halfScreenWidth), (halfScreenHeight) + (100)); 
        }
    CCLOG(@"THUGS B");
    }
    // PICTURE YES, CSI NO, THUGS YES
    else if (pictureTalkDoneAndMove && !csiTalkDoneNowMove && thugsTalkDoneAndMove)
    {
        CCLOG(@"7");
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            pictureTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            thugsTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackTwoItems.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackOneItems.position = ccp((halfScreenWidth), (halfScreenHeight) + (220));
            csiTalkIcon.position = ccp((halfScreenWidth), (halfScreenHeight) + (220));
        }
        else
        {
            pictureTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            thugsTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackTwoItems.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackOneItems.position = ccp((halfScreenWidth), (halfScreenHeight) + (100)); 
            csiTalkIcon.position = ccp((halfScreenWidth), (halfScreenHeight) + (100));
        }
        CCLOG(@"CSI A");
    }
    // THUGS YES, CSI YES, PICTURE NO
    else if (!pictureTalkDoneAndMove && csiTalkDoneNowMove && thugsTalkDoneAndMove)
    {
        CCLOG(@"8");
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            csiTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            thugsTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackTwoItems.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackOneItems.position = ccp((halfScreenWidth), (halfScreenHeight) + (220));
            pictureTalkIcon.position = ccp((halfScreenWidth) - (90), (halfScreenHeight) + (220));
        }
        else
        {
            csiTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            thugsTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackTwoItems.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackOneItems.position = ccp((halfScreenWidth), (halfScreenHeight) + (100));
            pictureTalkIcon.position = ccp((halfScreenWidth) - (90), (halfScreenHeight) + (100));
        }
        CCLOG(@"PICTURE B");
    }
    // THUGS YES, CSI NO, PICTURE YES
    else if (!csiTalkDoneNowMove && pictureTalkDoneAndMove && thugsTalkDoneAndMove)
    {
        CCLOG(@"9");
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            pictureTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            thugsTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackTwoItems.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackOneItems.position = ccp((halfScreenWidth), (halfScreenHeight) + (220));
            csiTalkIcon.position = ccp((halfScreenWidth) - (90), (halfScreenHeight) + (220));
        }
        else
        {
            pictureTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            thugsTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackTwoItems.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
            menuBackOneItems.position = ccp((halfScreenWidth), (halfScreenHeight) + (100));
            csiTalkIcon.position = ccp((halfScreenWidth) - (90), (halfScreenHeight) + (100));
        }
        CCLOG(@"CSI B");
    }
    else if(csiTalkDoneNowMove && pictureTalkDoneAndMove && thugsTalkDoneAndMove)
    {
        csiTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        pictureTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        thugsTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        menuBack.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        menuBackOneItems.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        menuBackTwoItems.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
    }
}

// This method is invoked when the user selects the thugs icon from the menu.
// It plays the audio for the thugs icon, sets the Booleans used to distinguish wheter this
// menu item has been used. It calls the sortMenuItemsOrder method, so the item is removed
// from the menu. It also calls the talkIsFinished method that checks to see wheter this is the last
// item to be used on the talk menu.

#pragma mark Play Audio for Thugs Icon
-(void)thugsTalk
{
    CCLOG(@"TALK MENU LAYER thugsTalk CALLED");
    // Set this so the addOrRemoveThisMenu method knows that an item has been used.
    menuItemHasBeenUsed = YES;
    
    // Stop any sound currently playing.
    [gameplayLayer stopAllSounds];
    // Play the audio for this menu item as is pre-defined in the constants class.
    [gameplayLayer playSound:aLevelGameplayThugsTalk];
    
    // Set these variables so that the sortMenuItemsOrder and talkIsFinished methods know that
    // this item has been used.
    isThugsTalkDone = YES;
    thugsTalkDoneAndMove = YES;
    
    // Disable this menu item.
    [thugsTalkIcon setIsEnabled:NO];
    
    // Calling this method will remove this item from the menu
    // and resort the menu items whilst also resizing the background image of the menu.
    [self sortMenuItemsOrder];
    
    if (isPictureTalkDone && isCsiTalkDone) {
        [self performSelector:@selector(talkIsFinished) withObject:nil afterDelay:18.0];
    }
    else
    {
        // Calling this method performs a check to see if this is the last item to be used.
        [self talkIsFinished];
    }
}

// This method performs the same functionality as the thugsTalk method
// refer to it for a detailed description of how it works.

#pragma mark Play Audio for CSI Icon
-(void)csiTalk
{
    CCLOG(@"TALK MENU LAYER csiTalk CALLED");
    
    menuItemHasBeenUsed = YES;
    
    [gameplayLayer stopAllSounds];
    [gameplayLayer playSound:aLevelGameplayCsiTalk];
    
    isCsiTalkDone = YES;
    csiTalkDoneNowMove = YES;
    
    [csiTalkIcon setIsEnabled:NO];
    
    [self sortMenuItemsOrder];
    
    if (isPictureTalkDone && isThugsTalkDone)
    {
        [self performSelector:@selector(talkIsFinished) withObject:nil afterDelay:7.0];
    }
    else
    {
        [self talkIsFinished];
    }
}

// This method performs the same functionality as the thugsTalk method
// refer to it for a detailed description of how it works.

#pragma mark Play Audio for Picture Icon
-(void)pictureTalk
{
    CCLOG(@"TALK MENU LAYER pictureTalk CALLED");
    
    menuItemHasBeenUsed = YES;
    
    [gameplayLayer stopAllSounds];
    [gameplayLayer playSound:aLevelGameplayPicTalk];
    
    isPictureTalkDone = YES;
    pictureTalkDoneAndMove = YES;
    
    [pictureTalkIcon setIsEnabled:NO];
    [self sortMenuItemsOrder];
    
    if (isCsiTalkDone && thugsTalkIcon)
    {
        [self performSelector:@selector(talkIsFinished) withObject:nil afterDelay:29.0];
    }
    else
    {
        [self talkIsFinished];
    }
}

// This method is called from the level one gameplay layer whne the user taps a location in a CGRect
// that is created around the ORourke object.

#pragma mark Show or Hide This Menu
-(void)addOrRemoveThisMenu
{
    // MENU NOT ON SCREEN
    if (thisMenuIsVisible == NO)
    {
        // MENU ITEM USED
        if (menuItemHasBeenUsed)
        {
            [self sortMenuItemsOrder];
        }
        // NO MENU ITEM USED
        else
        {
            CCLOG(@"NONONONONONONONONONONONONONONONONONONONO");
            // Position the menu back and items on the screen for iPad.
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                menuBack.position = ccp((halfScreenWidth), (halfScreenHeight) + 220);
                talkMenu.position = ccp(0,0);
                csiTalkIcon.position = ccp((halfScreenWidth) - (160), (halfScreenHeight) + (220));
                pictureTalkIcon.position = ccp((halfScreenWidth) - (10), (halfScreenHeight) + (220));
                thugsTalkIcon.position = ccp((halfScreenWidth) + (140), (halfScreenHeight) + (220));
            }
            else
            {
                // Position the menu back and items on the screen for ihone.
                menuBack.position = ccp((halfScreenWidth), (halfScreenHeight) + (100));
                talkMenu.position = ccp(0,0);
                csiTalkIcon.position = ccp((halfScreenWidth) - (90), (halfScreenHeight) + (100));
                pictureTalkIcon.position = ccp((halfScreenWidth) - (10), (halfScreenHeight) + (100));
                thugsTalkIcon.position = ccp((halfScreenWidth) + (80), (halfScreenHeight) + (100));
            }
       
        }
        // Set this to yes so the next time this method is called it will
        // know that it has to remove the menu, not show it.
        thisMenuIsVisible = YES;
    }
    // MENU ON SCREEN
    else
    {
        menuBack.position = ccp(screenSize.width * 3, screenSize.height* 3);
        menuBackOneItems.position = ccp(screenSize.width * 3, screenSize.height* 3);
        menuBackTwoItems.position = ccp(screenSize.width * 3, screenSize.height* 3);
        csiTalkIcon.position = ccp(screenSize.width * 3, screenSize.height* 3);
        pictureTalkIcon.position = ccp(screenSize.width * 3, screenSize.height* 3);
        thugsTalkIcon.position = ccp(screenSize.width * 3, screenSize.height* 3);
        
        thisMenuIsVisible = NO;
    }   
}

// This method handles the creation and positioning of all the graphical assets for the talk menu and the
// initialisation of variables ect.

#pragma mark General Initialisation
-(id)initWithLayer:(LevelGameplay *)layer
{
    self = [super init];
    CCLOG(@"TALK MENU LAYER INITIATED");
    if (self != nil)
    {
        // Add this object to the gameplay layer as a child.
        self.gameplayLayer=layer;
        
        // Get the screen size of the device this applcation is running on
        // from the CCDirector.
        screenSize = [CCDirector sharedDirector].winSize;
        halfScreenWidth = screenSize.width/2;
        halfScreenHeight = screenSize.height/2;
        
        // Is application running on iPad?
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            // Create the sprites for the menu's background whne it has all three items, just two items
            // or one item.
            menuBack = [CCSprite spriteWithFile:@"talk_menu_background-ipadhd.png"];
            menuBackOneItems = [CCSprite spriteWithFile:@"talk_menu_background_one_items-ipadhd.png"];
            menuBackTwoItems = [CCSprite spriteWithFile:@"talk_menu_background_two_items-ipadhd.png"];
            
            // Create the three menu items for the talk menu, give them an image for their normal state
            // selected state and disabled state. Point them to the methods that they should invoke. 
            csiTalkIcon = [CCMenuItemImage itemWithNormalImage:@"talk_csi_icon-ipadhd.png"
                                                 selectedImage:@"talk_csi_icon_selected-ipadhd.png"
                                                 disabledImage:@"talk_csi_icon_disabled-ipadhd.png"
                                                        target:self
                                                      selector:@selector(csiTalk)];
            
            pictureTalkIcon = [CCMenuItemImage itemWithNormalImage:@"talk_picture_icon-ipadhd.png"
                                                     selectedImage:@"talk_picture_icon_selected-ipadhd.png"
                                                     disabledImage:@"talk_picture_icon_disabled-ipadhd.png"
                                                            target:self
                                                          selector:@selector(pictureTalk)];
            
            thugsTalkIcon = [CCMenuItemImage itemWithNormalImage:@"talk_bad_guys_icon-ipadhd.png"
                                                   selectedImage:@"talk_bad_guys_icon_selected-ipadhd.png"
                                                   disabledImage:@"talk_bad_guys_icon_disabled-ipadhd.png"
                                                          target:self
                                                        selector:@selector(thugsTalk)];
        }
        // Is application running on iPhone?
        // Code below is the same as the code above so no need to repeat the description here.
        else
        {
            menuBack = [CCSprite spriteWithFile:@"talk_menu_background-widehd.png"];
            menuBackOneItems = [CCSprite spriteWithFile:@"talk_menu_background_one_items-widehd.png"];
            menuBackTwoItems = [CCSprite spriteWithFile:@"talk_menu_background_two_items-widehd.png"];
            
            csiTalkIcon = [CCMenuItemImage itemWithNormalImage:@"talk_csi_icon_selected-widehd.png"
                                                          selectedImage:@"talk_csi_icon-widehd.png"
                                                          disabledImage:@"talk_csi_icon_disabled-widehd.png"
                                                                 target:self
                                                               selector:@selector(csiTalk)];
            
            pictureTalkIcon = [CCMenuItemImage itemWithNormalImage:@"talk_picture_icon-widehd.png"
                                                  selectedImage:@"talk_picture_icon_selected-widehd.png"
                                                  disabledImage:@"talk_picture_icon_disabled-widehd.png"
                                                         target:self
                                                       selector:@selector(pictureTalk)];
            
            thugsTalkIcon = [CCMenuItemImage itemWithNormalImage:@"talk_bad_guys_icon.png"
                                                    selectedImage:@"talk_bad_guys_icon_selected-widehd.png"
                                                    disabledImage:@"talk_bad_guys_icon_disabled-widehd.png"
                                                           target:self
                                                         selector:@selector(thugsTalk)];
        }
        
        // Initialise the variable for keeping track of wheter this menu is visible. 
        thisMenuIsVisible = NO;
        
        // Initialise the variables for keeping track of wheter menu items have been used.
        isCsiTalkDone = NO;
        isPictureTalkDone = NO;
        isThugsTalkDone = NO;
        allTalkDone = NO;
        
        // Initialise the variables used for keeping track of wheter menu items have been used and need to be removed.
        csiTalkDoneNowMove = NO;
        pictureTalkDoneAndMove = NO;
        thugsTalkDoneAndMove = NO;
        
        menuItemHasBeenUsed = NO;
        
        // Add the three menu items created above to the talk menu.
        talkMenu = [CCMenu menuWithItems:csiTalkIcon, pictureTalkIcon, thugsTalkIcon,  nil];
        
        // Position the menu backgrounds off screen because the menu is not visble when instantiated in the level one
        // gameplay layer.
        menuBack.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        menuBackOneItems.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        menuBackTwoItems.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        
        // Position the menu and their items off screen because they are not visble when instantiated in the level one
        // gameplay layer.
        talkMenu.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        csiTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        pictureTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        thugsTalkIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        
        // Add the menu back sprites to this layer as children.
        // Give them a lower z value than the menu so they appear underneath it.
        [self addChild:menuBack z:0];
        [self addChild:menuBackOneItems z:0];
        [self addChild:menuBackTwoItems z:0];
        // Add the menu to this layer as children.
        [self addChild:talkMenu z:5];
        
    }
    return self;
}

@end
