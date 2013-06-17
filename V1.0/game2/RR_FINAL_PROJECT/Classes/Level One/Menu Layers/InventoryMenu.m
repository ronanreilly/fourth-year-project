//
//  InventoryMenu.m
//  game2
//
//  Created by Ronan Sean on 14/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
// CLASS DESCRIPT NEEDED

#import "InventoryMenu.h"
#import "InventoryReceiptIcon.h"
#import "InventoryKeyIcon.h"
#import "LevelGameplay.h"

@implementation InventoryMenu

@synthesize gameplayLayer;

-(void)dealloc
{
    [super dealloc];
    [receiptIcon dealloc];
    [keyIcon dealloc];
}

#pragma mark Move Key If Added
-(void)moveKey{
    CCLOG(@"MOVE KEY");
    keyIcon.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
}

// This method is responsible for setting the game state when an inventory item is picked up.
// There are three tasks that must be completed before the game can be completed. One taks is
// picking up the key and another is picking up the receipt.

#pragma mark Game State Setter
-(void)setGameState
{
    CCLOG(@"INVENTORY MENU LAYER setGameState CALLED");
    
    // If only the receipt is added when this method is called.
    // Pass a pre-defined string to the level one gameplay layers
    // set game state method. Receipt is task one.
    if (receiptIsAdded & !keyIsAdded)
    {
        [gameplayLayer setGameState:kTaskOne];
    }
    // Pass a pre-defined string to the level one gameplay layers
    // set game state method. Key is task one.
    if (keyIsAdded & !receiptIsAdded)
    {
        [gameplayLayer setGameState:KTaskTwo];
    }
    // If one item is already added when this method is called,
    // set both tasks to be done. One is already set so setting it again
    // wiil not cause any harm.
    if (receiptIsAdded && keyIsAdded)
    {
        [gameplayLayer setGameState:kTaskOne];
        [gameplayLayer setGameState:KTaskTwo];
        
        // With both task one and two completed, initiate the final part of the game. Call the method that will see the
        // ORourke character enter.
        [gameplayLayer performSelector:@selector(enterOrExitOrourke) withObject:nil afterDelay:8.0];
    }
    
}

// When the user touches an inventory item this method is called. It is passed a string from
// the constants file that is used to define a sound in the resources folder. Depending on
// what object is touched this method will pass take the string passed to it and pass it to the
// level one gameplay layers play sound method. This will play an audio description of the inventory
// object touched.

#pragma mark Give Audio Description
-(void)describeItem:(NSString *)itemToBeDescribed
{
    CCLOG(@"INVENTORY MENU LAYER describeItem CALLED");
    // Take the string passed to this method and pass it to the gameplay layers
    // play sound method. Plays an audio description of inventory item touched.
    [gameplayLayer playSound:itemToBeDescribed];
}

// This method is called from the level one gameplay layers removeItemAndAddToIventory method.
// It is passed a pre-defined string from the constants class used to identify what item needs to be added
// to the inventory. The method performs a check on the string passed to determine what item should be added
// to the inventory.

#pragma mark Add Item To Inventory
-(void)AddItem:(NSString *)itemToAddToInventory
{
    CCLOG(@"INVENTORY MENU LAYER AddItem CALLED");
    // Is the string passed used to identify that the receipt object is to be added.
    if ([itemToAddToInventory isEqual: kRemoveObjectTypeReceipt])
    {
        // Add the receipt icon to the inventoryItemsContainer array.
        [inventoryItemsContainer addObject:receiptIcon];
        CCLOG(@"ADDING THE %@ to the inventory", kRemoveObjectTypeReceipt);
        // Set this so it can be used to check if the receipt has been added.
        receiptIsAdded = YES;
        // Task one is adding the receipt to inventory, set the game state.
        [self setGameState];
    }
    
    // Is the string passed used to identify that the key object is to be added.
    else if ([itemToAddToInventory isEqual: kRemoveObjectTypeKey])
    {
        // Add the key icon to the inventoryItemsContainer array.
        [inventoryItemsContainer addObject:keyIcon];
        CCLOG(@"ADDING THE %@ to the inventory", kRemoveObjectTypeKey);
        // Set this so it can be used to check if the key has been added.
        keyIsAdded = YES;
        // Task two is adding the key to inventory, set the game state.
        [self setGameState];
    }
}

// This method is called from the level gameplay layer when the user selects the inventory icon.
// This method performs a check to see if the menu if visible or not. If it is not visible when
// caught it must perform a series of checks to see what is in the inventory and what is not.
// The result of these checks will decided what is to be displayed in the inventroy and what is not.
// If the menu is visible when this method is called it scatters all of the menu items off of the screen.

#pragma mark Show Or Hide Menu
-(void)addOrRemoveThisMenu
{
    CCLOG(@"INVENTORY MENU LAYER addOrRemoveThisMenu CALLED");
    // If the menu is not on screen already.
    if (thisMenuIsVisible == NO)
    {
        // Application running on iPad -- Position inventory for iPad.
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {   // If the inventory array is empty.
            if (!inventoryItemsContainer.count)
            {
                // Show the inventory is empty label.
                CCLOG(@"INVENTORY EMPTY");
                emptyInventoryLabel.position = ccp((screenSize.width/2), (screenSize.height/2) + (250));
            } 
            else
            {
                // CHECK ONE
                // Is the receipt added to inventory but not the key.
                if (receiptIsAdded && !keyIsAdded)
                {
                    // Position the receipt first in the inventory menu.
                    receiptIcon.position = ccp((halfScreenWidth) - (90), (halfScreenHeight) + (240));
                }
                // CHECK TWO
                // Is the key added to inventory but not the receipt.
                else if (keyIsAdded && !receiptIsAdded)
                {
                    // Position the key first in the inventory menu.
                    keyIcon.position = ccp((halfScreenWidth) - (90), (halfScreenHeight) + (240));
                }
                // CHECK THREE
                // Is the receipt and key added.
                else if(receiptIsAdded && keyIsAdded)
                {
                    // Position the receipt first and the key second in the inventory menu.
                    receiptIcon.position = ccp((halfScreenWidth) - (90), (halfScreenHeight) + (240));
                    keyIcon.position = ccp((halfScreenWidth) + (90), (halfScreenHeight) + (240));
                }
            }
            menuBack.position = ccp((halfScreenWidth), (halfScreenHeight) + (240));
            }
            // Application running on iPhone -- Position inventory for iPhone.
            // Code below does the same as the code above lines 92 to 124.
            // No need to repeat the description.
            else
            {
                if (!inventoryItemsContainer.count)
                {
                    CCLOG(@"INVENTORY EMPTY");
                    emptyInventoryLabel.position = ccp((halfScreenWidth), (halfScreenHeight) + (100));
                }
                else
                {
                    if (receiptIsAdded && !keyIsAdded)
                    {
                        receiptIcon.position = ccp((halfScreenWidth) - (50), (halfScreenHeight) + (100));
                    }
                    else if (keyIsAdded && !receiptIsAdded)
                    {
                        keyIcon.position = ccp((halfScreenWidth) - (50), (halfScreenHeight) + (100));
                    }
                    else if(receiptIsAdded && keyIsAdded)
                    {
                        receiptIcon.position = ccp((halfScreenWidth) - (50), (halfScreenHeight) + (100));
                        keyIcon.position = ccp((halfScreenWidth) + (50), (halfScreenHeight) + (100));
                        
                    }
            }
            menuBack.position = ccp((halfScreenWidth), (halfScreenHeight) + (100));
        }
        // Set this to true so next time this method is called it will know it has to be removed
        // and not shown.
        thisMenuIsVisible = YES;
    }
    // If the menu is already visible when this method is called, scatter all of its elements
    // off of the screen.
    else
    {
        menuBack.position = ccp((screenSize.width) * (2), (screenSize.height) * (2));
        emptyInventoryLabel.position = ccp((screenSize.width) * (2), (screenSize.height) * (2));
        receiptIcon.position = ccp((screenSize.width) * (2), (screenSize.height) * (2));
        keyIcon.position = ccp((screenSize.width) * (2), (screenSize.height) * (2));
        // Set this to false so next time this method is called it will know it has to be shown
        // and not removed.
        thisMenuIsVisible = NO;
    }
}



// Handles the initialistaion of graphical assets fot the invnetory menu.

#pragma mark General Initialisation
-(id)initWithLayer:(LevelGameplay *)layer
{
    CCLOG(@"INVENTORY MENU LAYER INITIATED");
    self = [super init];
    if (self != nil)
    {
        // Get the screen size of the device the application is running on.
        // used for positioning.
        screenSize = [CCDirector sharedDirector].winSize;
        halfScreenWidth = screenSize.width/2;
        halfScreenHeight = screenSize.height/2;
        
        // Keeps track of the menu.
        thisMenuIsVisible = NO;
        
        // This class is initialised with a layer, assign it here.
        self.gameplayLayer=layer;
        
        // Application running on iPad?
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            // Create the label and image for the back of the menu.
            menuBack = [CCSprite spriteWithFile:@"inventory_menu_background-ipadhd.png"];
            emptyInventoryLabel = [CCLabelTTF labelWithString:@"Inventory Empty..." fontName:@"Marker Felt" fontSize:38];
        }
        // Or application running on iPhone?
        else
        {
            menuBack = [CCSprite spriteWithFile:@"inventory_menu_background-widehd.png"];
            emptyInventoryLabel = [CCLabelTTF labelWithString:@"Inventory Empty..." fontName:@"Marker Felt" fontSize:17];
        }
        
        // Initialise the booleans for keeping track of wheter
        // receipt is added or not to false, because its not added from
        // initialisation.
        receiptIsAdded = NO;
        keyIsAdded = NO;
        
        // Create the array to hold items added to the inventory. 
        inventoryItemsContainer = [[NSMutableArray alloc] init];
        
        // Creat instances of the inventory and receipt and key objects.
        receiptIcon = [[InventoryReceiptIcon alloc] initWithLayer:self];
        keyIcon = [[InventoryKeyIcon alloc] initWithLayer:self];
       
        // Position the menu back, empty label, receipt and key objecst of the screen. 
        menuBack.position = ccp((screenSize.width) * (2), (screenSize.height) * (2));
        receiptIcon.position = ccp((screenSize.width) * (2), (screenSize.height) * (2));
        keyIcon.position = ccp((screenSize.width) * (2), (screenSize.height) * (2));
        emptyInventoryLabel.position = ccp((screenSize.width) * (3), (screenSize.height) * (3));
        
        // Add all of these objects to thhis layer as children.
        [self addChild:receiptIcon z:kAllInGameMenuItemZValues tag:20];
        [self addChild:menuBack z:0];
        [self addChild:emptyInventoryLabel z:15];
        [self addChild:keyIcon z:15];
    }
    return self;
}

@end
