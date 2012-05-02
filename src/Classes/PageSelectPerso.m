//
//  PageSelectPerso.m
//  ShadukiamGame
//
//  Created by yael on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PageSelectPerso.h"
#import "XMLReader.h"

@implementation PageSelectPerso

- (void) show {
    
    [super show];
    
    persoSelected = NO;
    gameStarted = NO;
    
    // init titre
    titre = [[Titre alloc] initWithText:@"SELECTION DU PERSONNAGE"];
    [self addChild:titre];
    titre.y = 0;
    titre.x = 120;
    
    // init slider
    sliderPersos = [[Slider alloc] initWithWidth:3 * 210 height:[Game stageHeight]];
    [self addChild:sliderPersos];
    sliderPersos.y = 40;
    
    // init fiches
    for(int i = 1; i < 8; i++) {
        SPImage *ficheMini = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"ficheperso_mini_%d.png", i]];
        [sliderPersos addChild:ficheMini];
        ficheMini.x = (i * 210) - 170;
        ficheMini.name = [NSString stringWithFormat:@"%d", i];
        [ficheMini addEventListener:@selector(onTouchPerso:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }
    
    // init masque background
    backgroundMask = [[SPQuad alloc] initWithWidth:[Game stageWidth] height:[Game stageHeight] color:0x000000];
    backgroundMask.alpha = 0;
    
    // test XML
    /*
    NSData *xmlData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"persos" ofType:@"xml"]];
    NSError *error = nil;
    NSDictionary *dico = [XMLReader dictionaryForXMLData:xmlData error:&error];
    
    NSDictionary *perso = [dico retrieveForPath:@"persos.perso.0"];
    NSLog(@"name : %@", [perso objectForKey:@"name"]);
     */
}

- (void) onTouchPerso:(SPTouchEvent*)event {
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] allObjects];
    
    // si on a bien juste tapé sur l'objet
    if(touches.count == 1) {  
        SPTouch *touch = [touches objectAtIndex:0];
        if (touch.tapCount == 1)
        {
            SPImage *persoTouch = (SPImage*)event.target;
            int numTouch = [persoTouch.name intValue];
            [self showPerso:numTouch];
        }
    }
    
}

// affichage d'une fiche perso en grand
- (void) showPerso:(int)numPerso {
    
    [self addChild:backgroundMask];
    
    // init fiche
    persoActive = [[FichePerso alloc] init ];
    [persoActive initWithPerso:numPerso];
    
    persoActive.x = ([Game stageWidth] - persoActive.width) / 2 + 17;
    persoActive.y = ([Game stageHeight] - persoActive.height) / 2 + 45;
    persoActive.alpha = 0;
    [self addChild:persoActive];
    
    // select perso
    [persoActive addEventListener:@selector(onSelectPerso:) atObject:self forType:@"touchOK"];
    
    // tween fiche et background
    SPTween *tweenFiche = [SPTween tweenWithTarget:persoActive time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenFiche animateProperty:@"y" targetValue:persoActive.y - 30];
    [tweenFiche animateProperty:@"alpha" targetValue:1];
    tweenFiche.delay = 0.25f;
    
    SPTween *tweenBack = [SPTween tweenWithTarget:backgroundMask time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenBack animateProperty:@"alpha" targetValue:0.5];
    
    [self.stage.juggler addObject:tweenFiche];
    [self.stage.juggler addObject:tweenBack];
    
    // close
    [backgroundMask addEventListener:@selector(closePerso:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
}

// ferme fiche perso
- (void) closePerso:(SPTouchEvent*)event {
    [backgroundMask removeEventListener:@selector(closePerso:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [persoActive removeEventListener:@selector(onSelectPerso:) atObject:self forType:@"touchOK"];
    
    // tween fiche et background
    SPTween *tweenFiche = [SPTween tweenWithTarget:persoActive time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenFiche animateProperty:@"y" targetValue:persoActive.y + 30];
    [tweenFiche animateProperty:@"alpha" targetValue:0];
    
    SPTween *tweenBack = [SPTween tweenWithTarget:backgroundMask time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenBack animateProperty:@"alpha" targetValue:0];
    
    [self.stage.juggler addObject:tweenFiche];
    [self.stage.juggler addObject:tweenBack];
    
    [tweenBack addEventListener:@selector(onClosePersoCompleted:) atObject:self
                    forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    
    // si on a selectionné un perso, on masque le slider
    if(persoSelected) {
        SPTween *tweenSlider = [SPTween tweenWithTarget:sliderPersos time:0.5f transition:SP_TRANSITION_EASE_OUT];
        [tweenSlider animateProperty:@"alpha" targetValue:0];
        [self.stage.juggler addObject:tweenSlider];
    }
    
}

// selection d'un perso
- (void) onSelectPerso:(SPEvent*)event {
    if(!persoSelected) {
        persoSelected = YES;
    
        [InfosJoueur setMyPerso:persoActive.numPerso];
    
        [[Dialog getInstance] sendMessage:@"persoSelected" sendTo:-1 data:[NSString stringWithFormat:@"%d", persoActive.numPerso]];
    
        [self onPersoAdded:persoActive.numPerso forPlayer:[Dialog getInstance].myID];
    
    
        [self closePerso:nil];
    }
}

- (void) onClosePersoCompleted:(SPEvent*)event {
    [event.currentTarget removeEventListener:@selector(onClosePersoCompleted:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    
    [self removeChild:persoActive];
    persoActive = nil;
    [self removeChild:backgroundMask];
    backgroundMask.alpha = 0;
    
    if(persoSelected) {
        //[[PageManager getInstance] changePage:@"PageTDB"];
        [self removeChild:sliderPersos];
    }
    
    if(gameStarted) {
        [[PageManager getInstance] changePage:@"PageTDB"];
    }
    
}

// perso ajouté, que ça soit moi ou un autre
- (void) onPersoAdded:(int)numPerso forPlayer:(int)playerID {
    
    [[Menu getInstance] addPerso:numPerso];
    [InfosPartie addPlayer:numPerso forPlayer:playerID];
    
    // si on est le serveur on verifie si tout le monde a select son perso
    if([Dialog getInstance].isServer) {
        if([InfosPartie getNbPlayers] == [Dialog getInstance].clientsID.count + 1) {
            [[Dialog getInstance] sendMessage:@"gamestart" sendTo:-1 data:@"data"];
            
            if(persoActive == nil) {
                [[PageManager getInstance] changePage:@"PageTDB"];
            } else {
                gameStarted = YES;
            }
        }
    }
}

#pragma mark dialog delegate

// quelqun a selectionné un perso
- (void) persoSelected:(int)numPerso fromID:(int)playerID {
    [sliderPersos childAtIndex:numPerso].alpha = 0.5;
    [[sliderPersos childAtIndex:numPerso] removeEventListener:@selector(onTouchPerso:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    if(persoActive != nil) {
        if(persoActive.numPerso == numPerso) {
            [persoActive removeOK];
        }
    }
    
    // ajout au menu
    [self onPersoAdded:numPerso forPlayer:playerID];
}

// lancement de la partie
- (void) gameStart {
    if(persoActive == nil) {
        [[PageManager getInstance] changePage:@"PageTDB"];
    } else {
        gameStarted = YES;
    }
}


- (void)finalize
{
    // event listeners should always be removed to avoid memory leaks!
    [self removeChild:backgroundMask];
    backgroundMask = nil;
    [self removeChild:titre];
    titre = nil;
    [super finalize];
}

@end
