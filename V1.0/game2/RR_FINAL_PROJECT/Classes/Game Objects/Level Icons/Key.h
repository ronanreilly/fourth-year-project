//
//  Key.h
//  game2
//
//  Created by Ronan Sean on 16/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "cocos2d.h"
#import "Constants.h"
#import "LevelGameplay.h"

// Subclasses CCNode, conforms to CCTouchOneByOneDelegate protocol.

@interface Key : CCNode <CCTouchOneByOneDelegate>
{
    // The key image. 
    CCSprite *keySprite;
    // The layer this object/key will be displayed or created in.
    LevelGameplay *gameplayLayer;

}

@property (nonatomic, retain) CCSprite *keySprite;
@property (nonatomic, retain) LevelGameplay *gameplayLayer;

// Instance methods declared
-(id)initWithLayer:(LevelGameplay *)layer;
-(float)returnObjectHeight;

@end
