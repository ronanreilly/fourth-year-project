//
//  EndGameMenuGameplay.h
//  game2
//
//  Created by Ronan Sean Reilly on 13/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "Constants.h"

@interface EndGameMenuGameplay : CCLayer <CDLongAudioSourceDelegate>
{
    CGSize screenSize;
    
    CDLongAudioSource *rightChannel;
    
    CCSprite *menuBackground;
    
    CCMenuItem *exitToMainMenu;
    
    CCMenu *endGameMenu;
}

-(void)playBackgroundMusic;
-(void)exitToMainMenu;

@end