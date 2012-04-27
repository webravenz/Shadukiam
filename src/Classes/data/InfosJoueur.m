//
//  InfosJoueur.m
//  ShadukiamGame
//
//  Created by yael on 27/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfosJoueur.h"

@implementation InfosJoueur

static int myPerso = 0;

+ (void) setMyPerso:(int)numPerso {
    myPerso = numPerso;
}

+ (int) getMyPerso {
    return myPerso;
}

@end
