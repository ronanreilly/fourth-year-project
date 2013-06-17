//
//  Key.m
//  game2
//
//  Created by Ronan Sean on 16/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
// Class Description Below:
//
// This class is a composite object. It is added to the LevelGameplay layer as a child and has a sprite added to
// itself.
//
// This class is s subclass of CCNode and conforms to the CCTouchOneByOneDelegate in order for it to handle
// touch events. The class itself contains a sprite, made from an image of a key. This key is be
// added to the main gameplaylayer. If this object is touched it will send a message to the gameplay layer
// informing it that this object has been touched.
// 
// The touch handling technuiques in this class were learned, taken and adpated from the tutorial below
// by Bob Euland:
//
// http://bobueland.com/cocos2d/2011/touchdispatcher-secrets/
//

#import "Key.h"
#import "LevelGameplay.h"

@implementation Key

// Synthesising vars from interface file.
@synthesize keySprite, gameplayLayer;

#pragma mark Intialisation
-(id)initWithLayer:(LevelGameplay *)layer
{
    self = [super init];
    CCLOG(@"Key INITIATED");
    if (self)
    {
        // Add this object to the gameplay layer as a child.
        self.gameplayLayer=layer;
        
        // Check if app is running on iPad or iPhone.
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            // Create the key sprite for iPad.
            self.keySprite = [CCSprite spriteWithFile:@"key_icon-ipadhd.png"];
        }
        else
        {
            // Create the key sprite for iPhone;
            self.keySprite = [CCSprite spriteWithFile:@"key_icon-widehd.png"];
        }
        
        // Add the key to sprite to self.
        [self addChild:keySprite z:kInvisiItemsZvalue];
    }
    return self;
}

// This method simply returns the key sprites width so it can be accessed from the gameplayLayer.

#pragma mark Return Object Height
-(float)returnObjectHeight
{
    CCLOG(@"KEY returnHalfCharacterWidth CALLED");
    float objectSize = keySprite.contentSize.height;
    CCLOG(@"key height is: %f", objectSize);
    return objectSize;
}

#pragma mark Dealloc
- (void)dealloc
{
    CCLOG(@"KEY dealloc CALLED");
    [super dealloc];
}

// This method is called when this class/node is added to the parent node (gameplayLayer).

#pragma mark On Enter & On Exit
- (void)onEnter
{
    CCLOG(@"KEY onEnter CALLED");
    // Add this object to the touch dispatcher. 
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    // Trapping a system call and passing it on.
    [super onEnter];
}

// This method is called when this class/node is removed from the parent node (gameplayLayer).

- (void)onExit
{
    CCLOG(@"KEY onExit CALLED");
    // Remove this object from the touch dispatcher.
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}



// This method creates a rectangle from the key sprites texture rectangle.
// Then a check is performed to see if this rectangle contains a
// point where the user touched.

#pragma mark Targeted Touch Delegate Protocol Methods
-(BOOL)containsTouch:(UITouch *)touch
{
    CCLOG(@"KEY containsTouch CALLED");
    // Create a rectangle around the key sprites texture rectangle.
    CGRect r = [keySprite textureRect];
    // Converting the touch to local space co-ordinates.
    CGPoint p = [keySprite convertTouchToNodeSpace:touch];
    // If yes return yes, otherwise no.
    return CGRectContainsPoint(r, p );
}

// This method claims the UITouch, from the user if this object was touched.
// This method must be overridden and return a boolean
// value to claim the touch.

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    // Calling the above method to see if our key sprite was touched.
    if (![self containsTouch:touch]) return NO;
    CCLOG(@"KEY ccTouchBegan CALLED");
   
    // Tell the gamePlaylayer that this object was touched.
    // Pass a string to identify that this object was touched to the
    // gameplayLayers itemToPickUpTouched method.
    [gameplayLayer itemToPickUpTouched:kRemoveObjectTypeKey];
    
    // Return yes to claim the touch.
    return YES;
}
@end
