//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"

#define kCCFollowHeight 75

@implementation MainScene {
    CCLabelBMFont *_label;
    CCNode *_star;
    int _position;
}

- (void)didLoadFromCCB {
    _position = 0;
    [self schedule:@selector(nextCharacter:) interval:0.50f];
}

- (void)nextCharacter:(CCTime) dt {
    if(_position==_label.children.count) _position = 0; // Reset

    // Get next label character
    CCNode *nextPosition = [_label.children objectAtIndex:_position];

    // Update position, move to character node position and use constant height
    CGPoint position = [_label convertToWorldSpace:ccp(nextPosition.position.x,kCCFollowHeight)];

    // Create move action
    CCActionMoveTo *actionMoveUp = [CCActionMoveTo actionWithDuration:0.25f position:ccpSub(position,ccp(0,20))];

    // Apply easing to action
    CCActionEaseBounceIn *actionEaseUp = [CCActionEaseBounceIn actionWithAction:actionMoveUp];

    // Create move action
    CCActionMoveTo *actionMoveDown = [CCActionMoveTo actionWithDuration:0.25f position:ccpAdd(position,ccp(0,20))];

    // Apply easing to action
    CCActionEaseBounceOut *actionEaseDown = [CCActionEaseBounceOut actionWithAction:actionMoveDown];

    // Run action
    [_star runAction:[CCActionSequence actionOne:actionEaseUp two:actionEaseDown]];

    // Track last label character
    _position++;
}

@end
