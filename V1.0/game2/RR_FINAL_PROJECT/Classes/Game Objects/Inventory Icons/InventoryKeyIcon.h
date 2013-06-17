//
//  InventoryKeyIcon.h
//  game2
//
//  Created by Ronan Sean on 17/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "cocos2d.h"
#import "Constants.h"
#import "InventoryMenu.h"

@interface InventoryKeyIcon : CCNode <CCTouchOneByOneDelegate>
{
    CCSprite *keyIconSprite;
    InventoryMenu *inventoryMenuLayer;

}
@property (nonatomic, retain) CCSprite *keyIconSprite;
@property (nonatomic, retain) InventoryMenu *inventoryMenuLayer;

-(id)initWithLayer:(InventoryMenu *)layer;
-(float)returnObjectHeight;
-(float)returnobjectWidth;

@end
