//
//  Roue.h
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 02/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "SPSprite.h"

@interface Roue : SPSprite{
    
    SPImage *background;
    SPImage *arrow;
    SPImage *roue;
    SPSprite *containerRoue;
}

-(id) initDisplay;
-(void) update:(CGFloat) fValue;
-(void) getResult;


@end
