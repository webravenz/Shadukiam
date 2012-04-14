//
//  FichePerso.m
//  ShadukiamGame
//
//  Created by yael on 10/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FichePerso.h"

@implementation FichePerso

- (void) initWithPerso:(int)numPerso {
    
    isFront = YES;
    
    // general : background / boutons
    general = [SPSprite sprite];
    
    background = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"ficheperso_bkg_%d.png", numPerso]];
    [general addChild:background];
    
    retourneBtn = [SPImage imageWithContentsOfFile:@"retourne.png"];
    [general addChild:retourneBtn];
    retourneBtn.x = 60;
    retourneBtn.y = 110;
    
    okBtn = [SPImage imageWithContentsOfFile:@"valide.png"];
    [general addChild:okBtn];
    okBtn.x = 330;
    okBtn.y = 110;
    
    [self addChild:general];
    
    // front : portrait + nom
    front = [SPSprite sprite];
    [self addChild:front];
    
    portrait = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"ficheperso_illu_%d.png", numPerso]];
    [front addChild:portrait];
    portrait.x = (background.width - portrait.width) / 2;
    portrait.y = 10;
    
    nom = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"ficheperso_nom_%d.png", numPerso]];
    [front addChild:nom];
    nom.x = (background.width - nom.width) / 2;
    nom.y = 200;
    
    // back : nom et texte
    back = [SPSprite sprite];
    [self addChild:back];
    back.x = background.width / 2;
    back.scaleX = 0;
    
    nomBack = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"ficheperso_nom_%d.png", numPerso]];
    [back addChild:nomBack];
    nomBack.x = (background.width - nomBack.width) / 2;
    nomBack.y = 30;
    
    // listeners
    [retourneBtn addEventListener:@selector(onTouchRetourne:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [okBtn addEventListener:@selector(onTouchOk:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
}

- (void)onTouchRetourne:(SPTouchEvent*) event {
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    
    if(touches.count == 1) {
        SPTween *tweenGeneral = [SPTween tweenWithTarget:general time:0.25f transition:SP_TRANSITION_EASE_IN];
        [tweenGeneral animateProperty:@"scaleX" targetValue:0];
        [tweenGeneral animateProperty:@"x" targetValue:background.width / 2];
        
        SPTween *tweenGeneral2 = [SPTween tweenWithTarget:general time:0.25f transition:SP_TRANSITION_EASE_OUT];
        tweenGeneral2.delay = 0.25f;
        [tweenGeneral2 animateProperty:@"scaleX" targetValue:1];
        [tweenGeneral2 animateProperty:@"x" targetValue:0];
    
        SPTween *tweenFront;
        SPTween *tweenBack;
        
        if(isFront) {
            // passage au back de la carte
            tweenFront = [SPTween tweenWithTarget:front time:0.25f transition:SP_TRANSITION_EASE_IN];
            [tweenFront animateProperty:@"scaleX" targetValue:0];
            [tweenFront animateProperty:@"x" targetValue:background.width / 2];
            
            tweenBack = [SPTween tweenWithTarget:back time:0.25f transition:SP_TRANSITION_EASE_OUT];
            tweenBack.delay = 0.25f;
            [tweenBack animateProperty:@"scaleX" targetValue:1];
            [tweenBack animateProperty:@"x" targetValue:0];
            
        } else {
            // passage au front
            tweenFront = [SPTween tweenWithTarget:front time:0.25f transition:SP_TRANSITION_EASE_OUT];
            tweenFront.delay = 0.25f;
            [tweenFront animateProperty:@"scaleX" targetValue:1];
            [tweenFront animateProperty:@"x" targetValue:0];
            
            tweenBack = [SPTween tweenWithTarget:back time:0.25f transition:SP_TRANSITION_EASE_IN];
            [tweenBack animateProperty:@"scaleX" targetValue:0];
            [tweenBack animateProperty:@"x" targetValue:background.width / 2];
        }
    
        isFront = !isFront;
    
        [self.stage.juggler addObject:tweenGeneral];
        [self.stage.juggler addObject:tweenGeneral2];
        [self.stage.juggler addObject:tweenFront];
        [self.stage.juggler addObject:tweenBack];
    }
}

-(void) onTouchOk:(SPTouchEvent*) event {
    [self dispatchEvent:[SPEvent eventWithType:@"touchOK"]];
}

- (void)finalize
{
    // event listeners should always be removed to avoid memory leaks!
    [general removeChild:background];
    background = nil;
    
    [retourneBtn removeEventListener:@selector(onTouchRetourne:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [general removeChild:retourneBtn];
    retourneBtn = nil;
    
    [self removeChild:general];
    general = nil;
    
    [front removeChild:portrait];
    portrait = nil;
    
    [front removeChild:nom];
    nom = nil;
    
    [self removeChild:front];
    front = nil;
    
    [back removeChild:nomBack];
    nomBack = nil;
    
    [self removeChild:back];
    back = nil;
    
    [super finalize];
}

@end
