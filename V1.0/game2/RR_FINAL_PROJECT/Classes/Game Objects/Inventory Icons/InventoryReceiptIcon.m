//
//  InventoryReceiptIcon.m
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
// This class is a subclass of CCNode and conforms to the CCTouchOneByOneDelegate in order for it to handle
// touch events. The class itself contains a sprite, made from an image of a receipt. This object is an inventory
// item icon. It will be added to teh Inventory Menu. If this object is touched it will send a message to the
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

#import "InventoryReceiptIcon.h"
#import "InventoryMenu.h"

@implementation InventoryReceiptIcon
@synthesize receiptIconSprite, inventoryMenuLayer;

-(id)initWithLayer:(InventoryMenu *)layer
{
    self = [super init];
    CCLOG(@"INVENTORY RECEIPT ICON INITIATED");
    if (self)
    {
        self.inventoryMenuLayer=layer;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.receiptIconSprite = [CCSprite spriteWithFile:@"inventory_receipt_icon-ipadhd.png"];

        }
        else
        {
            self.receiptIconSprite = [CCSprite spriteWithFile:@"inventory_receipt_icon-widehd.png"];
        }
        
        [self addChild:receiptIconSprite z:0];
    }
    return self;
}

-(float)returnObjectHeight
{
    CCLOG(@"INVENTORY RECEIPT returnHalfCharacterWidth CALLED");
    float objectSize = receiptIconSprite.contentSize.height;
    CCLOG(@"Receipt height is: %f", objectSize);
    return objectSize;
}

-(float)returnobjectWidth
{
    CCLOG(@"INVENTORY RECEIPT returnHalfCharacterWidth CALLED");
    float objectSize = receiptIconSprite.contentSize.width;
    CCLOG(@"Receipt height is: %f", objectSize);
    return objectSize;
}

- (void)dealloc
{
    CCLOG(@"INVENTORY RECEIPT dealloc CALLED");
    [super dealloc];
}

//onEnter
- (void)onEnter
{
    CCLOG(@"INVENTORY RECEIPT onEnter CALLED");
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [super onEnter];
}

//onExit
- (void)onExit
{
    CCLOG(@"INVENTORY RECEIPT onExit CALLED");
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}

-(BOOL)containsTouch:(UITouch *)touch
{
    CCLOG(@"INVENTORY RECEIPT containsTouch CALLED");
    CGRect r = [receiptIconSprite textureRect];
    CGPoint p = [receiptIconSprite convertTouchToNodeSpace:touch];
    return CGRectContainsPoint(r, p );
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (![self containsTouch:touch]) return NO;
    CCLOG(@"INVENTORY RECEIPT ccTouchBegan CALLED");
    [inventoryMenuLayer describeItem:aLevelGameplayReceiptInvDescript];
    
    return YES;
}
@end
