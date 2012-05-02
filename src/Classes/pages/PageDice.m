//
//  PageDice.m
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 02/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "PageDice.h"

@implementation PageDice

-(void) show {
    [super show];
    
    velocity = 0.0;
    velocity2 = 0.0;
    
    titre = [[Titre alloc] initWithText:@"Lancer" ];
    [self addChild:titre ];
    titre.x = 120;
    titre.y = 3;
    
    roue1 = [[Roue alloc] initDisplay ];
    roue1.x = 55;
    roue1.y = 75;
    [self addChild:roue1];
    
    roue2 = [[Roue alloc] initDisplay ];
    roue2.x = 265;
    roue2.y = 75;
    [self addChild:roue2];

    [self addEventListener:@selector(onSwipe:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [self addEventListener:@selector(onFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}

-(void)onSwipe:(SPTouchEvent*) event {
    NSArray *touchBegan = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    NSArray *touchEnded = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] allObjects];
    
    if( touchBegan.count == 1 ){
        SPTouch *touch = [touchBegan objectAtIndex:0];
        if( touch.tapCount == 1 ){
            start = [touch locationInSpace:self.parent];	
            previousTime = [ [ NSDate date ] timeIntervalSince1970 ];
        }
    }
    
    
    if( touchEnded.count == 1 ){
        SPTouch *touchE = [touchEnded objectAtIndex:0];
        
        CGFloat dist = [self DistanceBetweenTwoPoints:[touchE locationInSpace:self.parent] withPoint2:start ];
        
        if( [[ NSDate date ] timeIntervalSince1970 ] - previousTime < 0.7 ){
            if( dist > 50 ){
                velocity = ( [touchE locationInSpace:self.parent].x - start.x );
                velocity2 = velocity + ( arc4random()%60 - 30 );
                
                //[self removeEventListener:@selector(onSwipe:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
                
                velocity = MIN( velocity, 400 );
                velocity2 = MIN( velocity2, 400 );
                
                velocity = MAX( velocity, -400 );
                velocity2 = MAX( velocity2, -400 );
            }
        }
    }
}

-(void)onFrame:(SPEnterFrameEvent*) event{
    if( velocity != 0.0 || velocity2 != 0 ){

        [roue1 update:velocity];
        [roue2 update:velocity2];
        
        velocity = velocity * 0.95;
        velocity2 = velocity2 * 0.95;
        
        if( velocity < 0.1 && velocity > -0.1 ){
            velocity = 0.0;
        }
        
        if( velocity2 < 0.1 && velocity2 > -0.1 ){
            velocity2 = 0.0;
        }
        
        if( velocity == 0.0 && velocity2 == 0.0 ){
            NSLog(@"result");
            [self result];
        }
    }
}

-(void)result{
    [roue1 getResult];
    [roue2 getResult];
}

-(CGFloat) DistanceBetweenTwoPoints:(SPPoint*) point1 withPoint2:(SPPoint*) point2
{

    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
    return sqrt(dx*dx + dy*dy );
}

@end
