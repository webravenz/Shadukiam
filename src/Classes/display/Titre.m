//
//  Titre.m
//  ShadukiamGame
//
//  Created by yael on 21/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Titre.h"

@implementation Titre

-(id) initWithText:(NSString*)textStr {
    
    self = [super init];
    
    int color = 0;
    
    if([InfosJoueur getMyPerso] == 0) {
        background = [SPImage imageWithContentsOfFile:@"fond_titre.png"];
        color = 0x000000;
    } else {
        background = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"fond_titre_%d.png", [InfosJoueur getMyPerso]]];
        color = 0xFFFFFF;
    }
    
    [self addChild:background];
    
    texte = [SPTextField textFieldWithText:textStr];
    texte.fontName = @"Times New Roman";
    texte.fontSize = 16;
    texte.color = color;
    texte.width = background.width;
    texte.height = 20;
    texte.hAlign = SPHAlignCenter;
    [self addChild:texte];
    texte.y = 12;
    
    return self;
}

-(void) finalize {
    [self removeChild:background];
    background = nil;
    [self removeChild:texte];
    texte = nil;
}

@end
