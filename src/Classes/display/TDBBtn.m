//
//  TDBBtn.m
//  ShadukiamGame
//
//  Created by yael on 27/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TDBBtn.h"

@implementation TDBBtn

-(id) initWithText:(NSString*)textStr {
    
    self = [super init];
    
    background = [SPImage imageWithContentsOfFile:@"btn_tdb_bkg.png"];
    [self addChild:background];
    background.x = 6;
    
    txtBackground = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"btn_tdb_titre_bkg_%d.png", [InfosJoueur getMyPerso]]];
    
    [self addChild:txtBackground];
    txtBackground.y = 55;
    
    texte = [SPTextField textFieldWithText:textStr];
    texte.fontName = @"Times New Roman";
    texte.fontSize = 9;
    texte.color = 0xFFFFFF;
    texte.width = txtBackground.width;
    texte.height = 16;
    texte.hAlign = SPHAlignCenter;
    [self addChild:texte];
    texte.y = 59;
    
    return self;
}

-(void) finalize {
    [self removeChild:background];
    background = nil;
    [self removeChild:txtBackground];
    txtBackground = nil;
    [self removeChild:texte];
    texte = nil;
}

@end
