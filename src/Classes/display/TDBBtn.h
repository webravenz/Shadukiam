//
//  TDBBtn.h
//  ShadukiamGame
//
//  Created by yael on 27/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SPSprite.h"
#import "InfosJoueur.h"

@interface TDBBtn : SPSprite {
    SPImage *background;
    SPImage *txtBackground;
    SPTextField *texte;
}

-(id) initWithText:(NSString*)textStr;

@end
