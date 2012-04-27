//
//  Dialog.h
//  
//
//  Created by Jérémy Petrequin on 12/02/12.
//

#import <Foundation/Foundation.h>
#import "Server.h"
#import "ServerBrowser.h"
#import "Connection.h"
#import "ServerBrowserDelegate.h"

@class Dialog;

@protocol DialogDelegate

- (void) connectedToServ; // connecté au serveur, qu'on soit le serveur ou pas
- (void) clientConnected:(Connection*)connection;
- (void) receiveMessage:(NSString*)message;
- (void) gameLaunched;
- (void) persoSelected:(int)numPerso fromID:(int)playerID;
- (void) gameStart;

@end

@interface Dialog : NSObject {
    id<DialogDelegate> delegate;
    
    // server
    ServerBrowser* serverBrowser;
    Server* server;
    NSMutableSet* clients;
    int nextClientID;
    
    // client
    Connection* connectionClient;
    
    // both
    BOOL isServer;
    NSMutableArray* clientsID;
    int myID;
    
}

@property(nonatomic,strong) id<DialogDelegate> delegate;
@property BOOL isServer;
@property (strong) NSMutableArray* clientsID;
@property int myID;

+(Dialog *)getInstance;
- (void) connect; 
- (void) createServer;
- (void) disconnect;
- (void)sendMessage:(NSString*)commande sendTo:(int)sendTo data:(id)data;
- (int) nbJoueurs;
- (void)sendGameInfoToClients;

@end
