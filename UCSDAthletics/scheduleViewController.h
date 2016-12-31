//
//  scheduleViewController.h
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/29/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface scheduleViewController : UIViewController

@property NSMutableArray* pastGames;
@property NSMutableArray* upcomingGames;
@property UIScrollView * scrollView;
@property UIStackView * contentView;
@property int y;

-(void)createPastGameTiles;
-(void)createUpcomingGameTiles;
-(NSString *)getStatsURL:(int) i;
-(NSArray *) getUpcomingGameDetail: (int) i;

@end
