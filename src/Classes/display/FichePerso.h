//
//  FichePerso.h
//  ShadukiamGame
//
//  Created by yael on 10/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SPSprite.h"
#import "Game.h"

@interface FichePerso : SPSprite {
    
    SPSprite *front;
    SPSprite *back;
    SPSprite *general;
    SPImage *background;
    SPImage *portrait;
    SPImage *nom;
    SPImage *retourneBtn;
    SPImage *nomBack;
    
    bool isFront;
    
}

- (void) initWithPerso:(int)numPerso;

@end
