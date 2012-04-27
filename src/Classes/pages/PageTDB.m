//
//  PageTDB.m
//  ShadukiamGame
//
//  Created by yael on 14/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PageTDB.h"

@implementation PageTDB

- (void) show {
    
    titre = [[Titre alloc] initWithText:@"TABLEAU DE BORD"];
    [self addChild:titre];
    titre.x = 120;
    titre.y = 3;
    
    persoImg = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"ficheperso_mini_%d.png", [InfosJoueur getMyPerso]]];
    [self addChild:persoImg];
    persoImg.scaleX = 0.8;
    persoImg.scaleY = 0.8;
    persoImg.x = ([Game stageWidth] - persoImg.width) / 2 + 20;
    persoImg.y = 50;
    
    btnInventaire = [[TDBBtn alloc] initWithText:@"INVENTAIRE"];
    btnInventaire.x = 80;
    btnInventaire.y = 45;
    [self addChild:btnInventaire];
    btnInventaire.name = @"PageInventaire";
    [btnInventaire addEventListener:@selector(onTouchBtn:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    btnPouvoir = [[TDBBtn alloc] initWithText:@"POUVOIR"];
    btnPouvoir.x = 80;
    btnPouvoir.y = 120;
    [self addChild:btnPouvoir];
    
    btnEnigme = [[TDBBtn alloc] initWithText:@"ENIGMES"];
    btnEnigme.x = 80;
    btnEnigme.y = 195;
    [self addChild:btnEnigme];
    
    btnMessagerie = [[TDBBtn alloc] initWithText:@"MESSAGERIE"];
    btnMessagerie.x = 340;
    btnMessagerie.y = 75;
    [self addChild:btnMessagerie];
    
    btnIntuition = [[TDBBtn alloc] initWithText:@"INTUITION"];
    btnIntuition.x = 340;
    btnIntuition.y = 165;
    [self addChild:btnIntuition];
    
}

// touch btn, emmene a la bonne page
-(void) onTouchBtn:(SPTouchEvent*) event {
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] allObjects];
    
    // si on a bien juste tapé sur l'objet
    if(touches.count == 1) {  
        SPTouch *touch = [touches objectAtIndex:0];
        if (touch.tapCount == 1)
        {
            TDBBtn *btnTouch = (TDBBtn*)event.currentTarget;
            [[PageManager getInstance] changePage:btnTouch.name];
        }
    }
    
}

-(void) finalize {
    [self removeChild:titre];
    titre = nil;
    
    [self removeChild:persoImg];
    persoImg = nil;
    
    [self removeChild:btnInventaire];
    btnInventaire = nil;
    [self removeChild:btnPouvoir];
    btnPouvoir = nil;
    [self removeChild:btnMessagerie];
    btnMessagerie = nil;
    [self removeChild:btnIntuition];
    btnIntuition = nil;
    [self removeChild:btnEnigme];
    btnEnigme = nil;
}

@end
