//
//  Receipt.h
//  game2
//
//  Created by Ronan Sean on 16/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "cocos2d.h"
#import "Constants.h"
#import "LevelGameplay.h"

@interface Receipt : CCNode <CCTouchOneByOneDelegate>
{
    CCSprite *receiptSprite;
    LevelGameplay *gameplayLayer;
}
@property (nonatomic, retain) CCSprite *receiptSprite;
@property (nonatomic, retain) LevelGameplay *gameplayLayer;

-(id)initWithLayer:(LevelGameplay *)layer;
-(float)returnObjectHeight;

@end
