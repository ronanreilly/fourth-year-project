//
//  TouchPicture.m
//  game2
//
//  Created by Ronan Sean on 17/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
// Class Description Below:
//
// This class is a composite object. It is added to the LevelGameplay layer as a child and has a sprite added to
// itself.
//
// This class is a subclass of CCNode and conforms to the CCTouchOneByOneDelegate in order for it to handle
// touch events. The class itself contains a sprite, made from an image that has a low opacity. This object is
// added to the main gameplaylayer. If this object is touched it will send a message to the gameplay layer
// informing it that this object has been touched.
//
// This object is transparent, it is placed in the gameplayLayer in order for the user to appear as thought they
// are actually touching an object in the background.
//
// The touch handling technuiques in this class were learned, taken and adpated from the tutorial below
// by Bob Euland:
//
// http://bobueland.com/cocos2d/2011/touchdispatcher-secrets/
//
// PLEASE NOTE: RATHER THAN REPEAT THE SAME COMMENTS FOR THE KEY, RECEIPT, TOUCHDOOR & TOUCH PICTURE CLASSES
//
// PLEASE GO TO: Classes/Game Objects/Level Icons/Key.h and Key.m
//
// FOR DETAILED DESCRIPTION OF WHAT IS GOING ON IN A TOUCHABLE OBJECT

#import "TouchPicture.h"
#import "LevelGameplay.h"

@implementation TouchPicture

@synthesize pictureTouchArea, gameplayLayer;

-(id)initWithLayer:(LevelGameplay *)layer
{
    self = [super init];
    CCLOG(@"TouchPicture INITIATED");
    if (self)
    {
        self.gameplayLayer=layer;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.pictureTouchArea = [CCSprite spriteWithFile:@"invis_picture-ipadhd.png"];
        }

        else
        {
            self.pictureTouchArea = [CCSprite spriteWithFile:@"invis_picture-widehd.png"];
        }
        
        [self addChild:pictureTouchArea z:0];
    }
    return self;
}

-(float)returnObjectHeight
{
    CCLOG(@"door returnHalfCharacterWidth CALLED");
    float objectSize = pictureTouchArea.contentSize.height;
    CCLOG(@"picture touch area height is: %f", objectSize);
    return objectSize;
}

- (void)dealloc
{
    CCLOG(@"TouchPicture dealloc CALLED");
    [super dealloc];
}

//onEnter
- (void)onEnter
{
    CCLOG(@"TouchPicture onEnter CALLED");
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [super onEnter];
}

//onExit
- (void)onExit
{
    CCLOG(@"TouchPicture onExit CALLED");
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}

-(BOOL)containsTouch:(UITouch *)touch
{
    CCLOG(@"TouchPicture containsTouch CALLED");
    CGRect r = [pictureTouchArea textureRect];
    CGPoint p = [pictureTouchArea convertTouchToNodeSpace:touch];
    return CGRectContainsPoint(r, p );
}


-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (![self containsTouch:touch]) return NO;
    CCLOG(@"TouchPicture ccTouchBegan CALLED");
    [gameplayLayer stopAllSounds];
    [gameplayLayer playSound:aLevelGameplayPictureDescript];
    
    return YES;
}
@end
