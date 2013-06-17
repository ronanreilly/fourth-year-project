//
//  ORourke.h
//  game5
//
//  Created by Ronan Sean on 18/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//

#import "GameCharacter.h"
#import "Constants.h"

// Subclasses our custom Game character class.
@interface ORourke : GameCharacter 
{
    CGSize screenSize;
    
    // The original frame for character.
    CCSprite *characterOriginalFrame;
    
    // Frames cache for our animations.
    CCSpriteFrameCache *framesCache;
    
    // Batch node for our sprite sheet.
    CCSpriteBatchNode *spriteBatchNode;
    
    // Vars for our animation actions.
    id frameObjectWalkRight;
    id frameObjectWalkLeft;

    // Animation objects for our characters walking animations.
    CCAnimation *animObjectWalkRight;
    CCAnimation *animObjectWalkLeft;
    
    // ANIMATION ACTIONS
    id animActionOne;
    id animActionTwo;
}

// These properties are retained incase the OS purges the cache
// to free memory, we do not want them to be wiped.
@property (nonatomic, retain) CCAnimation *animObjectWalkRight;
@property (nonatomic, retain) CCAnimation *animObjectWalkLeft;
@property (nonatomic, retain) CCSpriteBatchNode *charOriginalFrame;

// Instance methods.
-(void)stopActions;
-(void)resetAllActionsAndSequences;
-(float)returnCharacterWidth;
-(float)returnCharacterHeight;
-(void)walkLeft;
-(void)walkRight;


@end

    


