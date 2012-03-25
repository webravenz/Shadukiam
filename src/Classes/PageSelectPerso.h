//
//  PageSelectPerso.h
//  ShadukiamGame
//
//  Created by yael on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Page.h"
#import "PageManager.h"
#import "Slider.h"

@interface PageSelectPerso : Page {
    Slider *sliderPersos;
    SPQuad *persoActive;
    SPQuad *backgroundMask;
}

- (void) onTouchPerso:(SPTouchEvent*)event;
- (void) showPerso;
- (void) closePerso:(SPTouchEvent*)event;

@end
