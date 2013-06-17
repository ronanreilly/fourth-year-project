//
//  CutSceneGameplay.h
//  game2
//
//  Created by Ronan Sean on 13/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
// Class Description Below:
//
// This is the interface file for the Cut Scene Gameplay Layer.
// All variables for the cut scene and method instances are declared here.

#import "cocos2d.h"
#import "Constants.h"
#import "SimpleAudioEngine.h"

@interface CutSceneGameplay : CCLayer <CDLongAudioSourceDelegate>
{
    // To store the screen size.
    CGSize screenSize;
    // To store the half the screen width and height.
    float halfScreenHeight;
    float halfScreenWidth;
    
    // This will store the current vakue of the timer used to increment the loading bar.
    float timeCounter;
    
    // Right channel for the background music.
    CDLongAudioSource *rightChannel;
    
    // The original frame for the animation.
    CCSprite *originalFrame;
    
    // The frames cache for the animation.
    CCSpriteFrameCache *mainAnimFramesCache;
    
    // The batch node for the animation.
    CCSpriteBatchNode *mainAnimBatchNode;
    
    // The graphics for the timer bar.
    CCSprite *timerBarTop;
    CCSprite *timerBarBottom;
    
    // The animation object for the iPad animation.
    CCAnimation *iPadAnim;
    CCAnimation *cutSceneAnimObject;

    // The skip animation icon.
    CCMenuItem *startGameIcon;
    CCMenuItem *startTutorialIcon;
    
    // The menu to hold the skip animation icons.
    CCMenu *cutSceneMenu;
    
    CCSprite *tutImage1;
    CCSprite *tutImage2;
    CCSprite *tutImage3;
    CCSprite *tutImage4;
    CCSprite *tutImage5;
    CCSprite *tutImage6;
    CCSprite *tutImage7;
    
    int currentTutorialFrame;
    
    
    CCSprite *tutMenuBack;
    CCMenuItem *tutNextIcon;
    CCMenuItem *tutPrevIcon;
    CCMenuItem *tutStartGameIcon;
    CCMenuItem *xIcon;
    CCMenu *tutMenu;
    
    BOOL backCutScene;
    
    id iPadAnimAction;
    id cutSceneActionObject;
    
    CCSprite *handIcon;
    CCSprite *keyIcon;
}

@property (nonatomic, retain) CCAnimation *iPadAnim;
@property (nonatomic, retain) CCAnimation *cutSceneAnimObject;

-(void)backToCutScene;
-(void)tutorialManagerPrev;
-(void)tutorialManagerNext;
-(void)incTime;
-(void)loadResources;
-(void)startCutSceneAnim;
-(void)startGame;

@end
