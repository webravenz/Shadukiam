//
//  Slider.m
//  ShadukiamGame
//
//  Created by yael on 20/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Slider.h"
#import "Game.h"

@implementation Slider

- (id)initWithWidth:(float)width height:(float)height
{
    [super init];
    
    // init de la taille, et de la zone pour pouvoir drager sur tout le slider
    self.width = width;
    self.height = height;
    
    zoneDrag = [SPQuad quadWithWidth:width height:height];
    zoneDrag.alpha = 0;
    [self addChild:zoneDrag];
    
    // init drag
    diffX = 0;
    speed = 0;
    [self addEventListener:@selector(onTouchEvent:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [self addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
    
    return self;
}

// touch stockage difference
- (void)onTouchEvent:(SPTouchEvent*)event
{
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] allObjects];
    
    if(touches.count == 1) {
        SPTouch *touch = [touches objectAtIndex:0];
        
        SPPoint *currentPos = [touch locationInSpace:self.parent];
        SPPoint *previousPos = [touch previousLocationInSpace:self.parent];
        SPPoint *dist = [currentPos subtractPoint:previousPos];
        
        diffX += dist.x;
    }

}

// au enter frame deplacement du slider
- (void)onEnterFrame:(SPEvent*)event {
    
    if(diffX != 0)
        speed = diffX;
    else if(speed > 0.5 || speed < -0.5)
        speed /= 1.2;
    else
        speed = 0;
    
    self.x += speed;
    diffX = 0;
    
    // border limit
    if(self.x > 0) self.x = 0;
    else if(self.x < [Game stageWidth] - self.width) self.x = [Game stageWidth] - self.width;
}


- (void)dealloc
{
    // event listeners should always be removed to avoid memory leaks!
    [self removeEventListenersAtObject:self forType:SP_EVENT_TYPE_TOUCH];
    zoneDrag = nil;
    [super dealloc];
}

@end
