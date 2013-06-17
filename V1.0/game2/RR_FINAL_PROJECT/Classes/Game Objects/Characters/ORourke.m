//
//  ORourke.m
//  game5
//
//  Created by Ronan Sean on 18/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
// Class Description Below:
//
// This class is a subclass of the custom game character class.This class is responsible for setting up ORourkes
// animations for walking. An instance of this class will be created in the Gameplay Layer and interacted with.
//
// 
#import "ORourke.h"

@implementation ORourke

// Synthesising animation objects and character original frame.
@synthesize animObjectWalkRight, animObjectWalkLeft, charOriginalFrame;

// release the anim objects, when class is removed.
-(void)dealloc
{
    [animObjectWalkRight release]; 
    [animObjectWalkLeft release];
    [super dealloc];
}

#pragma mark Manage Actions and Sequences

// This method will stop all actions currently running.

-(void)stopActions
{
    CCLOG(@"OROURKE stopActions CALLED");
    [self stopAllActions];
}

// This method resets the variables that store the animation actions to nil
// so they can be used again for new animations.

-(void)resetAllActionsAndSequences
{
    CCLOG(@"OROURKE resetAllActionsAndSequences CALLED");
    [self stopAllActions];
    animActionOne = nil;
    animActionTwo = nil;
}

#pragma mark Height and Width Methods

// These two methods return the height and width of the current sprite
// being displayed for this character. These will be used by the gameplay
// layer to make this character touchable by creating a rectangle around it.

-(float)returnCharacterWidth
{
    CCLOG(@"OROURKE returnHalfCharacterWidth CALLED");
    float characterWidth = characterOriginalFrame.contentSize.width;
    CCLOG(@"Character width is: %f", characterWidth);
    return characterWidth;
}

-(float)returnCharacterHeight
{
    CCLOG(@"OROURKE returnHalfCharacterWidth CALLED");
    float characterHeight = characterOriginalFrame.contentSize.height;
    CCLOG(@"Character height is: %f", characterHeight);
    return characterHeight;
}

#pragma mark Walk Left and Right Methods

// Both of these methods look after the setting up of the walking animations
// and in turn actually running the them.

-(void)walkLeft
{
    CCLOG(@"OROURKE walkLeft CALLED");
    // Call the loadPlistForAnimationWithName from the game character class, give it an animation name.
    // The animations are declared in the interface file for this class. Pass the name of this class to the method
    // and use the NSString method NSStringFromClass to convert the name to a string.
    [self setAnimObjectWalkLeft:[self loadPlistForAnimationWithName:@"oRourkeWalkIn" andClassName:NSStringFromClass([self class])]];
    // Create an animation action and store it in animActionOne. Pass the animation created above to this action.
    animActionOne = [CCAnimate actionWithAnimation:animObjectWalkLeft];
    // Run the animation on the original frame sprite.
    [characterOriginalFrame runAction:animActionOne];
}

// See above for description.
-(void)walkRight
{
    CCLOG(@"OROURKE walkRight CALLED");
    [self setAnimObjectWalkLeft:[self loadPlistForAnimationWithName:@"oRourkeWalkOut" andClassName:NSStringFromClass([self class])]];
    animActionOne = [CCAnimate actionWithAnimation:animObjectWalkLeft];
    [characterOriginalFrame runAction:animActionOne];
}

#pragma mark General Intialisation

-(id)init{
    CCLOG(@"OROURKE OBJECT INTIATED");
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
            // Create a frames cache to store the playlist with sprite sheet co-ordinates.
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
        
        // Making sure that the vars to store the animation actions are nil.
        animActionOne = nil;
        animActionTwo = nil;
        
        // creating the original frame for this character. (stationary position).
        characterOriginalFrame = [CCSprite spriteWithSpriteFrameName:@"orourke_walk_in_1.png"];
        
        // Adding the original frame to the batch node.
        //  ORourke Orginal added to sprite batch node.
        [spriteBatchNode addChild:characterOriginalFrame];
        
        // oRourke batch node added to self.
        [self addChild:spriteBatchNode z:0];
    }
    
    return self;
}

@end

