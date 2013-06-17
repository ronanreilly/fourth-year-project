//
//  TouchPicture.h
//  game2
//
//  Created by Ronan Sean on 17/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "CCNode.h"
#import "Constants.h"
#import "LevelGameplay.h"

@interface TouchPicture : CCNode <CCTouchOneByOneDelegate>
{
    CCSprite *pictureTouchArea;
    InventoryMenu *inventoryMenuLayer;
}
@property (nonatomic, retain) CCSprite *pictureTouchArea;
@property (nonatomic, retain) LevelGameplay *gameplayLayer;

-(id)initWithLayer:(LevelGameplay *)layer;
-(float)returnObjectHeight;

@end
