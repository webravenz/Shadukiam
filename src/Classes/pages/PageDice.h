//
//  PageDice.h
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 02/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "Page.h"
#import "Titre.h"
#import "PageManager.h"
#import "Roue.h"

@interface PageDice : Page {
    
    Titre *titre;
    Roue *roue1;
    Roue *roue2;
    SPPoint *start;
    CGFloat velocity;
    CGFloat velocity2;
    NSTimeInterval previousTime;
    NSString *targetPage;
}

-(CGFloat) DistanceBetweenTwoPoints:(SPPoint*) point1 withPoint2:(SPPoint*) point2;

-(void) result;
@end
