//
//  EndGameMenuScene.m
//  game2
//
//  Created by Ronan Sean Reilly on 13/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
// This class is a CCScene. It is responsible for loading the two layers that make up the end game menu and
// assigning their z values on the screen.
//
//
// PLEASE NOTE: RATHER THAN REPEAT THE SAME COMMENTS FOR EVERY SCENE
//
// PLEASE GO TO: Classes/Main Menu/MainMenuScene.m
//
// FOR DETAILED DESCRIPTION OF WHAT IS GOING ON IN A SCENE.

#import "EndGameMenuScene.h"

@implementation EndGameMenuScene

-(id)init{
    CCLOG(@"IN GAME CHOOSE LEVEL SCENE INITIATED");
    self = [super init];
    if (self != nil)
    {
        EndGameMenuBackground *endGameMenuBackground = [EndGameMenuBackground node];
        [self addChild:endGameMenuBackground z:0];
        
        EndGameMenuGameplay *endGameMenuGameplay = [EndGameMenuGameplay node];
        [self addChild:endGameMenuGameplay z:5];
    }
    return self;
}


@end
