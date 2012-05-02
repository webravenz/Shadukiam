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
    
    [super show];
    
    // bouton play
    playBtn = [SPQuad quadWithWidth:200 height:50 color:0x000000];
    playBtn.x = 140;
    playBtn.y = 80;
    
    // texte d'info
    textInfos = [SPTextField textFieldWithWidth:300 height:20 text:@""];
    textInfos.fontName = @"Times new Roman";
    textInfos.color = 0x000000;
    textInfos.fontSize = 16;
    textInfos.x = 90;
    textInfos.y = 140;
    [self addChild:textInfos];
    
    // init dialog
    connected = NO;
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
    
    [self removeChild:textInfos];
    textInfos = nil;
    
}

#pragma mark Dialog Delegate


// connecté au serveur, affichage bouton jouer
- (void) connectedToServ {
    connected = YES;
    
    if([Dialog getInstance].isServer) {
        [self addChild:playBtn];
        [playBtn addEventListener:@selector(onTouchPlay:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        textInfos.text = @"ATTENTE DE JOUEURS";
    } else {
        textInfos.text = @"ATTENTE DU LANCEMENT";
    }
    
}

// jeu lancé, selection perso
-(void) gameLaunched {
    [[PageManager getInstance] changePage:@"PageSelectPerso"];
}

// client connecté
- (void) clientConnected:(Connection*)connection {
    textInfos.text = [NSString stringWithFormat:@"%d joueur(s) connecté", [[Dialog getInstance].clientsID count]];
}

@end
