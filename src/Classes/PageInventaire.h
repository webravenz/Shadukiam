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
#import "XMLReader.h"
#import "Slider.h"

@interface PageInventaire : Page {
    
    Titre *titre;
    SPImage *backBtn;
    Slider *objetsIcones;
    NSString *targetPage;
    SPQuad *backgroundMask;
    FicheObjet *objetActive;
    NSDictionary *infosXML;
    
}

-(void) animQuit;
- (void) showObjet:(int)numObjet;

@end
