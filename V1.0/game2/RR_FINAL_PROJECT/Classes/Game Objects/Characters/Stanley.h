//
//  Stanley.h
//  RR_FINAL_PROJECT
//
//  Created by Ronan Sean Reilly on 07/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "Constants.h"
#import "GameCharacter.h"

// Subclasses our custom Game character class.
@interface Stanley : GameCharacter 
{    
    CGSize screenSize;
    
    // The original frame for character.
    CCSprite *characterOriginalFrame;
    
    // Frames cache for our animations.
    CCSpriteFrameCache *framesCache;
    
    // Batch node for our sprite sheet.
    CCSpriteBatchNode *spriteBatchNode;

    // Animation objects for our characters walking
    // and picking up animations.
    CCAnimation *animObjectWalkRight;
    CCAnimation *animObjectWalkLeft;
    CCAnimation *animObjectPickRight;
    CCAnimation *animObjectPickLeft;

    
    // These variables will store the animation actions
    // for our charcater.
    id animActionOne;
    id animActionTwo;
    // Action for sequence animation callback
    id callBackWrapperActionOne;
    // Action for sequence animation to Walk & Pick Right
    id sequenceRightMovement;
    // Action for sequence animation to Walk & Pick Left
    id sequenceLeftMovement;
}

// These properties are retained incase the OS purges the cache
// to free memory, we do not want them to be wiped.
@property (nonatomic, retain) CCAnimation *animObjectWalkRight;
@property (nonatomic, retain) CCAnimation *animObjectWalkLeft;
@property (nonatomic, retain) CCAnimation *animObjectPickRight;
@property (nonatomic, retain) CCAnimation *animObjectPickLeft;

// Instance Methods.
-(float)returnCharacterWidth;
-(void)stopActions;
-(void)resetAllActionsAndSequences;
-(void)walkRight;
-(void)walkRightAndPickUp;
-(void)walkLeft;
-(void)walkLeftAndPickUp;

@end
