//
//  PagePlay.m
//  ShadukiamGame
//
//  Created by yael on 14/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PagePlay.h"

@implementation PagePlay

- (void) show {
    
    // bouton play
    playBtn = [SPQuad quadWithWidth:200 height:50 color:0x000000];
    playBtn.x = 100;
    playBtn.y = 100;
    
    // init dialog
    connected = NO;
    [Dialog getInstance].delegate = self;
    [[Dialog getInstance] connect];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(checkConnection:) userInfo:nil repeats:NO];
    
}

// si on est pas connecté quelques secondes apres le lancement de l'appli, creation du serveur
-(void)checkConnection:(NSTimer*)timer {
    
    if(!connected) {
        [[Dialog getInstance] createServer];
    }
    
    //kill the timer
    [timer invalidate];
    timer = nil;
    
}

// touch play, lancement partie
-(void)onTouchPlay: (SPTouchEvent*) event {
    [playBtn removeEventListener:@selector(onTouchPlay:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [[Dialog getInstance] sendGameInfoToClients];
}

-(void) finalize {
    [self removeChild:playBtn];
    playBtn = nil;
    
    
}

#pragma mark Dialog Delegate


// connecté au serveur, affichage bouton jouer
- (void) connectedToServ {
    connected = YES;
    
    if([Dialog getInstance].isServer) {
        [self addChild:playBtn];
        [playBtn addEventListener:@selector(onTouchPlay:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }
    
}

// jeu lancé, selection perso
-(void) gameLaunched {
    [[PageManager getInstance] changePage:@"PageSelectPerso"];
}

// client connecté
- (void) clientConnected:(Connection*)connection {
    
}

@end
