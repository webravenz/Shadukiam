//
//  Titre.h
//  ShadukiamGame
//
//  Created by yael on 21/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SPSprite.h"

@interface Titre : SPSprite {
    SPImage* background;
    SPTextField* texte;
}

-(id) initWithText:(NSString*)textStr;

@end
