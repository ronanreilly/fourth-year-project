//
//  PauseMenu.h
//  game2
//
//  Created by Ronan Sean on 14/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "cocos2d.h"
#import "SimpleAudioEngine.h"

@interface PauseMenu : CCLayer <CDLongAudioSourceDelegate>
{

    CGSize screenSize;
    float halfScreenWidth;
    float halfScreenHeight;

    BOOL thisMenuIsVisible;

    CCSprite *menuBack;
    
    CDLongAudioSource *rightChannel;
    
    CCMenuItem *playAnotherLevelIcon;
    CCMenuItem *quitGameIcon;
    CCMenuItem *backToGameIcon;
    
    CCMenu *inGamePauseMenu;
}

-(void)loadInGameChooseLevelScene;
-(void)quitGame;
-(void)backToGame;
-(void)addOrRemoveThisMenu;

@end
