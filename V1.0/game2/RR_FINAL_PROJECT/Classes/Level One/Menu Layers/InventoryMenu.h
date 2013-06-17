//
//  InventoryMenu.h
//  game2
//
//  Created by Ronan Sean on 14/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "cocos2d.h"
#import "Constants.h"
#import "LevelGameplay.h"
#import "LevelGameplay.h"
@class InventoryReceiptIcon;
@class InventoryKeyIcon;


@interface InventoryMenu : CCLayer
{
    // Screen size vars for positioning.
    CGSize screenSize;
    float halfScreenWidth;
    float halfScreenHeight;

    // Vars for keeping track of is this menu is visible.
    BOOL thisMenuIsVisible;
    BOOL receiptIsAdded; // Keeps track of wheter receipt has been picked up.
    BOOL keyIsAdded; // Keeps track of wheter key has been picked up.
    
    // Array for holdeing items that have been added to the inventory.
    NSMutableArray *inventoryItemsContainer;

    // Sprite for the menu's back.
    CCSprite *menuBack;
    
    // Variables for instances of the key and receipt objects.
    InventoryReceiptIcon *receiptIcon;
    InventoryKeyIcon *keyIcon;
    
    // Label to be shown when inventory is empty.
    CCLabelTTF *emptyInventoryLabel;
    
    // Ponter to the gameplay layer so we can access its method.
    LevelGameplay *gameplayLayer;

}

@property (nonatomic, retain) LevelGameplay *gameplayLayer;

// Instance methods.

-(void)moveKey;
-(id)initWithLayer:(LevelGameplay *)layer;
-(void)setGameState;
-(void)describeItem:(NSString *)itemToBeDescribed;
-(void)AddItem:(NSString *)itemToAddToInventory;
-(void)addOrRemoveThisMenu;


@end

