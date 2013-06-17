//
//  ChooseLevelGameplay.h
//  game2
//
//  Created by Ronan Sean Reilly on 12/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "cocos2d.h"
#import "Constants.h"
#import "SimpleAudioEngine.h"

// This class extends the CDLongAudioSourceDelegate, and inherits from CCLayer.

@interface ChooseLevelGameplay : CCLayer <CDLongAudioSourceDelegate>
{
    // Screen Size Vars
    CGSize screenSize;
    float halfScreenHeight;
    float halfScreenWidth;
    
    // This will point to the right channel.
    CDLongAudioSource *rightChannel;
    
     // Sprite for Background.
    CCSprite *menuBackground;
    
    // Menu items.
    CCMenuItem *chooseLevelOneIcon;
    CCMenuItem *backtoMainMenuIcon;
    
    // Menu.
    CCMenu *chooseLevelMenu;
}

-(void)playBackgroundMusic;
-(void)startLevelOne;
-(void)backToMainMenu;

@end
