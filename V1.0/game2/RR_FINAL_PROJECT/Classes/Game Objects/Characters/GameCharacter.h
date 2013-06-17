//
//  GameCharacter.h
//  game5
//
//  Created by Ronan Sean on 18/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "cocos2d.h"

// Characters are sprites so this class sub classes CCSprite.
@interface GameCharacter : CCSprite
{
    // Animation objects common to both characters
    CCAnimation *walkLeft;
    CCAnimation *walkRight;
}

@property (nonatomic, retain) CCAnimation *animObjectWalkRight;
@property (nonatomic, retain) CCAnimation *animObjectWalkLeft;

// Both characters require methods for walking left and right.
-(void)walkRight;
-(void)walkLeft;

// This method will be used to read data from a plist for a charcters animations.
-(CCAnimation *)loadPlistForAnimationWithName:(NSString *)animationName andClassName:(NSString *)className;


@end
