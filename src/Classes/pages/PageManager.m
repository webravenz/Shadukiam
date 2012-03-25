//
//  PageManager.m
//  ShadukiamGame
//
//  Created by yael on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PageManager.h"

@implementation PageManager

static PageManager *instance = nil;


+ (PageManager*)getInstance
{
    if (instance == nil) {
        instance = [[super alloc] init];
    }
    return instance;
}

-(void) changePage:(NSString*)pageName {
    
    if(currentPage != nil) {
        [self removeChild:currentPage];
        currentPage = nil;
    }
    
    Class sceneClass = NSClassFromString(pageName);
    
    // create an instance of that class and add it to the display tree.
    currentPage = [[sceneClass alloc] init];
    [self addChild:currentPage];
    [currentPage show];

}

@end
