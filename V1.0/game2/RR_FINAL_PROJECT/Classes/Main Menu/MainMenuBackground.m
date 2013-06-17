//
//  MainMenuBackground.m
//  game2
//
//  Created by Ronan Sean Reilly on 12/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
//
// This class is a CCLayer. It will be hold the background image for the Main Menu
// and position it at the back of the screen, with a low z value.

#import "MainMenuBackground.h"

@implementation MainMenuBackground

#pragma mark
-(id) init
{
    CCLOG(@"MAIN MENU BACKGROUND LAYER INITIATED");
    
    // Initialising the super object, CCLayer.
    self = [super init];
    // Checking that intialistaion of the super object failed.
    if (self != nil)
    {
        // A pointer to a CCSprite to contain the background image.
        CCSprite *backgroundImage;
        
        // Checeking what device the application is running on.
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            // Making the sprite declared above equal to the image below.
            backgroundImage = [CCSprite spriteWithFile:@"main_menu_background-ipadhd.png"];
        }
        else
        {
            // Making the sprite declared above equal to the image below.s
            backgroundImage = [CCSprite spriteWithFile:@"main_menu_background-widehd.png"];
        }
        
        // Getting the sceen size from the driector singleton.
        // Returns a struct, with a width and height.
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
        
        // Adding the background image to the layer, with a z value of 0.
        [self addChild:backgroundImage z:0 tag:0];
    }
    return self;
}
@end