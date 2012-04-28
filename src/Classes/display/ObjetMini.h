//
//  ObjetMini.h
//  ShadukiamGame
//
//  Created by yael on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SPSprite.h"

@interface ObjetMini : SPSprite {
    
    SPImage *background;
    SPImage *icone;
    int ID;
    
}

@property int ID;
-(id) initWithObjetID:(int) objetID;

@end
