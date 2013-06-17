//
//  InGameChooseMenuGameplay.h
//  game2
//
//  Created by Ronan Sean Reilly on 13/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
// Class Overview Below:
//
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


#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "Constants.h"

@interface InGameChooseMenuGameplay : CCLayer <CDLongAudioSourceDelegate>
{
    CGSize screenSize;
    
    CDLongAudioSource *rightChannel;
    
    CCSprite *menuBackground;
    
    CCMenuItem *inGameChooseLevelOneIcon;
    CCMenuItem *backToGameIcon;
    CCMenuItem *exitToMainMenu;
    
    CCMenu *inGameChooseLevelMenu;
}

-(void)playBackgroundMusic;
-(void)startLevelOneAgain;
-(void)backToGame;
-(void)exitToMainMenu;

@end
