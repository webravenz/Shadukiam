//
//  Dialog.m
//  
//
//  Created by Jérémy Petrequin on 12/02/12.
//

#import "Dialog.h"

@implementation Dialog

@synthesize delegate;
@synthesize isServer;
@synthesize clientsID;
@synthesize myID;

static Dialog *instance = nil;


+ (Dialog*)getInstance
{
    if (instance == nil) {
        instance = [[super alloc] init];
    }
    return instance;
}

// connexion, recherche de serveur existant
- (void) connect {
    
    myID = 0;
    
    isServer = NO;
    
    serverBrowser = [[ServerBrowser alloc] init];
    serverBrowser.delegate = self;
    
    [serverBrowser start];
    
}

// creation serveur
- (void) createServer {
    
    [serverBrowser stop];
    
    server = [[Server alloc] init];
    server.delegate = self;
    [server start];
    
    if ([server start]) {
        clients = [[NSMutableSet alloc] init];
        clientsID = [[NSMutableArray alloc] init];
        nextClientID = 2;
        isServer = YES;
        myID = 1;
        
        [delegate connectedToServ];
    } else {
        server = nil;
    }
    
}

// deconnexion
-(void) disconnect {
    if(server != nil) {
        [server stop];
        server = nil;
    }
}

// nombre de joueurs connectes
- (int) nbJoueurs {
    return [clients count];
}

#pragma mark ServerBrowser delegate - recherche de serveur

// recuperation de la liste des serveurs
- (void)updateServerList {
    // connexion au serveur si il existe
    if([serverBrowser.servers count] > 0) {
        NSNetService* service = [serverBrowser.servers objectAtIndex:0];
        
        connectionClient = [[Connection alloc] initWithNetService:service];
        
        if([connectionClient connect]) {
            [serverBrowser stop];
            
            connectionClient.delegate = self;
            
            [delegate connectedToServ];
        }
    } else {
        NSLog(@"Aucun serveur trouvé");
    }
    
}

#pragma mark Server delegate - reception d'infos quand on est le serveur

// Server has failed. Stop the world.
- (void) serverFailed:(Server*)server reason:(NSString*)reason {
    // Stop everything and let our delegate know
    [server stop];
    NSLog(reason);
}

// New client connected to our server. Add it.
- (void) handleNewConnection:(Connection*)connection {
    NSLog(@"client connect");
    // Delegate everything to us
    connection.delegate = self;
    
    // Add to our list of clients
    NSNumber* nextClientIDPointer = [NSNumber numberWithInt:nextClientID];
    [clientsID addObject:nextClientIDPointer];
    connection.clientID = nextClientID;
    [clients addObject:connection];
    
    nextClientID++;
    
    [delegate clientConnected:connection];
}

#pragma mark envoi de donnees

// Send chat message to all or 1 client
- (void)sendMessage:(NSString*)commande sendTo:(int)sendTo data:(id)data {
    
    // Create network packet to be sent
    NSNumber* clientIDPointer = [NSNumber numberWithInt:myID];
    NSNumber* toIDPointer = [NSNumber numberWithInt:sendTo];
    NSDictionary* packet = [NSDictionary dictionaryWithObjectsAndKeys:commande, @"commande", data, @"data",
                            clientIDPointer, @"fromid", toIDPointer, @"toid", nil];
    
    // si on est le serveur
    if(isServer) {
        // si il faut envoyer a tous
        if(sendTo == -1) {
            [clients makeObjectsPerformSelector:@selector(sendNetworkPacket:) withObject:packet];
        } else {
            // envoi a un client particulier
            NSArray* clientsArray = [clients allObjects];
            
            for(int i = 0; i < [clientsArray count]; i++) {
                
                Connection* client = [clientsArray objectAtIndex:i];
                
                if(client.clientID == sendTo) {
                    [client sendNetworkPacket:packet];
                }
            }
        }
    }
    // le client envoie au serveur
    else {
        [connectionClient sendNetworkPacket:packet];
    }
}

// au lancement de la partie envoi a chaque joueur son id et la liste des joueurs
- (void)sendGameInfoToClients {
    
    NSArray* clientsArray = [clients allObjects];
    
    for(int i = 0; i < [clientsArray count]; i++) {
        
        Connection* client = [clientsArray objectAtIndex:i];
        
        // Create network packet for this client
        
        NSNumber* clientIDPointer = [NSNumber numberWithInt:client.clientID];
        NSNumber* toID = [NSNumber numberWithInt:-1];
        NSDictionary* packet = [NSDictionary dictionaryWithObjectsAndKeys:@"gamelaunched", @"commande",
                                clientsID, @"data", clientIDPointer, @"fromid", toID, @"toid", nil];
        
        [client sendNetworkPacket:packet];
    }
    
    [delegate gameLaunched];
    
}

# pragma mark connection delegate

// le client recoit un message du serveur, ou le serveur recoit un message d'un des clients
- (void)receivedNetworkPacket:(NSDictionary*)packet viaConnection:(Connection*)connection {
    NSString* commande = [packet objectForKey:@"commande"];
    
    // si ca vient pas de nous et c'est pour nous
    NSNumber* toID = [packet objectForKey:@"toid"];
    NSNumber* fromID = [packet objectForKey:@"fromid"];
    if([fromID intValue] != myID && ([toID intValue] == -1 || [toID intValue] == myID)) {
        
        if([commande isEqualToString:@"message"]) {
            [delegate receiveMessage:[packet objectForKey:@"data"]];
        } 
        // lancement du jeu, recuperation de la liste des id des joueurs et du sien
        else if([commande isEqualToString:@"gamelaunched"]) {
            clientsID = [packet objectForKey:@"data"];
            [clientsID addObject: [NSNumber numberWithInt:1]];
            myID = [fromID intValue];
            [delegate gameLaunched];
        }
        // quelqun a selectionné un perso
        else if([commande isEqualToString:@"persoSelected"]) {
            NSString *numStr = [packet objectForKey:@"data"];
            NSLog(numStr);
            int num = [numStr intValue];
            NSLog(@"%d", num);
            [delegate persoSelected:num];
        }
        
    }
    
    // si on est le serveur on retransmet
    if(isServer) {
        [clients makeObjectsPerformSelector:@selector(sendNetworkPacket:) withObject:packet];
    }
    
}


// One of the clients disconnected, remove it from our list
- (void) connectionTerminated:(Connection*)connection {
    if(isServer) {
        //[clients removeObject:connection];
        //[clientsID removeObject:connection.clientID];
    }
}

@end
