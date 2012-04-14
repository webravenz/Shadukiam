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
    
    // init slider
    sliderPersos = [[Slider alloc] initWithWidth:3 * 210 height:[Game stageHeight]];
    [self addChild:sliderPersos];
    sliderPersos.y = 30;
    
    // init fiches
    for(int i = 1; i < 4; i++) {
        SPImage *ficheMini = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"ficheperso_mini_%d.png", i]];
        [sliderPersos addChild:ficheMini];
        ficheMini.x = (i * 210) - 170;
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
            [self showPerso];
        }
    }
    
}

// affichage d'une fiche perso en grand
- (void) showPerso {
    
    [self addChild:backgroundMask];
    
    // init fiche
    persoActive = [[FichePerso alloc] init ];
    [persoActive initWithPerso:2];
    
    persoActive.x = ([Game stageWidth] - persoActive.width) / 2;
    persoActive.y = ([Game stageHeight] - persoActive.height) / 2 + 30;
    persoActive.alpha = 0;
    [self addChild:persoActive];
    
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
    
}

- (void) onClosePersoCompleted:(SPEvent*)event {
    
    [event.currentTarget removeEventListener:@selector(onClosePersoCompleted:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    
    [self removeChild:persoActive];
    persoActive = nil;
    [self removeChild:backgroundMask];
    backgroundMask.alpha = 0;
    
}


- (void)finalize
{
    // event listeners should always be removed to avoid memory leaks!
    [self removeChild:backgroundMask];
    backgroundMask = nil;
    [super finalize];
}

@end
