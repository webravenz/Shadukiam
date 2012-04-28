//
//  ObjetMini.m
//  ShadukiamGame
//
//  Created by yael on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ObjetMini.h"

@implementation ObjetMini

@synthesize ID;

-(id) initWithObjetID:(int) objetID {
    
    self = [super init];
    
    ID = objetID;
    
    background = [SPImage imageWithContentsOfFile:@"objet_mini_bkg.png"];
    [self addChild:background];
    
    icone = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"objet_mini_image_%d.png", ID]];
    [self addChild:icone];
    icone.x = (background.width - icone.width) / 2;
    icone.y = (background.height - icone.height) / 2;
    
    return self;
    
}

-(void) finalize {
    
    [self removeChild:background];
    background = nil;
    
    [self removeChild:icone];
    icone = nil;
    
}

@end
