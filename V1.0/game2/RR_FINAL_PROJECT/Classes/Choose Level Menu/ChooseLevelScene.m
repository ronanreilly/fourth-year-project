//
//  ChooseLevelScene.m
//  game2
//
//  Created by Ronan Sean Reilly on 12/02/2013.
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


#import "ChooseLevelScene.h"

@implementation ChooseLevelScene

#pragma Scene Initialisation
-(id)init
{
    CCLOG(@"CHOOSE LEVEL SCENE INITIATED");
    self = [super init];

    if (self != nil)
    {
        ChooseLevelBackground *chooseLevelBackground = [ChooseLevelBackground node];
        
        [self addChild:chooseLevelBackground z:0];
        
        ChooseLevelGameplay *chooseLevelGameplay = [ChooseLevelGameplay node];
        [self addChild:chooseLevelGameplay z:5];
    }
    return self;
}
@end


