//
//  PageMove.m
//  ShadukiamGame
//
//  Created by yael on 02/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PageMove.h"

@implementation PageMove

- (void) show {
    
    [super show];
    
    titre = [[Titre alloc] initWithText:@"DEPLACEMENT"];
    [self addChild:titre];
    titre.x = 120;
    titre.y = 3;
    
    // anims
    titre.alpha = 0;
    titre.y = -20;
    SPTween* tweenTitre = [SPTween tweenWithTarget:titre time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenTitre setDelay:0.5f];
    [tweenTitre animateProperty:@"alpha" targetValue:1];
    [tweenTitre animateProperty:@"y" targetValue:3];
    
    [self.stage.juggler addObject:tweenTitre];
    
    // recuperation des cases accessibles pour le deplacement
    
    currentCase = [[Plateau getInstance] getCaseByID:[InfosJoueur getCurrentCase]];
    casesAccessibles = [[Plateau getInstance] getZonesAccessible:[InfosJoueur getCurrentCase] nbMoves:3];
    NSLog(@"accessibles : %@", casesAccessibles);
    
}

@end
