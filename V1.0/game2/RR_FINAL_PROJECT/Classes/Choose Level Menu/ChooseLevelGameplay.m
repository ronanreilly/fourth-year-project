//
//  ChooseLevelGameplay.m
//  game2
//
//  Created by Ronan Sean Reilly on 12/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
// Class Overview Below:
//
//
// This class is a CCLayer. It contains the choose menu background, the menu and its buttons
// and handles the touch for this menu. It extends the CocosDenhison CDLongAudioSourceDelegate fro playing
// background muusic and uses the CocosDenhison SimpleAudioEngine for preloading and playing audio effects for the
// menu buttons.
//
// PLEASE NOTE: RATHER THAN REPEAT THE SAME COMMENTS FOR THE BACKGROUND LAYER OF EVERY SCENE
//
// PLEASE GO TO: Classes/Main Menu/MainMenuGameplay.m
//
// FOR DETAILED DESCRIPTION OF WHAT IS GOING ON IN A MENU GAMEPLAY LAYER.

#import "ChooseLevelGameplay.h"
#import "MainMenuScene.h"
#import "LevelScene.h"
#import "CutScene.h"

@implementation ChooseLevelGameplay

-(void)playBackgroundMusic
{
    [[CDAudioManager sharedManager] playBackgroundMusic:aMainMenBackground loop:YES];
}

#pragma mark Start Level Scene
-(void)startLevelOne
{
    CCLOG(@"CHOOSE LEVEL MENU GAMEPLAY startLevelOne CALLED");
    [[CDAudioManager sharedManager] stopBackgroundMusic];
    // Passed a string defined in Constants.h.
    [[SimpleAudioEngine sharedEngine] playEffect:aButtonOneSound];
    [[CCDirector sharedDirector] pushScene:[CutScene node]];
}

#pragma mark Back To Main Menu Function
-(void)backToMainMenu
{
    CCLOG(@"CHOOSE LEVEL MENU GAMEPLAY  backToMainMenu CALLED");
    [[CDAudioManager sharedManager] stopBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] playEffect:aButtonTwoSound];
    [[CCDirector sharedDirector] popScene];
}

#pragma mark Layer Intialisation
-(id)init
{
    CCLOG(@"CHOOSE LEVEL MENU GAMEPLAY LAYER INITIATED");
    self = [super init];
    if (self != nil)
    {
        screenSize = [CCDirector sharedDirector].winSize;
        halfScreenWidth = screenSize.width /2;
        halfScreenHeight = screenSize.height/2;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            menuBackground = [CCSprite spriteWithFile:@"chooselevel_menu_back-ipadhd.png"];
            
            chooseLevelOneIcon = [CCMenuItemImage itemWithNormalImage:@"chooselevel_choose-ipadhd.png"
                                                        selectedImage:@"chooselevel_choose_selected-ipadhd.png"
                                                        disabledImage:nil
                                                               target:self
                                                             selector:@selector(startLevelOne)];
            
            backtoMainMenuIcon = [CCMenuItemImage itemWithNormalImage:@"chooselevel_back-ipadhd.png"
                                                        selectedImage:@"chooselevel_back_selected-ipadhd.png"
                                                        disabledImage:nil
                                                               target:self
                                                             selector:@selector(backToMainMenu)];

            chooseLevelMenu = [CCMenu menuWithItems:chooseLevelOneIcon, backtoMainMenuIcon, nil];
            
            menuBackground.position = ccp((halfScreenWidth), (halfScreenHeight) - (80));
            
            chooseLevelMenu.position = ccp(0, 0);
            
            chooseLevelOneIcon.position = ccp((halfScreenWidth), (halfScreenHeight) - (40));
            backtoMainMenuIcon.position = ccp((halfScreenWidth), (halfScreenHeight) - (140));
            
        }
        else
        {
            
            menuBackground = [CCSprite spriteWithFile:@"chooselevel_menu_back-widehd.png"];
            
            chooseLevelOneIcon = [CCMenuItemImage itemWithNormalImage:@"chooselevel_choose-widehd.png"
                                                        selectedImage:@"chooselevel_choose_selected-widehd.png"
                                                        disabledImage:nil
                                                               target:self
                                                             selector:@selector(startLevelOne)];
            
            backtoMainMenuIcon = [CCMenuItemImage itemWithNormalImage:@"chooselevel_back-widehd.png"
                                                        selectedImage:@"chooselevel_choose-widehd.png"
                                                        disabledImage:nil
                                                               target:self
                                                             selector:@selector(backToMainMenu)];
            
            chooseLevelMenu = [CCMenu menuWithItems:chooseLevelOneIcon, backtoMainMenuIcon, nil];
            
            menuBackground.position = ccp((halfScreenWidth), (screenSize.height/2) - (30));
            chooseLevelMenu.position = ccp(0,0);
            chooseLevelOneIcon.position = ccp((halfScreenWidth), (halfScreenHeight) - (15));
            backtoMainMenuIcon.position = ccp((halfScreenWidth), (halfScreenHeight) - (60));

        }
        
        
        [[CDAudioManager sharedManager] preloadBackgroundMusic:aMainMenBackground];
        [[SimpleAudioEngine sharedEngine] preloadEffect:aButtonOneSound];
        [[SimpleAudioEngine sharedEngine] preloadEffect:aButtonTwoSound];
 
        rightChannel=[[CDAudioManager sharedManager] audioSourceForChannel:kASC_Right];
        rightChannel.delegate=self;
        
        [self playBackgroundMusic];

        [self addChild:menuBackground z:kMainMenuBackgroundZValue];
        
        [self addChild:chooseLevelMenu z:kMainMenuZValue];
    }
    return self;
}

@end
