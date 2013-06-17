//
//  MainMenuScene.m
//  game2
//
//  Created by Ronan Sean Reilly on 12/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
// Class Overview Below:
//
// This class is a CCScene. It is responsible for loading the two layers that make up the main menu and
// assigning their z values on the screen.

#import "MainMenuScene.h"

@implementation MainMenuScene

-(id)init
{
    CCLOG(@"LEVEL SCENE INITIATED");
    
    // Initialising the super object, CCScene.
    self = [super init];
    // Checking that intialistaion of the super object failed.
    if (self != nil)
    {
        // Creating an instance of MainMenuBackground.
        // Calling node is a short hand way of allocating and intialising
        // the background layer.
        MainMenuBackground *mainMenuBackground = [MainMenuBackground node];
        
        // Adding the background layer to this scene.
        // Giving it a z value of 0 so it is at the back of
        // stack of layers to be displayed on scene.
        [self addChild:mainMenuBackground z:0];
        
        
        // Creating an instance of mainMenuGameplay.
        // Calling node is a short hand way of allocating and intialising
        // the mainMenuGameplay layer.
        MainMenuGameplay *mainMenuGameplay = [MainMenuGameplay node];
        
        // Adding the background layer to this scene.
        // Giving it a z value of 5 so it is at the front
        // of the layes for this scene. This layer handles touch
        // so it needs to be on front of the background layer.
        [self addChild:mainMenuGameplay z:5];
    }
    return self;
}
@end


