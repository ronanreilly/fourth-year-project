//
//  HelpMenu.m
//  game2
//
//  Created by Ronan Sean Reilly on 14/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "HelpMenu.h"

@implementation HelpMenu

-(void)dealloc
{
    [super dealloc];
}

#pragma mark Show Or Hide Menu
-(void)addOrRemoveThisMenu
{
    CCLOG(@"HELP MENU LAYER addOrRemoveThisMenu CALLED");
    if (thisMenuIsVisible == NO)
    {
        menuBack.position = ccp((halfScreenWidth), (halfScreenHeight));
        menuText.position = ccp((halfScreenWidth), (halfScreenHeight));
        thisMenuIsVisible = YES;
    }
    else{
        menuBack.position = ccp((screenSize.width) * (2), (halfScreenHeight));
        menuText.position = ccp((screenSize.width) * (2), (halfScreenHeight));
        thisMenuIsVisible = NO;
    }
}

#pragma mark General Intialisation
-(id)init
{
    CCLOG(@"HELP MENU LAYER INITIATED");
    self = [super init];
    CCLOG(@"MENU LAYER INITIATED");
    if (self != nil)
    {
        screenSize = [CCDirector sharedDirector].winSize;
        halfScreenWidth = screenSize.width/2;
        halfScreenHeight = screenSize.height/2;
      
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            menuBack = [CCSprite spriteWithFile:@"help_menu_background-ipadhd.png"];
            menuText = [CCSprite spriteWithFile:@"help_menu_text-ipadhd.png"];
        }
        else
        {
            menuBack = [CCSprite spriteWithFile:@"help_menu_background-widehd.png"];
            menuText = [CCSprite spriteWithFile:@"help_menu_text-widehd.png"];
        }
        
        thisMenuIsVisible = NO;
        
        menuBack.position = ccp((screenSize.width) * (2), (halfScreenHeight));
        menuText.position = ccp((screenSize.width) * (2), (halfScreenHeight));
        
        [self addChild:menuBack z:0];
        [self addChild:menuText z:5];
    }
    return self;
}

@end
