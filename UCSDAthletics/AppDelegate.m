//
//  AppDelegate.m
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/21/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import "AppDelegate.h"
#import "MWFeedParser.h"
#import "MWFeedItem.h"
#import "MWFeedInfo.h"
#import "NSString+HTML.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.mBballRoster = [[roster alloc]init];
    [self.mBballRoster buildRoster: true];
    
    self.wBballRoster = [[roster alloc]init];
    [self.wBballRoster buildRoster: false];
    
    self.womenRSSArray = [[NSMutableArray alloc] init];
    self.menRSSArray = [[NSMutableArray alloc] init];
    self.womenTeamPlayer = self.wBballRoster.teamPlayer;
    self.menTeamPlayer = self.mBballRoster.teamPlayer;
    
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ucsd_logo"] forBarMetrics:UIBarMetricsDefault];

    
    
    [self getRSS];
    
    self.wPastGames = [[NSMutableArray alloc] init];
    self.wUpcomingGames = [[NSMutableArray alloc] init];
    
    self.mPastGames = [[NSMutableArray alloc] init];
    self.mUpcomingGames = [[NSMutableArray alloc] init];
    
    [self getPastGames];
    [self getUpcomingGames];
    
    //NSLog(@"%d", [self.allGames count]);
    
    for (NSArray* array in self.wUpcomingGames){
        NSLog(@"%@: %@", array[0], array[1]);
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)getRSS {
    
    //Go through men RSS
    parsedItems = [[NSMutableArray alloc] init];
    feedParser = [[MWFeedParser alloc] initWithFeedURL:[NSURL URLWithString:@"http://www.ucsdtritons.com/rss.dbml?db_oem_id=5800&RSS_SPORT_ID=2337&media=news"]];
    feedParser.delegate = self;
    feedParser.feedParseType = ParseTypeFull;
    feedParser.connectionType = ConnectionTypeSynchronously;
    [feedParser parse];
    
    
    for (int i = 0; i < 5; i++){
        MWFeedItem *item = parsedItems[i];
        
        //Get title (NSString
        NSString *title = item.title ? [item.title stringByDecodingHTMLEntities]: @"[No Title]";
        
        //Get image (UIImage)
        NSArray * enclosureArray = item.enclosures;
        NSDictionary *enclosureDict = enclosureArray[0];
        NSURL * imageUrl = [NSURL URLWithString:[enclosureDict valueForKey:@"url"]];
        NSData * data = [[NSData alloc] initWithContentsOfURL:imageUrl];
        UIImage * storyImage = [[UIImage alloc] initWithData:data];
        
        //Get link (NSURL)
        NSURL * linkURL = [NSURL URLWithString:item.link];
        
        NSArray *itemEntry = [NSArray arrayWithObjects: title, storyImage, linkURL, nil];
        [self.menRSSArray addObject:itemEntry];
    }
    
    //Refresh
    [parsedItems removeAllObjects];
    [feedParser stopParsing];
    
    
    //Go through women RSS
    feedParser = [[MWFeedParser alloc] initWithFeedURL:[NSURL URLWithString:@"http://www.ucsdtritons.com/rss.dbml?db_oem_id=5800&RSS_SPORT_ID=2338&media=news"]];
    feedParser.delegate = self;
    feedParser.feedParseType = ParseTypeFull;
    feedParser.connectionType = ConnectionTypeSynchronously;
    [feedParser parse];
    
    for (int i = 0; i < 5; i++){
        MWFeedItem *item  = parsedItems[i];
        
        //Get title (NSString)
        NSString *title = item.title ? [item.title stringByDecodingHTMLEntities]: @"[No Title]";
        
        //Get image (UIImage)
        NSArray * enclosureArray = item.enclosures;
        NSDictionary *enclosureDict = enclosureArray[0];
        NSURL * imageUrl = [NSURL URLWithString:[enclosureDict valueForKey:@"url"]];
        NSData * data = [[NSData alloc] initWithContentsOfURL:imageUrl];
        UIImage * storyImage = [[UIImage alloc] initWithData:data];
        
        //Get link (NSURL)
        NSURL * linkURL = [NSURL URLWithString:item.link];
        
        //Get date (NSDate)
        NSDate *date = item.date;
        
        NSArray *itemEntry = [NSArray arrayWithObjects: title, storyImage, linkURL, date, nil];
        [self.womenRSSArray addObject:itemEntry];
    }
}

-(void) getPastGames {
    [parsedItems removeAllObjects];
    [feedParser stopParsing];
    
    feedParser = [[MWFeedParser alloc] initWithFeedURL: [NSURL URLWithString: @"http://www.ucsdtritons.com/rss.dbml?db_oem_id=5800&RSS_SPORT_ID=2337&media=results"]];
    
    feedParser.delegate = self;
    feedParser.feedParseType = ParseTypeFull;
    feedParser.connectionType = ConnectionTypeSynchronously;
    [feedParser parse];
    
    for (int i = 0; i < [parsedItems count]; i++){
        MWFeedItem *item = parsedItems[i];
        NSString *title = item.title ? [item.title stringByDecodingHTMLEntities]: @"[No Title]";
        
        //Get Description
        
        NSString * description = [item summary];
        
        
        NSArray *itemEntry = [NSArray arrayWithObjects: title, description, nil];
        [self.mPastGames addObject:itemEntry];
    }
    
    
    //Get women
    [parsedItems removeAllObjects];
    [feedParser stopParsing];
    
    feedParser = [[MWFeedParser alloc] initWithFeedURL: [NSURL URLWithString: @"http://www.ucsdtritons.com/rss.dbml?db_oem_id=5800&RSS_SPORT_ID=2338&media=results"]];
    
    feedParser.delegate = self;
    feedParser.feedParseType = ParseTypeFull;
    feedParser.connectionType = ConnectionTypeSynchronously;
    [feedParser parse];
    
    for (int i = 0; i < [parsedItems count]; i++){
        MWFeedItem *item = parsedItems[i];
        NSString *title = item.title ? [item.title stringByDecodingHTMLEntities]: @"[No Title]";
       
        
        //Get Description
        
        NSString * description = [item summary];
        
        
        NSArray *itemEntry = [NSArray arrayWithObjects: title, description, nil];
        [self.wPastGames insertObject:itemEntry atIndex:0];
    }
    
    
    
}


-(void) getUpcomingGames {
    [parsedItems removeAllObjects];
    [feedParser stopParsing];
    
    feedParser = [[MWFeedParser alloc] initWithFeedURL: [NSURL URLWithString: @"http://www.ucsdtritons.com/rss.dbml?db_oem_id=5800&RSS_SPORT_ID=2337&media=schedules"]];
    
    feedParser.delegate = self;
    feedParser.feedParseType = ParseTypeFull;
    feedParser.connectionType = ConnectionTypeSynchronously;
    [feedParser parse];
    
    for (int i = 0; i < [parsedItems count]; i++){
        MWFeedItem *item = parsedItems[i];
        NSString *title = item.title ? [item.title stringByDecodingHTMLEntities]: @"[No Title]";
        
        //Get Description
        
        NSString * description = [item summary];
        
        
        NSArray *itemEntry = [NSArray arrayWithObjects: title, description, nil];
        [self.mUpcomingGames addObject:itemEntry];
    }
    
    
        
    //Women upcoming games
    [parsedItems removeAllObjects];
    [feedParser stopParsing];
        
    feedParser = [[MWFeedParser alloc] initWithFeedURL: [NSURL URLWithString: @"http://www.ucsdtritons.com/rss.dbml?db_oem_id=5800&RSS_SPORT_ID=2338&media=schedules"]];
        
    feedParser.delegate = self;
    feedParser.feedParseType = ParseTypeFull;
    feedParser.connectionType = ConnectionTypeSynchronously;
    [feedParser parse];
        
    for (int i = 0; i < [parsedItems count]; i++){
        MWFeedItem *item = parsedItems[i];
        NSString *title = item.title ? [item.title stringByDecodingHTMLEntities]: @"[No Title]";
            
        //Get Description
            
        NSString * description = [item summary];
            
            
        NSArray *itemEntry = [NSArray arrayWithObjects: title, description, nil];
        [self.wUpcomingGames addObject:itemEntry];
    }
}



- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    NSLog(@"Parsed Feed Item: “%@”", item.title);
    if (item) [parsedItems addObject:item];
}

@end
