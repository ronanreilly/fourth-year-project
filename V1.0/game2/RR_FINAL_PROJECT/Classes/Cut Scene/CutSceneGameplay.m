//
//  CutSceneGameplay.m
//  game2
//
//  Created by Ronan Sean on 13/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
// Class Description Below:
//
// This class is a CCLayer. It sets up and initiates the animation, the menu to skip the animation and its button
// and handles the touch for this menu. It extends the CocosDenhison CDLongAudioSourceDelegate for playing
// background music and uses the CocosDenhison SimpleAudioEngine for preloading and playing audio effects for the
// menu buttons.
//

// The animation technuiques in this class were learned, taken and adpated from two tutorials
// by Bob Euland:
//
//
// http://bobueland.com/cocos2d/2011/how-to-make-an-animation/
// http://bobueland.com/cocos2d/2011/how-to-optimize-an-animation/
//
//


#import "CutSceneGameplay.h"
#import "LevelScene.h"

@implementation CutSceneGameplay
@synthesize iPadAnim,cutSceneAnimObject;

#pragma Tutorial Manager
-(void)tutorialManagerPrev
{
    [self stopAllActions];
    [keyIcon stopAllActions];
    [handIcon stopAllActions];
    [[CDAudioManager sharedManager] stopBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] playEffect:aButtonOneSound];
    iPadAnimAction = nil;
    cutSceneAnimObject = nil;
    cutSceneActionObject = nil;
    [originalFrame stopAllActions];
    
    originalFrame.position = ccp(screenSize.width * (3), screenSize.height * (3));
    cutSceneMenu.position = ccp(screenSize.width * (3), screenSize.height * (3));
    timerBarBottom.position = ccp(screenSize.width * (3), screenSize.height * (3));
    timerBarTop.position = ccp(screenSize.width * (3), screenSize.height * (3));
    
    [self unschedule:@selector(incTime)];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        tutMenu.position = ccp(0, 0);
        tutMenuBack.position = ccp(halfScreenWidth, halfScreenHeight - 320);
        tutStartGameIcon.position = ccp(halfScreenWidth, halfScreenHeight -320);
        tutNextIcon.position = ccp(halfScreenWidth + (100), halfScreenHeight -320);
        tutPrevIcon.position = ccp(halfScreenWidth - (100), halfScreenHeight -320);
    }
    else
    {
        tutMenu.position = ccp(0, 0);
        tutMenuBack.position = ccp(halfScreenWidth, halfScreenHeight - (130));
        tutStartGameIcon.position = ccp(halfScreenWidth, halfScreenHeight - (130));
        tutNextIcon.position = ccp(halfScreenWidth + (80), halfScreenHeight - (130));
        tutPrevIcon.position = ccp(halfScreenWidth - (80), halfScreenHeight - (130));
        
    }
    if (currentTutorialFrame == 1)
    {
        [keyIcon stopAllActions];
        [handIcon stopAllActions];
        handIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        keyIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage1.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage7.position = ccp(halfScreenWidth, halfScreenHeight);
        currentTutorialFrame = 7;
        CCLOG(@"currentTutorialFrame is NOW: %i", currentTutorialFrame);
    }
    else if (currentTutorialFrame == 2)
    {
        [keyIcon stopAllActions];
        [handIcon stopAllActions];
        handIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        keyIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage2.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage1.position = ccp(halfScreenWidth, halfScreenHeight);
        currentTutorialFrame--;
        CCLOG(@"currentTutorialFrame is NOW: %i", currentTutorialFrame);
    }
    else if (currentTutorialFrame == 3)
    {
        [keyIcon stopAllActions];
        [handIcon stopAllActions];
        handIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        keyIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage3.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage2.position = ccp(halfScreenWidth, halfScreenHeight);
        currentTutorialFrame--;
        CCLOG(@"currentTutorialFrame is NOW: %i", currentTutorialFrame);
    }
    else if (currentTutorialFrame == 4)
    {
        [keyIcon stopAllActions];
        [handIcon stopAllActions];
        handIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        keyIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage4.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage3.position = ccp(halfScreenWidth, halfScreenHeight);
        currentTutorialFrame--;
        CCLOG(@"currentTutorialFrame is NOW: %i", currentTutorialFrame);
    }
    else if (currentTutorialFrame == 5)
    {
        [keyIcon stopAllActions];
        [handIcon stopAllActions];
        handIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        keyIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage5.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage4.position = ccp(halfScreenWidth, halfScreenHeight);
        currentTutorialFrame--;
        CCLOG(@"currentTutorialFrame is NOW: %i", currentTutorialFrame);
    }
    else if (currentTutorialFrame == 6)
    {
        [keyIcon stopAllActions];
        [handIcon stopAllActions];
        handIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        keyIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage6.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage5.position = ccp(halfScreenWidth, halfScreenHeight);
        currentTutorialFrame--;
        CCLOG(@"currentTutorialFrame is NOW: %i", currentTutorialFrame);
    }
    else if (currentTutorialFrame == 7)
    {
        tutImage7.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage6.position = ccp(halfScreenWidth, halfScreenHeight);
      
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            handIcon.position = ccp(halfScreenWidth + 80, halfScreenHeight + 170);
            //[handIcon runAction:[CCMoveTo actionWithDuration:2.0 position:ccp(halfScreenWidth + 380, halfScreenHeight - 40)]];
            keyIcon.position = ccp(halfScreenWidth + 100, halfScreenHeight + 230);
            //[keyIcon runAction:[CCMoveTo actionWithDuration:2.0 position:ccp(halfScreenWidth + 380, halfScreenHeight - 40)]];
        }
        else
        {
            handIcon.position = ccp(halfScreenWidth + 40, halfScreenHeight + 70);
            //[handIcon runAction:[CCMoveTo actionWithDuration:1.0 position:ccp(halfScreenWidth + 190, halfScreenHeight - 20)]];
            keyIcon.position = ccp(halfScreenWidth + 70, halfScreenHeight + 100);
            //[keyIcon runAction:[CCMoveTo actionWithDuration:1.0 position:ccp(halfScreenWidth + 190, halfScreenHeight - 20)]];
        }
        currentTutorialFrame = 6;
        CCLOG(@"currentTutorialFrame is NOW: %i", currentTutorialFrame);
        
    }
    
    //CCLOG(@"currentTutorialFrame is NOW: %i", currentTutorialFrame);
}

#pragma Tutorial Manager
-(void)tutorialManagerNext
{
    [self stopAllActions];
    [[CDAudioManager sharedManager] stopBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] playEffect:aButtonOneSound];
    iPadAnimAction = nil;
    cutSceneAnimObject = nil;
    cutSceneActionObject = nil;
    [originalFrame stopAllActions];
    
    originalFrame.position = ccp(screenSize.width * (3), screenSize.height * (3));
    cutSceneMenu.position = ccp(screenSize.width * (3), screenSize.height * (3));
    timerBarBottom.position = ccp(screenSize.width * (3), screenSize.height * (3));
    timerBarTop.position = ccp(screenSize.width * (3), screenSize.height * (3));
   
    [self unschedule:@selector(incTime)];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        handIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutMenu.position = ccp(0, 0);
        tutMenuBack.position = ccp(halfScreenWidth, halfScreenHeight - (320));
        tutStartGameIcon.position = ccp(halfScreenWidth, halfScreenHeight - (320));
        tutNextIcon.position = ccp(halfScreenWidth + (100), halfScreenHeight - (320));
        tutPrevIcon.position = ccp(halfScreenWidth - (100), halfScreenHeight - (320));
        xIcon.position = ccp(halfScreenWidth + (380), halfScreenHeight + (275));
    }
    else
    {
        tutMenu.position = ccp(0, 0);
        tutMenuBack.position = ccp(halfScreenWidth, halfScreenHeight - (130));
        tutStartGameIcon.position = ccp(halfScreenWidth, halfScreenHeight - (130));
        tutNextIcon.position = ccp(halfScreenWidth + (80), halfScreenHeight - (130));
        tutPrevIcon.position = ccp(halfScreenWidth - (80), halfScreenHeight - (130));
        xIcon.position = ccp(halfScreenWidth + (210), halfScreenHeight + (110));
    }
    if (currentTutorialFrame == 1)
    {
        handIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        keyIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage7.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage1.position = ccp(halfScreenWidth, halfScreenHeight);
        currentTutorialFrame++;
    }
    else if (currentTutorialFrame == 2)
    {
        handIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        keyIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage1.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage2.position = ccp(halfScreenWidth, halfScreenHeight);
        currentTutorialFrame++;
    }
    else if (currentTutorialFrame == 3)
    {
        handIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        keyIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage2.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage3.position = ccp(halfScreenWidth, halfScreenHeight);
        currentTutorialFrame++;
    }
    else if (currentTutorialFrame == 4)
    {
        handIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        keyIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage3.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage4.position = ccp(halfScreenWidth, halfScreenHeight);
        currentTutorialFrame++;
    }
    else if (currentTutorialFrame == 5)
    {
        handIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        keyIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage4.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage5.position = ccp(halfScreenWidth, halfScreenHeight);
        currentTutorialFrame++;
    }
    else if (currentTutorialFrame == 6)
    {
        handIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        keyIcon.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage5.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage6.position = ccp(halfScreenWidth, halfScreenHeight);
        currentTutorialFrame++;
    }
    else if (currentTutorialFrame == 7)
    {
        tutImage6.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage7.position = ccp(halfScreenWidth, halfScreenHeight);
        currentTutorialFrame = currentTutorialFrame -6;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            handIcon.position = ccp(halfScreenWidth + 80, halfScreenHeight + 170);
            //[handIcon runAction:[CCMoveTo actionWithDuration:2.0 position:ccp(halfScreenWidth + 380, halfScreenHeight - 40)]];
            keyIcon.position = ccp(halfScreenWidth + 100, halfScreenHeight + 230);
            //[keyIcon runAction:[CCMoveTo actionWithDuration:2.0 position:ccp(halfScreenWidth + 380, halfScreenHeight - 40)]];
        }
        else
        {
            handIcon.position = ccp(halfScreenWidth + 40, halfScreenHeight + 70);
            //[handIcon runAction:[CCMoveTo actionWithDuration:1.0 position:ccp(halfScreenWidth + 190, halfScreenHeight - 20)]];
            keyIcon.position = ccp(halfScreenWidth + 70, halfScreenHeight + 100);
            //[keyIcon runAction:[CCMoveTo actionWithDuration:1.0 position:ccp(halfScreenWidth + 190, halfScreenHeight - 20)]];
        }
    }
    
    CCLOG(@"currentTutorialFrame is NOW: %i", currentTutorialFrame);
}


// This method is called every 7 seconds once the loadResources method has executed.
// It will be called on this schedule until the time counter variable is
// equal to or greater than 1.0. It scales the progress bar by 0.46 each time
// it is called.

#pragma Increment Time For the Loader Bar
-(void)incTime
{
    // While counter is leass than 1.0
    if (timeCounter < 0.96)
    {
        // Add 0.05 to the timeCounter
        // and scale the top progress bar by that amount.
        timeCounter=timeCounter + 0.045;
        timerBarTop.scaleX=timeCounter;
    }
    else
    {
        // When timeCounter is 1.0 or more the progress bar is fully loaded.
        // So play a preloaded sound effect and unschedue the calling of this method.
        [[SimpleAudioEngine sharedEngine] playEffect:aCutSceneEnd];
        [self unschedule:@selector(incTime)];
    }
}

// This method is called from the init method. It is responsible for loading the two images
// for the progress bar. One iamge sits on top of the other.

#pragma Load Progress Bar Resources
-(void)loadResources
{
    // Checking if the app is running on iPad or iPhone.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // Creating the progress bar images.
        timerBarBottom = [CCSprite spriteWithFile:@"cutscene_timer_bottom-ipadhd.png"];
        timerBarTop = [CCSprite spriteWithFile:@"cutscene_timer_top-ipadhd.png"];
        
        // Setting the anchor points.
        timerBarTop.anchorPoint = ccp(0, 0.5);
        timerBarBottom.anchorPoint = ccp(0, 0.5);
        
        // Positioning the two progress bar images.
        timerBarBottom.position = ccp(12.0, 110);
        timerBarTop.position = ccp(12.0, 110);
        
        // Scaling the top image to the value of the timerCounter which is
        // 0.0 as set in init. 
        timerBarTop.scaleX = timeCounter;
        
        // Adding the progress bar images to the layer, with z values
        // defined in Constants.h.
        [self addChild:timerBarBottom z:kCutSceneTimerBarBottomZValue];
        [self addChild:timerBarTop z:kCutSceneTimerBarTopZValue];
        
        // This line schedules to call the incTime every 7 seconds.
        // So as to aline with the transistion of each image in the animation.
        [self schedule:@selector(incTime) interval:7.0];
    }
    else
    {
        // SEE ABOVE FOR DESCRIPTION OF WHAT IS HAPPENING
        
        timerBarBottom = [CCSprite spriteWithFile:@"cutscene_timer_top-widehd.png"];
        timerBarTop = [CCSprite spriteWithFile:@"cutscene_timer_bottom-widehd.png"];
        timerBarTop.anchorPoint = ccp(0, 0.5);
        timerBarBottom.anchorPoint = ccp(0, 0.5);
        timerBarBottom.position = ccp(12.0, 50);
        timerBarTop.position = ccp(12.0, 50);
        
        timerBarTop.scaleX = timeCounter;
        
        [self addChild:timerBarBottom z:kCutSceneTimerBarBottomZValue];
        [self addChild:timerBarTop z:kCutSceneTimerBarTopZValue];
        
        [self schedule:@selector(incTime) interval:7.0];
    }
}

#pragma Back To Tutorial
-(void)backToCutScene
{
    CCLOG(@"BACK TO TUT");
    [self stopAllActions];
    currentTutorialFrame = 1;
    timeCounter = 0.0;
    [[SimpleAudioEngine sharedEngine] playEffect:aButtonOneSound];

    tutImage1.position = ccp(screenSize.width * 3, screenSize.height * 3);
    tutImage2.position = ccp(screenSize.width * 3, screenSize.height * 3);
    tutImage3.position = ccp(screenSize.width * 3, screenSize.height * 3);
    tutImage4.position = ccp(screenSize.width * 3, screenSize.height * 3);
    tutImage5.position = ccp(screenSize.width * 3, screenSize.height * 3);
    tutImage6.position = ccp(screenSize.width * 3, screenSize.height * 3);
    tutImage7.position = ccp(screenSize.width * 3, screenSize.height * 3);
    tutMenu.position = ccp(screenSize.width * 3, screenSize.height * 3);
    tutMenuBack.position = ccp(screenSize.width * 3, screenSize.height * 3);

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // Positioning the original frame on the screen.
        originalFrame.position = ccp(halfScreenWidth, halfScreenHeight);
        // Positioning the menu icons on the screen.
        cutSceneMenu.position = ccp(0,0);
        // Positioning the menu icon on the screen.
        startGameIcon.position = ccp((halfScreenWidth) + (350), (screenSize.height) - (575));
        // Positioning the menu icon on the screen.
        startTutorialIcon.position = ccp((halfScreenWidth) + (140), (screenSize.height) - (575));
        [self loadResources];
        [self startCutSceneAnim];

    }
    else
    {
        // Positioning the original frame on the screen.
        originalFrame.position = ccp(halfScreenWidth, halfScreenHeight);
        // Positioning the menu icons on the screen.
        cutSceneMenu.position = ccp(0,0);
        startGameIcon.position = ccp((screenSize.width) - (90), (halfScreenHeight) - (70));
        startTutorialIcon.position = ccp((screenSize.width) - (220), halfScreenHeight - (70));
        [self loadResources];
        [self startCutSceneAnim];
  
    }
}

// This method is called from the init method. It is responsible for setting up the main animation
// frames in the animation object and running the animation.

#pragma Start Cut Scene Animation 
-(void)startCutSceneAnim
{
    CCLOG(@"CUT SCENE GAMEPLAY startCutSceneAnim CALLED");
    
    // The audion for the cutscene is played here.
    // Passed a string defined in Constants.h.
    [[CDAudioManager sharedManager] playBackgroundMusic:aCutSceneOnLoad loop:NO];
    
    // Checking if the app is running on iPad or iPhone.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // IPAD ANIMATION SET UP.
        
        // Intiating the iPadAnim object.
        iPadAnim = [CCAnimation animation];
        
        // Manually adding images form teh resources folder to the iPad animation object
        // as sprite frames.
        
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_1-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_2-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_3-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_4-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_5-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_6-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_7-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_8-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_9-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_10-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_11-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_12-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_13-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_14-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_15-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_16-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_17-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_18-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_19-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_20-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_21-ipadhd.png"];
        [iPadAnim addSpriteFrameWithFilename:@"cutscene_image_22-ipadhd.png"];
        

        iPadAnimAction = [CCAnimate actionWithDuration:154.0f animation:iPadAnim restoreOriginalFrame:YES];
        
        [originalFrame runAction:iPadAnimAction];
    }
    else
    {
        // IPHONE ANIMATION SET UP.
        
        // This array will hold all of the frames for the animation.
        NSMutableArray *cutSceneFrames = [NSMutableArray array];
        
        // This loop will count to 22. At each increment a place holder is incremented to the value of i.
        for (int i = 1; i < 23; i++)
        {
            // This string holds the current frame where i is incremented at the placeholder.
            NSString *currentFrameName = [NSString stringWithFormat:@"cutscene_image_%d.png", i];
            // The string from above is added to the frames cache as a frame object.
            id frameObject = [mainAnimFramesCache spriteFrameByName:currentFrameName];
            // Frame object created above is added to the cutSceneFrames array. 
            [cutSceneFrames addObject:frameObject];
        }
    
        // Extra frame is added manually.
        NSString *currentFrameName = [NSString stringWithFormat:@"cutscene_image_22.png"];
        id frameObject = [mainAnimFramesCache spriteFrameByName:currentFrameName];
        [cutSceneFrames addObject:frameObject];
    
        // Animation object is created and a delay between each tween is given of 7 seconds.
        cutSceneAnimObject = [CCAnimation animationWithSpriteFrames:cutSceneFrames delay:7.0];
    
        // Animation action is passed the animation object created above.
        cutSceneActionObject = [CCAnimate actionWithAnimation:cutSceneAnimObject];
    
        // Animation action created above in run on the original frame.
        [originalFrame runAction:cutSceneActionObject];
    }
}

// This method is called when the user hits the skip/startgame icon.
// It first stops the background music from playing, plays the sound effect for the button
// and then pushes the cut level scene on to the top of the stack.

#pragma Start Game
-(void)startGame
{
    CCLOG(@"CUT SCENE GAMEPLAY startGame CALLED");
    [[CDAudioManager sharedManager] stopBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] playEffect:aButtonOneSound];
    [[CCDirector sharedDirector] pushScene:[LevelScene node]];
}


// This method handles the intialisation of resources and instance variables for this layer
// depending on wheter the application is running on iPad or iPhone.

#pragma Cut Scene Intialisation
-(id)init
{
    CCLOG(@"CUT SCENE GAMEPLAY LAYER INITIATED");
    // Initialising the super object, CCLayer.
    self = [super init];
    // Checking that intialistaion of the super object failed.
    if (self != nil)
    {
        screenSize = [CCDirector sharedDirector].winSize;
        halfScreenHeight = screenSize.height/2;
        halfScreenWidth = screenSize.width/2;
        
        // Checking if the app is running on iPad or iPhone.
        // IPHONE INITIALISATION
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            
            // Creating the start game icon for the skip animation and start game icon.
            // It is supplied an image for its non selected state and seleceted state.
            // It is given a target class (this class) and a selector to the start
            // game function.
            
            startGameIcon = [CCMenuItemImage itemWithNormalImage:@"cutscene_skip-ipadhd.png"
                                                   selectedImage:@"cutscene_skip_selected-ipadhd.png"
                                                   disabledImage:nil
                                                          target:self
                                                        selector:@selector(startGame)];
            
            // See above for description.
            startTutorialIcon = [CCMenuItemImage itemWithNormalImage:@"skip_to_tut-ipadhd.png"
                                                   selectedImage:@"skip_to_tut_selected-ipadhd.png"
                                                   disabledImage:nil
                                                          target:self
                                                        selector:@selector(tutorialManagerNext)];
            
            // Creating the original frame for the animation.
            originalFrame = [CCSprite spriteWithFile:@"cutscene_image_1-ipadhd.png"];
            
            // Positioning the original frame, centered.
            originalFrame.position = ccp(screenSize.width/2, screenSize.height/2);
            
            // Adding the original frame to the layer.
            [self addChild:originalFrame z:kCutSceneAnimationZValue];
            
            // Adding the menu item created above to the menu.
            cutSceneMenu = [CCMenu menuWithItems: startTutorialIcon,startGameIcon, nil];
            
            tutMenuBack = [CCSprite spriteWithFile:@"tut_men_back-ipadhd.png"];
            
            // See above for description.
            tutPrevIcon = [CCMenuItemImage itemWithNormalImage:@"tut_men_prev-ipadhd.png"
                                                 selectedImage:@"tut_men_prev_selected-ipadhd.png"
                                                 disabledImage:nil
                                                        target:self
                                                      selector:@selector(tutorialManagerPrev)];
            
            // See above for description.
            tutNextIcon = [CCMenuItemImage itemWithNormalImage:@"tut_men_next-ipadhd.png"
                                                 selectedImage:@"tut_men_next_selected-ipadhd.png"
                                                 disabledImage:nil
                                                        target:self
                                                      selector:@selector(tutorialManagerNext)];
            
            // See above for description.
            tutStartGameIcon = [CCMenuItemImage itemWithNormalImage:@"tut_men_start-ipadhd.png"
                                                      selectedImage:@"tut_men_start_selected-ipadhd.png"
                                                      disabledImage:nil
                                                             target:self
                                                           selector:@selector(startGame)];
            
            // See above for description.
            xIcon = [CCMenuItemImage itemWithNormalImage:@"xicon-ipadhd.png"
                                           selectedImage:@"xicon_selected-ipadhd.png"
                                           disabledImage:nil
                                                  target:self
                                                selector:@selector(backToCutScene)];
            
            tutMenu = [CCMenu menuWithItems:tutPrevIcon, tutNextIcon, tutStartGameIcon, xIcon, nil];
            
            // Positioning the menu at the bottom left corner of the screen.
            cutSceneMenu.position = ccp(0, 0);
            
            // Positioning the menu icon on the screen.
            startGameIcon.position = ccp((halfScreenWidth) + (350), (screenSize.height) - (575));
            // Positioning the menu icon on the screen.
            startTutorialIcon.position = ccp((halfScreenWidth) + (140), (screenSize.height) - (575));
            
            tutImage1 = [CCSprite spriteWithFile:@"tut_1-ipadhd.png"];
            tutImage2 = [CCSprite spriteWithFile:@"tut_2-ipadhd.png"];
            tutImage3 = [CCSprite spriteWithFile:@"tut_3-ipadhd.png"];
            tutImage4 = [CCSprite spriteWithFile:@"tut_4-ipadhd.png"];
            tutImage5 = [CCSprite spriteWithFile:@"tut_5-ipadhd.png"];
            tutImage6 = [CCSprite spriteWithFile:@"tut_6-ipadhd.png"];
            tutImage7 = [CCSprite spriteWithFile:@"tut_7-ipadhd.png"];
            
            
            //inventory_key_icon-widehd.png
            handIcon = [CCSprite spriteWithFile:@"tut_hand-ipadhd.png"];
            handIcon.position = ccp(screenSize.width * 3, screenSize.height * 3);
            handIcon.scaleX = .5;
            handIcon.scaleY = .5;
            [self addChild:handIcon z:3500];
            keyIcon = [CCSprite spriteWithFile:@"inventory_key_icon-ipadhd.png"];
            keyIcon.position = ccp(screenSize.width * 3, screenSize.height * 3);
            keyIcon.scaleX = .9;
            keyIcon.scaleY = .9;
            [self addChild:keyIcon z:3400];
        }
        // IPHONE INITIALISATION
        else
        {
            // The set up for iPhone animation is slightly different than for iPad. The images being used for
            // the iPad animation were too large to create a sprite sheet. The maximum texture size for
            // iPad Retina is 4096. All 22 images for the animation far suurpased this. So the iPad
            // animation could not be created using sprite sheets, frames cache or sprite batch node.
            // The iPhone animation could use these cocos2d features.
            
            // Creating and initialising the sprite frame cache.
            mainAnimFramesCache = [CCSpriteFrameCache sharedSpriteFrameCache];
            
            // Passing the playlist with animation frame co-ordinates for the sprite sheet.
            [mainAnimFramesCache addSpriteFramesWithFile:@"cut_scene-widehd.plist"];
            
            // Passing the sprite sheet with animation frames.
            mainAnimBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"cut_scene-widehd.png"];
            
            // Getting the first frame for the animation from the frames cache.
            originalFrame = [CCSprite spriteWithSpriteFrameName:@"cutscene_image_1.png"];
            
            // See above for description.
            startGameIcon = [CCMenuItemImage itemWithNormalImage:@"cutscene_skip-widehd.png"
                                                   selectedImage:@"cutscene_skip_selected-widehd.png"
                                                   disabledImage:nil
                                                          target:self
                                                        selector:@selector(startGame)];
            
            // See above for description.
            startTutorialIcon = [CCMenuItemImage itemWithNormalImage:@"skip_to_tut-widehd.png"
                                                   selectedImage:@"skip_to_tut_selected-widehd.png"
                                                   disabledImage:nil
                                                          target:self
                                                        selector:@selector(tutorialManagerNext)];
            
            // Adding the menu item created above to the menu.
            cutSceneMenu = [CCMenu menuWithItems: startTutorialIcon, startGameIcon, nil];
            
            // Positioning the menu at the bottom
            cutSceneMenu.position = ccp(0, 0);
            
            tutMenuBack = [CCSprite spriteWithFile:@"tut_men_back-widehd.png"];
            
            // See above for description.
            tutPrevIcon = [CCMenuItemImage itemWithNormalImage:@"tut_men_prev-widehd.png"
                                                   selectedImage:@"tut_men_prev_selected-widehd.png"
                                                   disabledImage:nil
                                                          target:self
                                                        selector:@selector(tutorialManagerPrev)];
            
            // See above for description.
            tutNextIcon = [CCMenuItemImage itemWithNormalImage:@"tut_men_next-widehd.png"
                                                       selectedImage:@"tut_men_next_selected-widehd.png"
                                                       disabledImage:nil
                                                              target:self
                                                            selector:@selector(tutorialManagerNext)];
            
            // See above for description.
            tutStartGameIcon = [CCMenuItemImage itemWithNormalImage:@"tut_men_start-widehd.png"
                                                 selectedImage:@"tut_men_start_selected-widehd.png"
                                                 disabledImage:nil
                                                        target:self
                                                      selector:@selector(startGame)];
            
            // See above for description.
            xIcon = [CCMenuItemImage itemWithNormalImage:@"xicon-widehd.png"
                                                      selectedImage:@"xicon_selected-widehd.png"
                                                      disabledImage:nil
                                                             target:self
                                                           selector:@selector(backToCutScene)];
            
            tutMenu = [CCMenu menuWithItems:tutPrevIcon, tutNextIcon, tutStartGameIcon, xIcon, nil];
            
            // Positioning the original frame on the screen.
            originalFrame.position = ccp(halfScreenWidth, halfScreenHeight);
            
            // Positioning the menu icons on the screen.
            startGameIcon.position = ccp((screenSize.width) - (90), (halfScreenHeight) - (70));
            startTutorialIcon.position = ccp((screenSize.width) - (220), halfScreenHeight - (70));
          
            // Adding the original frame to the batch node.
            [mainAnimBatchNode addChild:originalFrame];
            
            // Adding the batch node to the stage. This means that the GPU will only make one
            // draw call for all animation frames.
            [self addChild:mainAnimBatchNode z:kCutSceneAnimationZValue];
            
            tutImage1 = [CCSprite spriteWithFile:@"tut_1-widehd.png"];
            tutImage2 = [CCSprite spriteWithFile:@"tut_2-widehd.png"];
            tutImage3 = [CCSprite spriteWithFile:@"tut_3-widehd.png"];
            tutImage4 = [CCSprite spriteWithFile:@"tut_4-widehd.png"];
            tutImage5 = [CCSprite spriteWithFile:@"tut_5-widehd.png"];
            tutImage6 = [CCSprite spriteWithFile:@"tut_6-widehd.png"];
            tutImage7 = [CCSprite spriteWithFile:@"tut_7-widehd.png"];
            
            //inventory_key_icon-widehd.png
            handIcon = [CCSprite spriteWithFile:@"tut_hand-widehd.png"];
            handIcon.position = ccp(screenSize.width * 3, screenSize.height * 3);
            handIcon.scaleX = .5;
            handIcon.scaleY = .5;
            [self addChild:handIcon z:3500];
            keyIcon = [CCSprite spriteWithFile:@"inventory_key_icon-widehd.png"];
            keyIcon.position = ccp(screenSize.width * 3, screenSize.height * 3);
            keyIcon.scaleX = .9;
            keyIcon.scaleY = .9;
            [self addChild:keyIcon z:3400];
        }
        
       
        
        // Setting the timer counter variable to 0;
        timeCounter = 0.0;
        
        // Pre-loading effects for the buttons.
        // Passed a string defined in Constants.h.
        [[SimpleAudioEngine sharedEngine] preloadEffect:aCutSceneEnd];
        [[SimpleAudioEngine sharedEngine] preloadEffect:aButtonOneSound];
        
        // Pre-loading the background music.
        // Passed a string defined in Constants.h.
        [[CDAudioManager sharedManager] preloadBackgroundMusic:aCutSceneOnLoad];
        
        // Assigning the right channel to play the background music.
        rightChannel = [[CDAudioManager sharedManager] audioSourceForChannel:kASC_Right];
        rightChannel.delegate = self;
        
        // Adding the menu to the layer.
        // Passed a value defined in Constants.h.
        [self addChild:cutSceneMenu z:kCutSceneMenuZValue];
        
        [self addChild:tutMenu z:kCutSceneTutMenu];
        
        [self addChild:tutMenuBack z:kCutSceneMenuZValue];
        
         // Loading the resources for the load bar.
        [self loadResources];
        
        tutMenu.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutMenuBack.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage1.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage2.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage3.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage4.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage5.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage6.position = ccp(screenSize.width * (3), screenSize.height * (3));
        tutImage7.position = ccp(screenSize.width * (3), screenSize.height * (3));

        [self addChild:tutImage1 z:kCutSceneAnimationZValue];
        [self addChild:tutImage2 z:kCutSceneAnimationZValue];
        [self addChild:tutImage3 z:kCutSceneAnimationZValue];
        [self addChild:tutImage4 z:kCutSceneAnimationZValue];
        [self addChild:tutImage5 z:kCutSceneAnimationZValue];
        [self addChild:tutImage6 z:kCutSceneAnimationZValue];
        [self addChild:tutImage7 z:kCutSceneAnimationZValue];
        
        backCutScene = NO;
        currentTutorialFrame = 1;
        
        // Calling the function to start the cut scene animation.
        [self performSelector:@selector(startCutSceneAnim) withObject:nil afterDelay:0.01];
    }
    return self;
}

@end

