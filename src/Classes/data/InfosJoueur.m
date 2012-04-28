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
static NSMutableArray* objets = nil;

+(void) initialize {
    objets = [NSMutableArray array];
}

+ (void) setMyPerso:(int)numPerso {
    myPerso = numPerso;
}

+ (int) getMyPerso {
    return myPerso;
}

+ (void) addObjet:(int) objetID {
    [objets addObject:[NSNumber numberWithInt:objetID]];
}

+(NSMutableArray*) getObjets {
    return objets;
}

@end
