//
//  EndGameMenuGameplay.m
//  game2
//
//  Created by Ronan Sean Reilly on 13/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
// Class Description Below:
//
// This class is a CCLayer. It contains the end game menu background, the menu and its buttons
// and handles the touch for this menu. It extends the CocosDenhison CDLongAudioSourceDelegate fro playing
// background muusic and uses the CocosDenhison SimpleAudioEngine for preloading and playing audio effects for the
// menu buttons.
//
// PLEASE NOTE: RATHER THAN REPEAT THE SAME COMMENTS FOR THE BACKGROUND LAYER OF EVERY SCENE
//
// PLEASE GO TO: Classes/Main Menu/MainMenuGameplay.m
//
// FOR DETAILED DESCRIPTION OF WHAT IS GOING ON IN A MENU GAMEPLAY LAYER.

#import "EndGameMenuGameplay.h"
#import "MainMenuScene.h"

@implementation EndGameMenuGameplay


-(void)playBackgroundMusic
{
    [[CDAudioManager sharedManager] playBackgroundMusic:aEndGameMenBackground loop:YES];
}

-(void)exitToMainMenu
{
    CCLOG(@"END LEVEL MENU GAMEPLAY exitToMainMenu CALLED");
    [[CDAudioManager sharedManager] stopBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] playEffect:aButtonOneSound];
    [[CCDirector sharedDirector] pushScene:[MainMenuScene node]];
}

-(id)init
{
    CCLOG(@"END LEVEL MENU GAMEPLAY LAYER INITIATED");
    self = [super init];
    if (self != nil)
    {
        
        screenSize = [CCDirector sharedDirector].winSize;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            menuBackground = [CCSprite spriteWithFile:@"end_game_menu_back-ipadhd.png"];
            
            exitToMainMenu = [CCMenuItemImage itemWithNormalImage:@"end_game_back-ipadhd.png"
                                                    selectedImage:@"end_game_back_selected-ipadhd.png"
                                                    disabledImage:nil
                                                           target:self
                                                         selector:@selector(exitToMainMenu)];
            
            endGameMenu = [CCMenu menuWithItems: exitToMainMenu, nil];
            
            menuBackground.position = ccp(screenSize.width/2, (screenSize.height/2) - (80));
            endGameMenu.position = ccp(0, 0);
            exitToMainMenu.position = ccp(screenSize.width/2, (screenSize.height/2) - (60));
            
        }
        else
        {
            menuBackground = [CCSprite spriteWithFile:@"end_game_menu_back-widehd.png"];
            
            exitToMainMenu = [CCMenuItemImage itemWithNormalImage:@"end_game_back-widehd.png"
                                                    selectedImage:@"end_game_back_selected-widehd.png"
                                                    disabledImage:nil
                                                           target:self
                                                         selector:@selector(exitToMainMenu)];
            
            endGameMenu = [CCMenu menuWithItems: exitToMainMenu, nil];
            
            menuBackground.position = ccp(screenSize.width/2, (screenSize.height/2) - (20));
            endGameMenu.position = ccp(0, 0);
            exitToMainMenu.position = ccp(screenSize.width/2, (screenSize.height/2) - (20));
        }
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:aButtonOneSound];
        [[CDAudioManager sharedManager] preloadBackgroundMusic:aEndGameMenBackground];
        rightChannel=[[CDAudioManager sharedManager] audioSourceForChannel:kASC_Right];
        rightChannel.delegate=self;
        
        [self playBackgroundMusic];
        
        [self addChild:menuBackground z:kMainMenuBackgroundZValue];
        [self addChild:endGameMenu z:kMainMenuZValue];
    }
    return self;
}

@end