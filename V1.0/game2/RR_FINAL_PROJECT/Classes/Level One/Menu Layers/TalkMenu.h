//
//  TalkMenu.h
//  game5
//
//  Created by Ronan Sean Reilly on 18/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "cocos2d.h"

//
//  PauseMenu.h
//  game2
//
//  Created by Ronan Sean on 14/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "cocos2d.h"
#import "LevelGameplay.h"

@interface TalkMenu : CCLayer
{
    // Variables to hold the screen size for positioning.
    CGSize screenSize;
    float halfScreenWidth;
    float halfScreenHeight;
    
    // Boolean to keep track wheter the talk menu is currently visible.
    BOOL thisMenuIsVisible;
    
    // Booleans for keeping track of wheter the audio clip for a menu item has been played.
    BOOL isCsiTalkDone;
    BOOL isPictureTalkDone;
    BOOL isThugsTalkDone;
    BOOL allTalkDone;
    
    // These Booleans are used by the sortMenuItemsOrder so it can know what items to
    // remove from the talk menu.
    BOOL csiTalkDoneNowMove;
    BOOL pictureTalkDoneAndMove;
    BOOL thugsTalkDoneAndMove;
    
    // Boolean for keeping track of wheter any menu item has been used.
    BOOL menuItemHasBeenUsed;
    
    // Pointer to an instance of the level one gameplay layer.
    LevelGameplay *gameplayLayer;
    
    // Sprites for the menu back. One for when the menu has all three items
    // one for when the menu has two items and one for when the menu has only one item.
    CCSprite *menuBack;
    CCSprite *menuBackTwoItems;
    CCSprite *menuBackOneItems;
    
    // Menu items.
    CCMenuItem *csiTalkIcon;
    CCMenuItem *pictureTalkIcon;
    CCMenuItem *thugsTalkIcon;
    
    // Menu to contain the items above.
    CCMenu *talkMenu;
    
}

@property (nonatomic, retain) LevelGameplay *gameplayLayer;

// instance methods for the talk menu.

-(void)sortMenuItemsOrder;
-(void)talkIsFinished;
-(void)csiTalk;
-(void)pictureTalk;
-(void)thugsTalk;
-(void)addOrRemoveThisMenu;
-(id)initWithLayer:(LevelGameplay *)layer;

@end
