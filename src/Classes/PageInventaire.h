//
//  PageInventaire.h
//  ShadukiamGame
//
//  Created by yael on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Page.h"
#import "Titre.h"
#import "PageManager.h"
#import "ObjetMini.h"
#import "FicheObjet.h"

@interface PageInventaire : Page {
    
    Titre *titre;
    SPImage *backBtn;
    SPSprite *objetsIcones;
    NSString *targetPage;
    SPQuad *backgroundMask;
    FicheObjet *objetActive;
    
}

-(void) animQuit;
- (void) showObjet:(int)numObjet;

@end
