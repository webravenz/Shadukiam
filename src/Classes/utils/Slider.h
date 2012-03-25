//
//  Slider.h
//  ShadukiamGame
//
//  Created by yael on 20/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SPSprite.h"

@interface Slider : SPSprite {
    SPQuad *zoneDrag;
    float diffX;
    float speed;
}

- (id)initWithWidth:(float)width height:(float)height;
- (void)onTouchEvent:(SPTouchEvent*)event;
- (void)onEnterFrame:(SPEvent*)event;

@end
