//
//  LevelScene.m
//  RR_FINAL_PROJECT
//
//  Created by Ronan Sean on 21/01/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
// Class Overview Below:
//
// This class is a CCScene. It is responsible for loading the two layers that make up the main menu and
// assigning their z values on the screen.
//
//
// PLEASE NOTE: RATHER THAN REPEAT THE SAME COMMENTS FOR EVERY SCENE
//
// PLEASE GO TO: Classes/Main Menu/MainMenuScene.m
//
// FOR DETAILED DESCRIPTION OF WHAT IS GOING ON IN A SCENE.

#import "LevelScene.h"

@implementation LevelScene -(id)init
{
    CCLOG(@"LEVEL SCENE INITIATED");
    self = [super init];
    if (self != nil)
    {
        LevelBackground *levelBackground = [LevelBackground node];
        [self addChild:levelBackground z:0];
        
        LevelGameplay *levelGameplay = [LevelGameplay node];
        [self addChild:levelGameplay z:5];        
    }
    return self;
}

@end
