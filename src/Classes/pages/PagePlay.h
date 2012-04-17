//
//  PagePlay.h
//  ShadukiamGame
//
//  Created by yael on 14/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Page.h"
#import "PageManager.h"

@interface PagePlay : Page <DialogDelegate> {
    
    SPQuad *playBtn;
    bool connected;
    
}

@end
