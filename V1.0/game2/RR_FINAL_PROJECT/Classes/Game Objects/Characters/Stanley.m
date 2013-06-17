//
//  Stanley.m
//  RR_FINAL_PROJECT
//
//  Created by Ronan Sean Reilly on 07/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
// Class Description Below:
//
// This class is a subclass of the custom game character class.This class is responsible for setting up Stanleys
// animations for walking and Picking up. An instance of this class will be created in the Gameplay Layer and interacted with.
//
//

#import "Stanley.h"

@implementation Stanley

@synthesize animObjectWalkRight, animObjectPickLeft, animObjectPickRight, animObjectWalkLeft;

// Release the anim objects, when class is removed.
-(void)dealloc
{
    [animObjectWalkRight release];
    [animObjectWalkLeft release];
    [animObjectPickRight release];
    [animObjectPickLeft release];
    [super dealloc];    
}

#pragma mark Manage Actions and Sequences

// This method will stop all actions currently running.

-(void)stopActions{
    [self stopAllActions];
}

// This method resets teh variables that store the animation actions to nil
// so they can be reused again for new animations.

-(void)resetAllActionsAndSequences
{
    CCLOG(@"STANLEY resetAllActionsAndSequences CALLED");
    [self stopAllActions];
    animActionOne = nil;
    animActionTwo = nil;
    sequenceRightMovement = nil;
    sequenceLeftMovement = nil;
    callBackWrapperActionOne = nil;
    animObjectPickLeft = nil;
    animObjectPickRight = nil;
}

#pragma mark Width Method

// This method will return the width of the Stanley sprite.

-(float)returnCharacterWidth
{
    CCLOG(@"STANLEY returnHalfCharacterWidth CALLED");
    float characterSize = characterOriginalFrame.contentSize.width;
    CCLOG(@"Character size is: %f", characterSize);
    return characterSize;
}

#pragma mark Walk Left, Right, Pick Up Methods

// All of these methods look after the setting up of the walking
// and walking and picking up animations. They in trun run animation
// actions on the original sprite.

-(void)walkRight
{
    CCLOG(@"STANLEY walkRight CALLED");
    // Stop any running actions.
    [self stopAllActions];
    
    // Call the loadPlistForAnimationWithName from the game character class, give it an animation name.
    // The animations are declared in the header file for this class. Pass the name of this class to the method
    // and use the NSString method NSStringFromClass to convert the name to a string.
    [self setAnimObjectWalkRight:[self loadPlistForAnimationWithName:@"stanWalkRight" andClassName:NSStringFromClass([self class])]];
    
    // Create an animation action and store it in animActionOne. Pass the animation created above to this action.
    animActionOne = [CCAnimate actionWithAnimation:animObjectWalkRight];
    // This var stores a CCCallFunc that will be used to clear all actions and sequences once this animation has run.
    callBackWrapperActionOne = [CCCallFunc actionWithTarget:self
                                                   selector:@selector(resetAllActionsAndSequences)];
    // A sequences is set up, this sequence is given an animation to run first the var that
    // contains the call back. The sequence executes each action in the order they listed in
    // See below:
    sequenceRightMovement = [CCSequence actions:animActionOne, callBackWrapperActionOne,  nil];
    
    // Finally the sequnce is run on teh original frame.
    [characterOriginalFrame runAction:sequenceRightMovement];
}

// This method is exactly the same as the one above except that it has three actions to pass in
// to a sequence. Two animations and then a callback to clear all sequences and stop all running actions.

-(void)walkRightAndPickUp
{
    CCLOG(@"STANLEY walkRightAndPickUp CALLED");
    // Stop any running actions.
    [self stopAllActions];
    
    
    // Setting up the walking animation. The same way as descibed in the walkRight method.
   [self setAnimObjectWalkRight:[self loadPlistForAnimationWithName:@"stanWalkRight" andClassName:NSStringFromClass([self class])]];
    // Setting up the picking up animation. // Setting up the walking animation. The same way as descibed in the walkRight method.
   [self setAnimObjectPickRight:[self loadPlistForAnimationWithName:@"stanPickRight" andClassName:NSStringFromClass([self class])]];
    
    
    // Creating the animation action for the walking animation. 
    animActionOne = [CCAnimate actionWithAnimation:animObjectWalkRight];
    // Creating the animation action for the picking up animation. 
    animActionTwo = [CCAnimate actionWithAnimation:animObjectPickRight];
    // This var stores a CCCallFunc that will be used to clear all actions and sequences.
    callBackWrapperActionOne = [CCCallFunc actionWithTarget:self
                                                   selector:@selector(resetAllActionsAndSequences)];
    
    // The two animation actions are passed to a sequence and the third action is the call back to clear all actions and sequences
    sequenceRightMovement = [CCSequence actions:animActionOne, animActionTwo, callBackWrapperActionOne,  nil];
   
    // The sequence is then run on the original frame sprite.
    // Each action will run its course before the next is executed.
    [characterOriginalFrame runAction:sequenceRightMovement];
}

// See the walkRight method above for detailed description.

-(void)walkLeft
{
    CCLOG(@"STANLEY walkLeft CALLED");
    [self stopAllActions];
    // WALK LEFT ANIMATION
    [self setAnimObjectWalkLeft:[self loadPlistForAnimationWithName:@"stanWalkLeft" andClassName:NSStringFromClass([self class])]];
    
    animActionOne = [CCAnimate actionWithAnimation:animObjectWalkLeft];
    callBackWrapperActionOne = [CCCallFunc actionWithTarget:self
                                                   selector:@selector(resetAllActionsAndSequences)];
    sequenceLeftMovement = [CCSequence actions:animActionOne, callBackWrapperActionOne,  nil];
    [characterOriginalFrame runAction:sequenceLeftMovement];
    
}

// See the walkRightAndPickUp method above for detailed description.

-(void)walkLeftAndPickUp
{
    CCLOG(@"STANLEY walkLeftAndPickUp CALLED");
    [self stopAllActions];
    // WALK LEFT ANIMATION
    [self setAnimObjectWalkLeft:[self loadPlistForAnimationWithName:@"stanWalkLeft" andClassName:NSStringFromClass([self class])]];
    [self setAnimObjectPickLeft:[self loadPlistForAnimationWithName:@"stanPickLeft" andClassName:NSStringFromClass([self class])]];

    animActionOne = [CCAnimate actionWithAnimation:animObjectWalkLeft];
    animActionTwo = [CCAnimate actionWithAnimation:animObjectPickLeft];
    callBackWrapperActionOne = [CCCallFunc actionWithTarget:self
                                                   selector:@selector(resetAllActionsAndSequences)];
    sequenceLeftMovement = [CCSequence actions:animActionOne, animActionTwo, callBackWrapperActionOne,  nil];
    [characterOriginalFrame runAction:sequenceLeftMovement];
}


#pragma mark Stanley General Intialisation

-(id)init{
    CCLOG(@"STANLEY OBJECT INTIATED");
    // Initialising the super object, CCLayer.
    self = [super init];
    // Checking that intialistaion of the super object failed.
    if (self != nil)
    {
        // Getting the screen size from the director.
        screenSize = [CCDirector sharedDirector].winSize;
        
        // Check if app is running on iPad or iPhone.
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            // Create a frames cache to store the property list with sprite sheet co-ordinates.
            framesCache = [CCSpriteFrameCache sharedSpriteFrameCache];
            // Pass the plist with the sprite sheet co-ordinates to the frames cache.
            [framesCache addSpriteFramesWithFile:@"characters-ipadhd.plist"];
            // Create a sprite batch to store the sprite sheet that has all the individual character
            // images packed into it. This will allow the GPU to draw all of the character images
            // on screen with one OPENGL ES call.
            spriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"characters-ipadhd.png"];
        }
        else
        {
            // See above for description.
             
            framesCache = [CCSpriteFrameCache sharedSpriteFrameCache];
            [framesCache addSpriteFramesWithFile:@"characters-widehd.plist"];
            spriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"characters-widehd.png"];
        }
        
        //[self stopAllActions];
        
        // Making sure that the vars to store the animation actions are nil.
        animActionOne = nil;
        animActionTwo = nil;
        sequenceRightMovement = nil;
        sequenceLeftMovement = nil;
        callBackWrapperActionOne = nil;
        animObjectPickLeft = nil;
        animObjectPickRight = nil;
        
         // creating the original frame for this character. (stationary position).
        characterOriginalFrame = [CCSprite spriteWithSpriteFrameName:@"stan_walk_right_1.png"];
        
        // Adding the original frame to the batch node.
        // Stanley Orginal added to sprite batch node.
        [spriteBatchNode addChild:characterOriginalFrame];

        // Sprite batch node added to self.
        [self addChild:spriteBatchNode z:0];
    }
    
    return self;
}

@end
