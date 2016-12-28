//
//  sportViewController.h
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/27/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "roster.h"
#import "MWFeedParser.h"

@interface sportViewController : UIViewController <MWFeedParserDelegate> {
    
    MWFeedParser *feedParser;
    NSMutableArray *parsedItems;
    

    
}

@property (weak, nonatomic) IBOutlet UIView *sportContentView;
@property (weak, nonatomic) IBOutlet UIScrollView *sportScrollView;
@property NSArray * rssArray;
@property NSURL * feedURL;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *storyButton;

//Methods
-(void)setupMen;
-(void)setupWomen;


@end
