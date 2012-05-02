//
//  Plateau.m
//  ShadukiamGame
//
//  Created by yael on 02/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Plateau.h"

@implementation Plateau

static Plateau *instance = nil;

static int NB_CASES_LINE = 10;
static int CASE_WIDTH = 20;
    
+ (Plateau*)getInstance
{
    if (instance == nil) {
        instance = [[super alloc] init];
        [instance initInfos];
    }
    return instance;
}

- (void) initInfos {
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"plateau" ofType:@"xml"]];
    NSError *error = nil;
    XMLData = [XMLReader dictionaryForXMLData:data error:&error];
    
}

// retourne une case a partir son ID
- (NSDictionary*) getCaseByID:(int)caseID {
    return [XMLData retrieveForPath:[NSString stringWithFormat:@"plateau.cases.case.%d", caseID]];
}

// retourne une case a partir de sa position x et y
- (NSDictionary*) getCaseByPos:(int)posX andY:(int)posY {
    int caseID = posY * NB_CASES_LINE + posX;
    return [self getCaseByID:caseID];
}

// retourne une case a partir des coordonnées du pion
- (NSDictionary*) getCaseByCoord: (int) coordX andY: (int) coordY {
    int posY = floor(coordY / CASE_WIDTH);
    if(posY % 2 == 1) coordX += CASE_WIDTH / 2;
    int posX = floor(coordX / CASE_WIDTH);
    
    return [self getCaseByPos:posX andY:posY];
    
}

// retourne une zone a partir son ID
- (NSDictionary*) getZoneByID:(int)zoneID {
    return [XMLData retrieveForPath:[NSString stringWithFormat:@"plateau.zones.zone.%d", zoneID]];
}

// retourne un tableau avec les id des zones possibles en fonction de l'actuelle et le nombre de deplacements
- (NSMutableArray*) getZonesAccessible:(int)zoneID nbMoves: (int)moves {
    
    NSMutableArray *accessibles = [NSMutableArray array];
    
    NSDictionary *currentZone = [self getZoneByID:zoneID];
    
    [self getZonesAccessibleRec:currentZone nbMoves:moves currLevel:0 withArray: accessibles];
    
    return accessibles;
}

-(void) getZonesAccessibleRec:(NSDictionary*) currZone nbMoves: (int) moves currLevel: (int)level withArray:(NSMutableArray*) accessibles {
    if(level < moves) {
        NSDictionary *voisins = [currZone retrieveForPath:@"voisins.voisin"];
    
        NSEnumerator *voisinsEnum = [voisins objectEnumerator];
        NSString *voisinStr;
    
        while(voisinStr = [voisinsEnum nextObject]) {
            if(![accessibles containsObject:voisinStr]) {
                [accessibles addObject:voisinStr];
            }
            
            NSDictionary* zoneVoisine = [self getZoneByID:[voisinStr intValue]];
            [self getZonesAccessibleRec:zoneVoisine nbMoves:moves currLevel:level + 1 withArray:accessibles];
        }
    }
    
}

@end
