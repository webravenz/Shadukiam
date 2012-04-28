//
//  PageTDB.h
//  ShadukiamGame
//
//  Created by yael on 14/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Page.h"
#import "Titre.h"
#import "InfosJoueur.h"
#import "PageManager.h"
#import "TDBBtn.h"

@interface PageTDB : Page {
    
    Titre *titre;
    SPImage *persoImg;
    TDBBtn *btnInventaire;
    TDBBtn *btnPouvoir;
    TDBBtn *btnEnigme;
    TDBBtn *btnMessagerie;
    TDBBtn *btnIntuition;
    SPSprite *buttons;
    NSString *targetPage;
    
}

-(void) animQuit;

@end
