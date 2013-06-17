//
//  InventoryKeyIcon.m
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
// touch events. The class itself contains a sprite, made from an image of a key. This object is an inventory item
// icon. It will be added to teh Inventory Menu. If this object is touched it will send a message to the
// InventoryMenu informing it that this object has been touched.
//
// The touch handling technuiques in this class were learned, taken and adpated from the tutorial below
// by Bob Euland:
//
// http://bobueland.com/cocos2d/2011/touchdispatcher-secrets/
//
// PLEASE NOTE: RATHER THAN REPEAT THE SAME COMMENTS FOR THE INVENTORY KEY & INVENTORY RECEIPT
//
// PLEASE GO TO: Classes/Game Objects/Level Icons/Key.h and Key.m
//
// FOR DETAILED DESCRIPTION OF WHAT IS GOING ON IN A TOUCHABLE OBJECT
//

#import "InventoryKeyIcon.h"
#import "InventoryMenu.h"

@implementation InventoryKeyIcon
@synthesize keyIconSprite, inventoryMenuLayer;

-(id)initWithLayer:(InventoryMenu *)layer
{
    self = [super init];
    CCLOG(@"KEY RECEIPT ICON INITIATED");
    if (self)
    {
        self.inventoryMenuLayer=layer;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.keyIconSprite = [CCSprite spriteWithFile:@"inventory_key_icon-ipadhd.png"];
        }
        else
        {
            self.keyIconSprite = [CCSprite spriteWithFile:@"inventory_key_icon-widehd.png"];
        }
        
        [self addChild:keyIconSprite];
    }
    return self;
}

-(float)returnObjectHeight
{
    CCLOG(@"KEY RECEIPT returnHalfCharacterWidth CALLED");
    float objectSize = keyIconSprite.contentSize.height;
    CCLOG(@"Key height is: %f", objectSize);
    return objectSize;
}

-(float)returnobjectWidth
{
    CCLOG(@"KEY RECEIPT returnHalfCharacterWidth CALLED");
    float objectSize = keyIconSprite.contentSize.width;
    CCLOG(@"Receipt height is: %f", objectSize);
    return objectSize;
}

- (void)dealloc
{
    CCLOG(@"KEY RECEIPT dealloc CALLED");
    [super dealloc];
}

//onEnter
- (void)onEnter
{
    CCLOG(@"KEY RECEIPT onEnter CALLED");
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [super onEnter];
}

//onExit
- (void)onExit
{
    CCLOG(@"KEY RECEIPT onExit CALLED");
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}

-(BOOL)containsTouch:(UITouch *)touch
{
    CCLOG(@"KEY RECEIPT containsTouch CALLED");
    CGRect r = [keyIconSprite textureRect];
    CGPoint p = [keyIconSprite convertTouchToNodeSpace:touch];
    return CGRectContainsPoint(r, p );
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (![self containsTouch:touch]) return NO;
    CCLOG(@"KEY RECEIPT ccTouchBegan CALLED");
    
    [inventoryMenuLayer describeItem:aLevelGameplayKeyInvDescript];
    
    return YES;
}
@end
