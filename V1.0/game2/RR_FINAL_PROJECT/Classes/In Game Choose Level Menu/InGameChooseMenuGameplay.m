//
//  InGameChooseMenuGameplay.m
//  game2
//
//  Created by Ronan Sean Reilly on 13/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
// Class Description Below:
//
// This class is a CCLayer. It contains the in game choose menu background, the menu and its buttons
// and handles the touch for this menu. It extends the CocosDenhison CDLongAudioSourceDelegate fro playing
// background muusic and uses the CocosDenhison SimpleAudioEngine for preloading and playing audio effects for the
// menu buttons.
//
// PLEASE NOTE: RATHER THAN REPEAT THE SAME COMMENTS FOR THE BACKGROUND LAYER OF EVERY SCENE
//
// PLEASE GO TO: Classes/Main Menu/MainMenuGameplay.m
//
// FOR DETAILED DESCRIPTION OF WHAT IS GOING ON IN A MENU GAMEPLAY LAYER.


#import "InGameChooseMenuGameplay.h"
#import "CutScene.h"
#import "MainMenuScene.h"

@implementation InGameChooseMenuGameplay

-(void)playBackgroundMusic
{
    CCLOG(@"IN GAME CHOOSE LEVEL SCENE GAMEPLAY playBackgroundMusic CALLED");
    [[CDAudioManager sharedManager] playBackgroundMusic:aMainMenBackground loop:YES];
    
}

-(void)startLevelOneAgain
{
    CCLOG(@"IN GAME CHOOSE LEVEL SCENE GAMEPLAY startLevelOneAgain CALLED");
    [[CDAudioManager sharedManager] stopBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] playEffect:aButtonOneSound];
    [[CCDirector sharedDirector] pushScene:[CutScene node]];
}

-(void)backToGame
{
    CCLOG(@"IN GAME CHOOSE LEVEL SCENE GAMEPLAY backToGame CALLED");
    [[CDAudioManager sharedManager] stopBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] playEffect:aButtonTwoSound];
    [[CCDirector sharedDirector] popScene];
    
}

-(void)exitToMainMenu
{
    CCLOG(@"IN GAME CHOOSE LEVEL SCENE GAMEPLAY exitToMainMenu CALLED");
    [[CDAudioManager sharedManager] stopBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] playEffect:aButtonOneSound];
    [[CCDirector sharedDirector] pushScene:[MainMenuScene node]];
}

-(id)init
{
    CCLOG(@"CHOOSE LEVEL MENU GAMEPLAY LAYER INITIATED");
    self = [super init];
    if (self != nil)
    {
        screenSize = [CCDirector sharedDirector].winSize;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            menuBackground = [CCSprite spriteWithFile:@"ingame_chooselevel_menu_back-ipadhd.png"];
            
            inGameChooseLevelOneIcon = [CCMenuItemImage itemWithNormalImage:@"ingame_chooselevel_choose-ipadhd.png"
                                                              selectedImage:@"ingame_chooselevel_choose_selected-ipadhd.png"
                                                              disabledImage:nil
                                                                     target:self
                                                                   selector:@selector(startLevelOneAgain)];
            
            backToGameIcon = [CCMenuItemImage itemWithNormalImage:@"ingame_chooselevel_back-ipadhd.png"
                                                    selectedImage:@"ingame_chooselevel_back_selected-ipadhd.png"
                                                    disabledImage:nil
                                                           target:self
                                                         selector:@selector(backToGame)];
            
            exitToMainMenu = [CCMenuItemImage itemWithNormalImage:@"ingame_chooselevel_main_menu-ipadhd.png"
                                                    selectedImage:@"ingame_chooselevel_main_menu_selected-ipadhd.png"
                                                    disabledImage:nil
                                                           target:self
                                                         selector:@selector(exitToMainMenu)];
            
            inGameChooseLevelMenu = [CCMenu menuWithItems:inGameChooseLevelOneIcon, backToGameIcon, exitToMainMenu, nil];
            
            menuBackground.position = ccp(screenSize.width/2, (screenSize.height/2) - (80));
            inGameChooseLevelMenu.position = ccp(0, 0);
            inGameChooseLevelOneIcon.position = ccp(screenSize.width/2, (screenSize.height/2) - (10));
            backToGameIcon.position = ccp((screenSize.width/2) + (5), (screenSize.height/2) - (100));
            exitToMainMenu.position = ccp((screenSize.width/2), (screenSize.height/2) - (190));
        }
        else
        {
            menuBackground = [CCSprite spriteWithFile:@"ingame_chooselevel_menu_back-widehd.png"];
            
            inGameChooseLevelOneIcon = [CCMenuItemImage itemWithNormalImage:@"ingame_chooselevel_choose-widehd.png"
                                                              selectedImage:@"ingame_chooselevel_choose_selected-widehd.png"
                                                              disabledImage:nil
                                                                     target:self
                                                                   selector:@selector(startLevelOneAgain)];
            
            backToGameIcon = [CCMenuItemImage itemWithNormalImage:@"ingame_chooselevel_back-widehd.png"
                                                    selectedImage:@"ingame_chooselevel_back_selected-widehd.png"
                                                    disabledImage:nil
                                                           target:self
                                                         selector:@selector(backToGame)];
            
            exitToMainMenu = [CCMenuItemImage itemWithNormalImage:@"ingame_chooselevel_main_menu-widehd.png"
                                                    selectedImage:@"ingame_chooselevel_main_menu_selected-widehd.png"
                                                    disabledImage:nil
                                                           target:self
                                                         selector:@selector(exitToMainMenu)];
            
            inGameChooseLevelMenu = [CCMenu menuWithItems:inGameChooseLevelOneIcon, backToGameIcon, exitToMainMenu, nil];
            
            menuBackground.position = ccp(screenSize.width/2, (screenSize.height/2) - (30));
            inGameChooseLevelMenu.position = ccp(0, 0);
            inGameChooseLevelOneIcon.position = ccp(screenSize.width/2, (screenSize.height/2) - (3));
            backToGameIcon.position = ccp((screenSize.width/2) + (3), (screenSize.height/2) - (38));
            exitToMainMenu.position = ccp((screenSize.width/2) + (3), (screenSize.height/2) - (75));
        }
        
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:aButtonOneSound];
        [[SimpleAudioEngine sharedEngine] preloadEffect:aButtonTwoSound];
        
        [[CDAudioManager sharedManager] preloadBackgroundMusic:aMainMenBackground];
        rightChannel=[[CDAudioManager sharedManager] audioSourceForChannel:kASC_Right];
        rightChannel.delegate=self;
        
        [self playBackgroundMusic];
        
        [self addChild:menuBackground z:kMainMenuBackgroundZValue];
        [self addChild:inGameChooseLevelMenu z:kMainMenuZValue];
    }
    return self;
}

@end
