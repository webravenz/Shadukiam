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
    
    [super show];
    
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
    
    buttons = [SPSprite sprite];
    [self addChild:buttons];
    
    btnInventaire = [[TDBBtn alloc] initWithText:@"INVENTAIRE"];
    btnInventaire.x = 80;
    btnInventaire.y = 45;
    [buttons addChild:btnInventaire];
    btnInventaire.name = @"PageInventaire";
    [btnInventaire addEventListener:@selector(onTouchBtn:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    btnPouvoir = [[TDBBtn alloc] initWithText:@"POUVOIR"];
    btnPouvoir.x = 80;
    btnPouvoir.y = 120;
    [buttons addChild:btnPouvoir];
    
    btnEnigme = [[TDBBtn alloc] initWithText:@"ENIGMES"];
    btnEnigme.x = 80;
    btnEnigme.y = 195;
    [buttons addChild:btnEnigme];
    
    btnMessagerie = [[TDBBtn alloc] initWithText:@"MESSAGERIE"];
    btnMessagerie.x = 340;
    btnMessagerie.y = 75;
    [buttons addChild:btnMessagerie];
    
    btnIntuition = [[TDBBtn alloc] initWithText:@"INTUITION"];
    btnIntuition.x = 340;
    btnIntuition.y = 165;
    [buttons addChild:btnIntuition];
    
    btnLancer = [[TDBBtn alloc] initWithText:@"LANCER"];
    btnLancer.x = 340;
    btnLancer.y = 255;
    [buttons addChild:btnLancer];
    btnLancer.name = @"PageDice";
    [btnLancer addEventListener:@selector(onTouchBtn:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    // anim
    titre.alpha = 0;
    titre.y = -20;
    SPTween* tweenTitre = [SPTween tweenWithTarget:titre time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenTitre setDelay:0.5f];
    [tweenTitre animateProperty:@"alpha" targetValue:1];
    [tweenTitre animateProperty:@"y" targetValue:3];
    
    
    persoImg.alpha = 0;
    persoImg.y = 60;
    persoImg.x += 10;
    persoImg.scaleX = 0.7;
    persoImg.scaleY = 0.7;
    SPTween* tweenPerso = [SPTween tweenWithTarget:persoImg time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenPerso setDelay:0.75f];
    [tweenPerso animateProperty:@"alpha" targetValue:1];
    [tweenPerso animateProperty:@"y" targetValue:50];
    [tweenPerso animateProperty:@"x" targetValue:persoImg.x - 10];
    [tweenPerso animateProperty:@"scaleX" targetValue:0.8];
    [tweenPerso animateProperty:@"scaleY" targetValue:0.8];
    
    buttons.alpha = 0;
    buttons.y = 5;
    SPTween* tweenButtons = [SPTween tweenWithTarget:buttons time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenButtons setDelay:1];
    [tweenButtons animateProperty:@"alpha" targetValue:1];
    [tweenButtons animateProperty:@"y" targetValue:0];
    
    [self.stage.juggler addObject:tweenTitre];
    [self.stage.juggler addObject:tweenPerso];
    [self.stage.juggler addObject:tweenButtons];
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
            targetPage = btnTouch.name;
            [self animQuit];
        }
    }
    
}

// anim pour quitter la page
-(void) animQuit {
    
    SPTween* tweenTitre = [SPTween tweenWithTarget:titre time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenTitre animateProperty:@"alpha" targetValue:0];
    [tweenTitre animateProperty:@"y" targetValue:-15];
    
    SPTween* tweenPerso = [SPTween tweenWithTarget:persoImg time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenPerso animateProperty:@"alpha" targetValue:0];
    [tweenPerso animateProperty:@"y" targetValue:60];
    [tweenPerso animateProperty:@"x" targetValue:persoImg.x + 10];
    [tweenPerso animateProperty:@"scaleX" targetValue:0.7];
    [tweenPerso animateProperty:@"scaleY" targetValue:0.7];
    
    SPTween* tweenButtons = [SPTween tweenWithTarget:buttons time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenButtons animateProperty:@"alpha" targetValue:0];
    [tweenButtons animateProperty:@"y" targetValue:5];
    
    [self.stage.juggler addObject:tweenTitre];
    [self.stage.juggler addObject:tweenPerso];
    [self.stage.juggler addObject:tweenButtons];
    
    [NSTimer scheduledTimerWithTimeInterval:0.75 target:self selector:@selector(goNextPage:) userInfo:nil repeats:NO];
}

-(void) goNextPage:(NSTimer*) timer {
    
    [[PageManager getInstance] changePage:targetPage];
    
    //kill the timer
    [timer invalidate];
    timer = nil;
}

-(void) finalize {
    [self removeChild:titre];
    titre = nil;
    
    [self removeChild:persoImg];
    persoImg = nil;
    
    [self removeChild:btnInventaire];
    [btnInventaire removeEventListener:@selector(onTouchBtn:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
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
