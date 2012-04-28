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
#import "FichePerso.h"
#import "Titre.h"
#import "InfosPartie.h"
#import "InfosJoueur.h"

@interface PageSelectPerso : Page {
    Slider *sliderPersos;
    FichePerso *persoActive;
    SPQuad *backgroundMask;
    Titre *titre;
    
    bool persoSelected;
    bool gameStarted;
}

- (void) onTouchPerso:(SPTouchEvent*)event;
- (void) showPerso:(int)numPerso;
- (void) closePerso:(SPTouchEvent*)event;
- (void) onPersoAdded:(int)numPerso forPlayer:(int)playerID;

@end
