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
    
    background = [SPImage imageWithContentsOfFile:@"fond_titre.png"];
    [self addChild:background];
    
    texte = [SPTextField textFieldWithText:textStr];
    texte.fontName = @"Times New Roman";
    texte.fontSize = 16;
    texte.color = 0x000000;
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
