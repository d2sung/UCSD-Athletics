//
//  AppDelegate.h
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/21/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "roster.h"
#import "playerProfile.h"
#import "MWFeedParser.h"
#import "MWFeedItem.h"
#import "MWFeedInfo.h"
#import "NSString+HTML.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, MWFeedParserDelegate>{
    MWFeedParser *feedParser;
    NSMutableArray *parsedItems;
    
}

@property roster * mBballRoster;
@property roster * wBballRoster;
@property NSMutableArray * womenRSSArray;
@property NSMutableArray * menRSSArray;
@property playerProfile * womenTeamPlayer;
@property playerProfile * menTeamPlayer;

@property NSMutableArray *wPastGames;
@property NSMutableArray *wUpcomingGames;

@property NSMutableArray *mPastGames;
@property NSMutableArray *mUpcomingGames;




@property (strong, nonatomic) UIWindow *window;

-(void) getRSS;


@end

