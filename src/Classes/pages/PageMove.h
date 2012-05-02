//
//  PageMove.h
//  ShadukiamGame
//
//  Created by yael on 02/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Page.h"
#import "Titre.h"
#import "Plateau.h"

@interface PageMove : Page {
    
    Titre *titre;
    NSDictionary *currentCase;
    NSMutableArray *casesAccessibles;
    
}

@end
