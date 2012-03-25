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
    SPQuad *carre = [SPQuad quadWithWidth:100 height:100 color:0xFF0000];
    [self addChild:carre];
}

@end
