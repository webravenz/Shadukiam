//
//  InfosPartie.m
//  ShadukiamGame
//
//  Created by yael on 27/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfosPartie.h"

@implementation InfosPartie

static NSMutableDictionary *joueurs = nil;

+(void) initialize {
    joueurs = [NSMutableDictionary dictionary];
}

+(void)addPlayer:(int)numPerso forPlayer:(int)playerID {
    
    NSString *playerIDStr = [NSString stringWithFormat:@"%d", playerID];
    NSString *numPersoStr = [NSString stringWithFormat:@"%d", numPerso];
    [joueurs setObject:numPersoStr forKey:playerIDStr];
    
}

+(int)getNbPlayers {
    return joueurs.count;
}

@end
