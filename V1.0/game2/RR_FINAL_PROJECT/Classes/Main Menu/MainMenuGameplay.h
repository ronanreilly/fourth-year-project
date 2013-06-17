//
//  MainMenuGameplay.h
//  game2
//
//  Created by Ronan Sean Reilly on 12/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "cocos2d.h"
#import "Constants.h"
#import "SimpleAudioEngine.h"

// This class inherits from CCLayer.

@interface MainMenuGameplay : CCLayer 
{
    // Screen Size Vars.
    CGSize screenSize;
    float halfScreenHeight;
    float halfScreenWidth;
    
    // Sprite for Background.
    CCSprite *menuBackground;
    
    // Menu items.
    CCMenuItem *startNewGameIcon;
    CCMenuItem *chooseLevelIcon;
    
    // Menu.
    CCMenu *mainMenu;

}

-(void)playBackgroundMusic;
-(void)startGame;
-(void)loadChooseLevelScene;

@end
