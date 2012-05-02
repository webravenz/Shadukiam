//
//  Roue.m
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 02/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "Roue.h"

@implementation Roue

-(id) initDisplay {
    self = [super init];
    
    background = [SPImage imageWithContentsOfFile:@"roue-etp1-fond.png"];
    [self addChild:background];
    
    containerRoue = [[SPSprite alloc] init];
    containerRoue.x = self.width/2;
    containerRoue.y = self.height/2;
    [self addChild:containerRoue];
    
    roue = [SPImage imageWithContentsOfFile:@"roue-etp1-roue1.png"];
    roue.x = -roue.width/2;
    roue.y = -roue.height/2;
    [containerRoue addChild:roue];
    
    containerRoue.rotation = SP_D2R( -30 );
    
    arrow = [SPImage imageWithContentsOfFile:@"roue-etp1-aiguille.png"];
    [self addChild:arrow];
    
    return self;
}

-(void) update:(CGFloat) value{
    containerRoue.rotation += SP_D2R( value );		
}

-(void) getResult{
    float rot = containerRoue.rotation;
    rot = SP_R2D( rot );
    if( rot < 0.0f ){
        rot = 360 + rot;
    }
    rot = roundf( ((int)rot)/60 );
    
    NSLog( @"rotation ::: %f", rot );
}

@end
