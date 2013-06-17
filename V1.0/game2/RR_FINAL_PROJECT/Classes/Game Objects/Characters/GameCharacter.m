//
//  GameCharacter.m
//  game5
//
//  Created by Ronan Sean on 18/02/2013.
//  Copyright (c) 2013 Ronan Sean. All rights reserved.
//
// Class Description Below:
//
// This class is s subclass of CCSprite. Both characters will subclass from this class and in doing so
// inherit all of the functionality of CCSprite together with the additional functionality defined in this class.
//
// There is a function in this class that loads data from a plist. The data is the used to specify
// what frame that should be used in an animation for a character. This works in conjunction with and only if
// the class utilising it has a plist (sprite sheet with individual frame co-oridnates and names) added to a
// CCSpriteFrameCache and a sprite sheet containing the individually packed images in CCSpriteBatchNode.
//
// The data the method loadPlistForAnimationWithName in this class parses from the property list for the character
// must match the same frame details from the CCSpriteFrameCache. This method is long so rather than have it in
// both character classes it seemed only right to put it into a GameCharcater class along with the rwo methods both
// chacters have in common, walkLeft & walkRight.
//
// The property list for both characters can be found at Resorces/Plists/ORourke.plist & Stanley.plist
// 
// This class and its concept and explanation were taken and adapted from:
//
// Strougo, R. Learning Cocos2D: A Hands-On Guide to Building iOS Games with Cocos2D, Box2D, and Chipmunk.
// Addison Wesley Professional, Boston, 2011, (ch 3).
//
//

#import "GameCharacter.h"

@implementation GameCharacter

@synthesize animObjectWalkRight;
@synthesize animObjectWalkLeft;

#pragma mark Walk Method Stubs
-(void)walkLeft
{
    // Do Something here
}

-(void)walkRight
{
    // Do Something here
}

// This method is used by chacter classes to set up frames for certain animations as defined in plists.
// The animations defined in the property list correspond with Animation objects given the same name in in
// character classes. The plists themselves must be given the same name as the charcters. This method can then be
// passed an animation name and class name from a character class in order to set up a specific animation.

#pragma mark Load Property list Function
-(CCAnimation*)loadPlistForAnimationWithName:(NSString*)animationName andClassName:(NSString*)className
{
    CCAnimation *animationToReturn = nil;
    NSString *fullFileName =
    [NSString stringWithFormat:@"%@.plist",className];
    NSString *plistPath;
    
    // 1st: Get the path to the property list.
    // Trys to get the actual file system path to the plist.
    // Uses the class name passed to the method to determine
    // the path from the application bundle.
    NSString *rootPath =
    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                         NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:fullFileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        plistPath = [[NSBundle mainBundle]
                     pathForResource:className ofType:@"plist"];
    }
    
    // 2nd: Read in the contents of this property list.
    // Built in methods used to parse the entire plist.
    // A dictionary is returned with its contents. The returnes
    // NSdictionary contains all the mini dictionaries from the plist.
    NSDictionary *plistDictionary =
    [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    // 3rd: If could not find the property list, nil is returned.
    // Checking that the dictionary was not empty.
    if (plistDictionary == nil)
    {
        CCLOG(@"Error reading plist: %@.plist", className);
        return nil; // No Plist Dictionary or file found.
    }
    
    // 4th: Get the mini dictionary for the animation name passed to
    // this function. Extract the mini dictionary for animation given
    // the name that was passed in this the method.
    NSDictionary *animationSettings =
    [plistDictionary objectForKey:animationName];
    if (animationSettings == nil)
    {
        CCLOG(@"Could not locate AnimationWithName:%@",animationName);
        return nil;
    }
    
    // 6th: Get the delay value for the animation.
    // The value from the property list is 0.25.
    // This is then used to create the animation object
    float animationDelay =
    [[animationSettings objectForKey:@"delay"] floatValue];
    animationToReturn = [CCAnimation animation];
    [animationToReturn setDelayPerUnit:animationDelay];
    
    // 7th: Add each frame to the animation.
    NSString *animationFramePrefix =
    [animationSettings objectForKey:@"filenamePrefix"]; // get the prefix for the filename for each frame.
    NSString *animationFrames =
    [animationSettings objectForKey:@"animationFrames"];// Break apart the fram numbers and put in array.
    NSArray *animationFrameNumbers =
    [animationFrames componentsSeparatedByString:@","]; // Use the NSString componentsSeparatedByString
                                                        // to split up the string into comma seperated values.
    // Loops through the array of frame numbers and adds the CCSpriteFrame to the animtion.
    for (NSString *frameNumber in animationFrameNumbers)
    {
        NSString *frameName =
        [NSString stringWithFormat:@"%@%@.png", // Place holders for prefix, frame number and .png
         animationFramePrefix,frameNumber];     // Will look like stanley_walk_left_1.png
        [animationToReturn addSpriteFrame:
         [[CCSpriteFrameCache sharedSpriteFrameCache]
          spriteFrameByName:frameName]];
    }
    
    // Return the animation.
    return animationToReturn;
}



@end
