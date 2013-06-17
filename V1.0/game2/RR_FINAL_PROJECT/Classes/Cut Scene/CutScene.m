//
//  CutScene.m
//  game2
//
//  Created by Ronan Sean on 13/02/2013.
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
// FOR DETAILED DESCRIPTION OF WHAT IS GOING ON IN A SCENE CLASS.

#import "CutScene.h"


@implementation CutScene

-(id)init
{
    CCLOG(@"CHOOSE LEVEL SCENE INITIATED");
    self = [super init];
    if (self != nil)
    {
        CutSceneBackground *cutSceneBackground = [CutSceneBackground node];
        [self addChild:cutSceneBackground z:0];
        
        CutSceneGameplay *cutSceneGameplay = [CutSceneGameplay node];
        [self addChild:cutSceneGameplay z:5];
    }
    return self;
}
@end
