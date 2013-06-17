//
//  InventoryReceiptIcon.h
//  game2
//
//  Created by Ronan Sean on 16/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "cocos2d.h"
#import "Constants.h"
#import "InventoryMenu.h"


@interface InventoryReceiptIcon : CCNode <CCTouchOneByOneDelegate>
{
    CGSize screenSize;
    
    CCSprite *receiptIconSprite;
    InventoryMenu *inventoryMenuLayer;

}

@property (nonatomic, retain) CCSprite *receiptIconSprite;
@property (nonatomic, retain) InventoryMenu *inventoryMenuLayer;

-(id)initWithLayer:(InventoryMenu *)layer;
-(float)returnObjectHeight;
-(float)returnobjectWidth;

@end
