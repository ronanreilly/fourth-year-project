//
//  HelpMenu.h
//  game2
//
//  Created by Ronan Sean Reilly on 14/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "cocos2d.h"

@interface HelpMenu : CCLayer
{
    CGSize screenSize;
    float halfScreenWidth;
    float halfScreenHeight;
    
    BOOL thisMenuIsVisible;
    
    CCSprite *menuBack;
    CCSprite *menuText;
    
}

-(void)addOrRemoveThisMenu;
    
@end
