//
//  PageInventaire.m
//  ShadukiamGame
//
//  Created by yael on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PageInventaire.h"

@implementation PageInventaire

- (void) show {
    
    titre = [[Titre alloc] initWithText:@"INVENTAIRE"];
    [self addChild:titre];
    titre.x = 120;
    titre.y = 3;
    
}

@end
