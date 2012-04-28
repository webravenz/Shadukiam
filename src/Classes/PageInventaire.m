//
//  PageInventaire.m
//  ShadukiamGame
//
//  Created by yael on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PageInventaire.h"

@implementation PageInventaire

- (void) show {
    
    [super show];
    
    titre = [[Titre alloc] initWithText:@"INVENTAIRE"];
    [self addChild:titre];
    titre.x = 120;
    titre.y = 3;
    
    backBtn = [SPImage imageWithContentsOfFile:@"retourne.png"];
    [self addChild:backBtn];
    backBtn.x = 420;
    backBtn.y = 5;
    
    [backBtn addEventListener:@selector(onTouchBack:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    objetsIcones = [SPSprite sprite];
    [self addChild:objetsIcones];
    
    // test, a enlever
    [InfosJoueur addObjet:1];
    [InfosJoueur addObjet:2];
    
    // affichage des objets
    NSMutableArray *objets = [InfosJoueur getObjets];
    NSEnumerator *enumerator = [objets objectEnumerator];
    NSNumber *objetID;
    int i = 0;
    
    while(objetID = [enumerator nextObject]) {
        
        ObjetMini *objetIcone = [[ObjetMini alloc] initWithObjetID:[objetID intValue]];
        [objetsIcones addChild:objetIcone];
        objetIcone.x = (i % 4) * 95 + 70;
        objetIcone.y = 70 + round(i / 4) * 100;
        
        [objetIcone addEventListener:@selector(onTouchObjet:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        
        i++;
    }
    
    
    // init masque background
    backgroundMask = [[SPQuad alloc] initWithWidth:[Game stageWidth] height:[Game stageHeight] color:0x000000];
    backgroundMask.alpha = 0;
    
    
    
    // anim
    titre.alpha = 0;
    titre.y = -20;
    SPTween* tweenTitre = [SPTween tweenWithTarget:titre time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenTitre setDelay:0.5f];
    [tweenTitre animateProperty:@"alpha" targetValue:1];
    [tweenTitre animateProperty:@"y" targetValue:3];
    
    [self.stage.juggler addObject:tweenTitre];
    
    backBtn.alpha = 0;
    backBtn.y = -20;
    SPTween* tweenBack = [SPTween tweenWithTarget:backBtn time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenBack setDelay:0.5f];
    [tweenBack animateProperty:@"alpha" targetValue:1];
    [tweenBack animateProperty:@"y" targetValue:3];
    
    [self.stage.juggler addObject:tweenBack];
    
    objetsIcones.alpha = 0;
    objetsIcones.y = 5;
    SPTween* tweenIcones = [SPTween tweenWithTarget:objetsIcones time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenIcones setDelay:0.75f];
    [tweenIcones animateProperty:@"alpha" targetValue:1];
    [tweenIcones animateProperty:@"y" targetValue:0];
    
    [self.stage.juggler addObject:tweenIcones];
    
}

-(void) onTouchBack:(SPTouchEvent*) event {
    
    targetPage = @"PageTDB";
    [self animQuit];
    
}

-(void) animQuit {
    
    SPTween* tweenTitre = [SPTween tweenWithTarget:titre time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenTitre animateProperty:@"alpha" targetValue:0];
    [tweenTitre animateProperty:@"y" targetValue:-20];
    
    [self.stage.juggler addObject:tweenTitre];
    
    SPTween* tweenBack = [SPTween tweenWithTarget:backBtn time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenBack animateProperty:@"alpha" targetValue:0];
    [tweenBack animateProperty:@"y" targetValue:-20];
    
    [self.stage.juggler addObject:tweenBack];
    
    SPTween* tweenIcones = [SPTween tweenWithTarget:objetsIcones time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenIcones animateProperty:@"alpha" targetValue:0];
    [tweenIcones animateProperty:@"y" targetValue:5];
    
    [self.stage.juggler addObject:tweenIcones];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(goNextPage:) userInfo:nil repeats:NO];
}

-(void) goNextPage:(NSTimer*) timer {
    
    [[PageManager getInstance] changePage:targetPage];
    
    //kill the timer
    [timer invalidate];
    timer = nil;
}

// touch d'un objet
- (void) onTouchObjet:(SPTouchEvent*) event {
    
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] allObjects];
    
    // si on a bien juste tapé sur l'objet
    if(touches.count == 1) {  
        SPTouch *touch = [touches objectAtIndex:0];
        if (touch.tapCount == 1)
        {
            ObjetMini *objetTouch = (ObjetMini*)event.currentTarget;
            [self showObjet:objetTouch.ID];
        }
    }
    
}

// affichage d'une fiche perso en grand
- (void) showObjet:(int)numObjet {
    
    [self addChild:backgroundMask];
    
    // init fiche
    objetActive = [[FicheObjet alloc] init ];
    [objetActive initWithID:numObjet];
    
    objetActive.x = ([Game stageWidth] - objetActive.width) / 2 + 17;
    objetActive.y = ([Game stageHeight] - objetActive.height) / 2 + 45;
    objetActive.alpha = 0;
    [self addChild:objetActive];
    
    // select perso
    //[objetActive addEventListener:@selector(onSelectPerso:) atObject:self forType:@"touchOK"];
    
    // tween fiche et background
    SPTween *tweenFiche = [SPTween tweenWithTarget:objetActive time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenFiche animateProperty:@"y" targetValue:objetActive.y - 30];
    [tweenFiche animateProperty:@"alpha" targetValue:1];
    tweenFiche.delay = 0.25f;
    
    SPTween *tweenBack = [SPTween tweenWithTarget:backgroundMask time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenBack animateProperty:@"alpha" targetValue:0.5];
    
    [self.stage.juggler addObject:tweenFiche];
    [self.stage.juggler addObject:tweenBack];
    
    // close
    [backgroundMask addEventListener:@selector(closeObjet:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
}

// ferme fiche perso
- (void) closeObjet:(SPTouchEvent*)event {
    [backgroundMask removeEventListener:@selector(closeObjet:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    // tween fiche et background
    SPTween *tweenFiche = [SPTween tweenWithTarget:objetActive time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenFiche animateProperty:@"y" targetValue:objetActive.y + 30];
    [tweenFiche animateProperty:@"alpha" targetValue:0];
    
    SPTween *tweenBack = [SPTween tweenWithTarget:backgroundMask time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenBack animateProperty:@"alpha" targetValue:0];
    
    [self.stage.juggler addObject:tweenFiche];
    [self.stage.juggler addObject:tweenBack];
    
    [tweenBack addEventListener:@selector(onCloseObjetCompleted:) atObject:self
                        forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    
    
}

- (void) onCloseObjetCompleted:(SPEvent*)event {
    
    [event.currentTarget removeEventListener:@selector(onCloseObjetCompleted:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    
    [self removeChild:objetActive];
    objetActive = nil;
    [self removeChild:backgroundMask];
    backgroundMask.alpha = 0;
    
    
}

-(void) finalize {
    [self removeChild:titre];
    titre = nil;
    
    [self removeChild:backBtn];
    [backBtn removeEventListener:@selector(onTouchBack:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    backBtn = nil;
    
    for(int j = 0; j < [objetsIcones numChildren]; j++) {
        ObjetMini *objetIcone = (ObjetMini*) [objetsIcones childAtIndex:j];
        [objetIcone removeEventListener:@selector(onTouchObjet:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }
    [objetsIcones removeAllChildren];
    
    [self removeChild:objetsIcones];
    objetsIcones = nil;
}

@end
