//
//  TouchDoor.h
//  game2
//
//  Created by Ronan Sean on 18/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "cocos2d.h"
#import "Constants.h"
#import "LevelGameplay.h"

@interface TouchDoor : CCNode <CCTouchOneByOneDelegate>
{
    CCSprite *doorTouchArea;
    InventoryMenu *inventoryMenuLayer;
}
@property (nonatomic, retain) CCSprite *doorTouchArea;
@property (nonatomic, retain) LevelGameplay *gameplayLayer;

-(id)initWithLayer:(LevelGameplay *)layer;
-(float)returnObjectHeight;

@end
