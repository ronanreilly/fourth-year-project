//
//  MainMenuGameplay.m
//  game2
//
//  Created by Ronan Sean Reilly on 12/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
// Class Overview Below:
//
// This class is a CCLayer. It contains the main menu background, the menu and its buttons
// and handles the touch for this menu. It extends the CocosDenhison CDLongAudioSourceDelegate fro playing
// background muusic and uses the CocosDenhison SimpleAudioEngine for preloading and playing audio effects for the
// menu buttons.

#import "MainMenuGameplay.h"
#import "ChooseLevelScene.h"
#import "CutScene.h"


@implementation MainMenuGameplay

#pragma mark Play Background Music Function

// This method plays the background music pre-loaded in the init method.

-(void)playBackgroundMusic
{
    // Play the background music and loop it.
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:aMainMenBackground loop:YES];
}



// This method is called when the user hits the start game button.
// It first stops the background music from playing, plays the sound effect for the button
// and then pushes the cut scene scene on to the top of the stack.

#pragma mark Start Game Function
-(void)startGame
{
    CCLOG(@"MAIN MENU GAMEPLAY startGame CALLED");
    // Play the effect for the button.
    [[SimpleAudioEngine sharedEngine] playEffect:aButtonOneSound];
    // Stop background music.
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    // Push the cut scene to the top of the stack.
    [[CCDirector sharedDirector] pushScene:[CutScene node]];
}

// This method is called when the user hits the choose level button.
// It first stops the background music from playing, plays the sound effect for the button
// and then pushes the cut scene scene on to the top of the stack.

#pragma mark Choose Level Function
-(void)loadChooseLevelScene
{
    CCLOG(@"MAIN MENU GAMEPLAY loadChooseLevelScene CALLED");
    // Play the effect for the button.
    [[SimpleAudioEngine sharedEngine] playEffect:aButtonTwoSound];
    // Stop background music.
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    // Push the choose level to the top of the stack.
    [[CCDirector sharedDirector] pushScene:[ChooseLevelScene node]];
}

#pragma mark Layer Intialisation 
-(id)init
{
    CCLOG(@"MAIN MENU GAMEPLAY LAYER INITIATED");
    // Initialising the super object, CCLayer.
    self = [super init];
    // Checking that intialistaion of the super object failed.
    if (self != nil)
    {
        // Getting the screen size from the director.
        screenSize = [CCDirector sharedDirector].winSize;
        // Storing half the screen width and height in vars.
        halfScreenWidth = screenSize.width/2;
        halfScreenHeight = screenSize.height/2;
        
        // Checking what device is running the application.
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            // Creating the background image for this layer.
            menuBackground = [CCSprite spriteWithFile:@"main_menu_back-ipadhd.png"];
            
            // Creating button/menu items for this menu.
            // An image is specified for each menu item's: normal state, selected state,
            // is pointed to a target class (this class) and given a a selector for a method
            // to invoke.
            
            startNewGameIcon = [CCMenuItemImage itemWithNormalImage:@"main_start_game-ipadhd.png"
                                                      selectedImage:@"main_start_game_selected-ipadhd.png"
                                                      disabledImage:nil
                                                             target:self
                                                           selector:@selector(startGame)];
            
            chooseLevelIcon = [CCMenuItemImage itemWithNormalImage:@"main_choose_level-ipadhd.png"
                                                     selectedImage:@"main_choose_level_selected-ipadhd.png"
                                                     disabledImage:nil
                                                            target:self
                                                          selector:@selector(loadChooseLevelScene)];
            
            // Creating the menu and adding the menu items above to it.
            mainMenu = [CCMenu menuWithItems:startNewGameIcon, chooseLevelIcon, nil];
            
            // Positioning the background image. Centered.
            menuBackground.position = ccp((halfScreenWidth), (halfScreenHeight) - (80));
            // Positioning the menu. Bottom left corner.
            mainMenu.position = ccp(0, 0);
            // Positioning both menu items.
            startNewGameIcon.position = ccp((halfScreenWidth), (halfScreenHeight) - (40));
            chooseLevelIcon.position = ccp((halfScreenWidth), (halfScreenHeight) - (140));
            
        }
        else
        {
            // TO AVOID REPITITION, SEE COMMENTS ABOVE.
            
            menuBackground = [CCSprite spriteWithFile:@"main_menu_back-widehd.png"];
            startNewGameIcon = [CCMenuItemImage itemWithNormalImage:@"main_start_game-widehd.png"
                                                      selectedImage:@"main_start_game_selected-widehd.png"
                                                      disabledImage:nil
                                                             target:self
                                                           selector:@selector(startGame)];
            chooseLevelIcon = [CCMenuItemImage itemWithNormalImage:@"main_choose_level-widehd.png"
                                                     selectedImage:@"main_choose_level_selected-widehd.png"
                                                     disabledImage:nil
                                                            target:self
                                                          selector:@selector(loadChooseLevelScene)];
            
            mainMenu = [CCMenu menuWithItems:startNewGameIcon, chooseLevelIcon, nil];
            
            menuBackground.position = ccp((halfScreenWidth), (halfScreenHeight) - (30));
            mainMenu.position = ccp(0,0);
            startNewGameIcon.position = ccp((halfScreenWidth), (halfScreenHeight) - (15));
            chooseLevelIcon.position = ccp((halfScreenWidth), (halfScreenHeight) - (60));
        }
        
        // Preloading sound effects for the main menu.
        
        // Using the SimpleAudioEngine to pre-load the background music.
        
        // The string for each sound is defined in the constants file.
        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:aMainMenBackground];
        
        // Passed a string defined in Constants.h.
        [[SimpleAudioEngine sharedEngine] preloadEffect:aButtonOneSound];
        [[SimpleAudioEngine sharedEngine] preloadEffect:aButtonTwoSound];

        
        // Calling the method that will play the background music.
        [self playBackgroundMusic];
    
        // Adding the menu  background to the layer, z value is defined in the constants file.
        [self addChild:menuBackground z:kMainMenuBackgroundZValue];
        // Adding the menu  background to the layer, z value is defined in the constants file.
        [self addChild:mainMenu z:kMainMenuZValue];
        
    }
    return self;
}

@end
