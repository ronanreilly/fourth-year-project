//
//  LevelBackground.m
//  RR_FINAL_PROJECT
//
//  Created by Ronan Sean on 21/01/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
// Class Overview Below:
//
// This class is a CCLayer. It will be hold the background image for level one  
// and position it at the back of the screen, with a low z value.
//
//
// PLEASE NOTE: RATHER THAN REPEAT THE SAME COMMENTS FOR THE BACKGROUND LAYER OF EVERY SCENE
//
// PLEASE GO: TO Classes/Main Menu/MainMenuBackground.m
//
// FOR DETAILED DESCRIPTION OF WHAT IS GOING ON IN A MENU BACKGROUND LAYER.

#import "LevelBackground.h"

@implementation LevelBackground
-(id) init
{
    CCLOG(@"LEVEL GAMEPLAY INITIATED");
    self = [super init];
    if (self != nil)
    {
        CCSprite *backgroundImage;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            backgroundImage = [CCSprite spriteWithFile:@"level-background-ipadhd.png"];
        }
        else
        {
            backgroundImage = [CCSprite spriteWithFile:@"level_background-widehd.png"];
        }
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
                                                 
        [self addChild:backgroundImage z:0 tag:0];
    }
    return self;
}

@end
