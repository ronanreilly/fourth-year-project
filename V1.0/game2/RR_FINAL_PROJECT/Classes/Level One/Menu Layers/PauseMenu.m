//
//  PauseMenu.m
//  game2
//
//  Created by Ronan Sean on 14/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "PauseMenu.h"
#import "InGameChooseMenuScene.h"
#import "MainMenuScene.h"

@implementation PauseMenu

-(void)dealloc
{
    [super dealloc];
}

-(void)loadInGameChooseLevelScene
{
    CCLOG(@"PAUSE MENU LAYER loadInGameChooseLevelScene CALLED");
    [[SimpleAudioEngine sharedEngine] playEffect:aButtonOneSound];
    [[CCDirector sharedDirector] pushScene:[InGameChooseMenuScene node]];
}

-(void)quitGame
{
    CCLOG(@"PAUSE MENU LAYER quitGame CALLED");
    [[SimpleAudioEngine sharedEngine] playEffect:aButtonTwoSound];
    [[CCDirector sharedDirector] pushScene:[MainMenuScene node]];
}

-(void)backToGame
{
    CCLOG(@"PAUSE MENU LAYER backToGame CALLED");
    [[SimpleAudioEngine sharedEngine] playEffect:aButtonOneSound];
    [self addOrRemoveThisMenu];
}


// This method is called from the level one gameplay layer every time the user hits the pause menu.
// If the pause menu is currently not visible, the method positions them centered on the screen.
// If the menu is currently visible when this method is called then it will positions the menu and its
// background off of the sceen.

-(void)addOrRemoveThisMenu
{
    CCLOG(@"PAUSE MENU LAYER addOrRemoveThisMenu CALLED");
    // Is the pause menu visible. If not then execute the contents of this if statement.
    // When this class is instantiated, the menu is not visible and the boolean thisMenuIsVisible is set to NO.
    if (thisMenuIsVisible == NO)
    {
        // Execute this if the menu is not currentlt visible.
        // Check device iPad or iPhone.
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            // Position pause menu on the screen for iPad.
            menuBack.position = ccp((halfScreenWidth), (halfScreenHeight) + 100);
            inGamePauseMenu.position = ccp(0,0);
            playAnotherLevelIcon.position = ccp((halfScreenWidth), (halfScreenHeight) + (175));
            quitGameIcon.position = ccp((halfScreenWidth), (halfScreenHeight) + (82));
            backToGameIcon.position = ccp((halfScreenWidth), (halfScreenHeight) - (15));
        }
        else
        {
            // Position pause menu on the screen for iPhone.
            menuBack.position = ccp((halfScreenWidth), (halfScreenHeight) + (50));
            inGamePauseMenu.position = ccp(0,0);
            playAnotherLevelIcon.position = ccp((halfScreenWidth), (halfScreenHeight) + (80));
            quitGameIcon.position = ccp((halfScreenWidth), (halfScreenHeight) + (44));
            backToGameIcon.position = ccp((halfScreenWidth), (halfScreenHeight) + (4));
        }
        // Set the variable that keeps track of it the menu is visble or not to true.
        thisMenuIsVisible = YES;
    }
    // If the menu is currently visible when the method is called, then scatter the menu items off the screen.
    else
    {
        menuBack.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        inGamePauseMenu.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        playAnotherLevelIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        quitGameIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        backToGameIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        
        // Set the variable that keeps track of it the menu is visble or not to false.
        thisMenuIsVisible = NO;
    }
}

-(id)init
{
    self = [super init];
    CCLOG(@"PAUSE MENU LAYER INITIATED");
    if (self != nil)
    {
        screenSize = [CCDirector sharedDirector].winSize;
        halfScreenWidth = screenSize.width/2;
        halfScreenHeight = screenSize.height/2;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            menuBack = [CCSprite spriteWithFile:@"pause_menu_background-ipadhd.png"];
            
            playAnotherLevelIcon = [CCMenuItemImage itemWithNormalImage:@"pause_choose_level-ipadhd.png"
                                              selectedImage:@"pause_choose_level_selected-ipadhd.png"
                                              disabledImage:nil
                                                     target:self
                                                   selector:@selector(loadInGameChooseLevelScene)];
            
            quitGameIcon = [CCMenuItemImage itemWithNormalImage:@"pause_quit_game-ipadhd.png"
                                                      selectedImage:@"pause_quit_game_selected-ipadhd.png"
                                                      disabledImage:nil
                                                             target:self
                                                           selector:@selector(quitGame)];

            backToGameIcon = [CCMenuItemImage itemWithNormalImage:@"pause_back-ipadhd.png"
                                              selectedImage:@"pause_back_selected-ipadhd.png"
                                              disabledImage:nil
                                                     target:self
                                                   selector:@selector(backToGame)];
        }
        else
        {
            menuBack = [CCSprite spriteWithFile:@"pause_menu_background-widehd.png"];
            
            playAnotherLevelIcon = [CCMenuItemImage itemWithNormalImage:@"pause_choose_level-widehd.png"
                                                          selectedImage:@"pause_choose_level_selected-widehd.png"
                                                          disabledImage:nil
                                                                 target:self
                                                               selector:@selector(loadInGameChooseLevelScene)];
            
            quitGameIcon = [CCMenuItemImage itemWithNormalImage:@"pause_quit_game-widehd.png"
                                                  selectedImage:@"pause_quit_game_selected-widehd.png"
                                                  disabledImage:nil
                                                         target:self
                                                       selector:@selector(quitGame)];
            
            backToGameIcon = [CCMenuItemImage itemWithNormalImage:@"pause_back-widehd.png"
                                                    selectedImage:@"pause_back_selected-widehd.png"
                                                    disabledImage:nil
                                                           target:self
                                                         selector:@selector(backToGame)];
        }
        
        thisMenuIsVisible = NO;
        
        inGamePauseMenu = [CCMenu menuWithItems:playAnotherLevelIcon, quitGameIcon, backToGameIcon,  nil];
        
        menuBack.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        inGamePauseMenu.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        playAnotherLevelIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        quitGameIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        backToGameIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:aButtonOneSound];
        [[SimpleAudioEngine sharedEngine] preloadEffect:aButtonTwoSound];
        [[SimpleAudioEngine sharedEngine] preloadEffect:aButtonThreeSound];
        
        rightChannel=[[CDAudioManager sharedManager] audioSourceForChannel:kASC_Right];
        rightChannel.delegate=self;
        
        [self addChild:menuBack z:0];
        [self addChild:inGamePauseMenu z:5];

    }
    
    return self;
}

@end
