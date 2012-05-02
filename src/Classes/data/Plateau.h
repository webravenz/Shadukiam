//
//  Plateau.h
//  ShadukiamGame
//
//  Created by yael on 02/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLReader.h"

@interface Plateau : NSObject {
    
    NSDictionary *XMLData;
    
}

+(Plateau *)getInstance;
- (void) initInfos;

- (NSDictionary*) getCaseByID: (int) caseID;
- (NSDictionary*) getCaseByPos: (int) posX andY: (int) posY;
- (NSDictionary*) getCaseByCoord: (int) coordX andY: (int) coordY;

- (NSDictionary*) getZoneByID: (int) zoneID;
- (NSMutableArray*) getZonesAccessible:(int)zoneID nbMoves: (int)moves;
-(void) getZonesAccessibleRec:(NSDictionary*) currZone nbMoves: (int) moves currLevel: (int)level withArray:(NSMutableArray*) accessibles;

@end
