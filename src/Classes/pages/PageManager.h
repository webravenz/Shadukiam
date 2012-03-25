//
//  PageManager.h
//  ShadukiamGame
//
//  Created by yael on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SPSprite.h"
#import "Page.h"
#import "Game.h"

@interface PageManager : SPSprite {
    Page *currentPage;
}

+(PageManager *)getInstance;
-(void) changePage:(NSString*)pageName;

@end
