//
//  FichePerso.m
//  ShadukiamGame
//
//  Created by yael on 10/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FichePerso.h"

@implementation FichePerso

- (void) initWithPerso:(int)numPerso {
    
    general = [SPSprite sprite];
    
    background = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"ficheperso_bkg_%d.png", numPerso]];
    [general addChild:background];
    
    [self addChild:general];
    
    front = [SPSprite sprite];
    [self addChild:front];
    
    portrait = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"ficheperso_illu_%d.png", numPerso]];
    [front addChild:portrait];
    portrait.x = (background.width - portrait.width) / 2;
    portrait.y = 10;
    
    nom = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"ficheperso_nom_%d.png", numPerso]];
    [front addChild:nom];
    nom.x = (background.width - nom.width) / 2;
    nom.y = 200;
    
}

- (void)finalize
{
    // event listeners should always be removed to avoid memory leaks!
    [general removeChild:background];
    background = nil;
    [self removeChild:general];
    general = nil;
    
    [front removeChild:portrait];
    portrait = nil;
    
    [front removeChild:nom];
    nom = nil;
    
    [self removeChild:front];
    front = nil;
    
    [super finalize];
}

@end
