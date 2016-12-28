//
//  sportViewController.m
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/27/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import "sportViewController.h"
#import "roster.h"
#import "rosterViewController.h"
#import "MWFeedParser.h"
#import "MWFeedItem.h"
#import "MWFeedInfo.h"
#import "NSString+HTML.h"
#import "AppDelegate.h"

@interface sportViewController ()

@end

@implementation sportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //Setup
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults boolForKey:@"gender"]){
        [self setupMen];
        self.rssArray = appDelegate.menRSSArray;
    }
    
    else {
        [self setupWomen];
        self.rssArray = appDelegate.womenRSSArray;
    }
    
    
    [self getRSS];
    
    
    //Set tab bar image and title
    [[self.tabBarController.tabBar.items objectAtIndex:1] initWithTitle: @"Schedule" image:[UIImage imageNamed:@"schedule"] tag: 1];
    
    [[self.tabBarController.tabBar.items objectAtIndex:2] initWithTitle: @"Roster" image:[UIImage imageNamed:@"roster"] tag: 2];
    
    [[self.tabBarController.tabBar.items objectAtIndex:3] initWithTitle: @"Standings" image:[UIImage imageNamed:@"standings"] tag: 3];
    
    
    //Scroll View
    [self.sportScrollView layoutIfNeeded];
    self.sportScrollView.contentSize = self.sportContentView.bounds.size;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.00 green:0.22 blue:0.44 alpha:0.95];
    self.sportContentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.22 blue:0.44 alpha:0.95];
    self.sportScrollView.backgroundColor = [UIColor colorWithRed:0.00 green:0.22 blue:0.44 alpha:0.95];

}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*setupMen:
 * Load men's stories, roster, schedule
 */
-(void)setupMen {
    self.title = @"Men's Basketball Headlines";
    [self.tabBarController setTitle:@"Men's Basketball"];
    [[self.tabBarController.tabBar.items objectAtIndex:0] setTitle:@"Men's Basketball"];
    [[self.tabBarController.tabBar.items objectAtIndex:0] initWithTitle: @"Men's Basketball" image:[UIImage imageNamed:@"basketball"] tag: 0];
}

/*setupWomen:
 * Load women's stories, roster, schedule
 */
-(void)setupWomen {
    [self.tabBarController setTitle:@"Women's Basketball"];
    //[[self.tabBarController.tabBar.items objectAtIndex:0] setTitle:@"Women's Basketball"];
    
    [[self.tabBarController.tabBar.items objectAtIndex:0] initWithTitle: @"Women's Basketball" image:[UIImage imageNamed:@"basketball"] tag: 0];
    
}

-(void)getRSS {
    for (int i = 0; i < 5; i++){
        NSArray *item = self.rssArray[i];
        UIButton *button = self.storyButton[i];
        
        //Set title
        NSString *title = [item[0] stringByDecodingHTMLEntities];
        [button setTitle: title forState: UIControlStateNormal];
        
        //Set image + Floor Fade
        UIImage * storyImage = item[1];
        
        CAGradientLayer *bottomFade = [CAGradientLayer layer];
        bottomFade.frame = CGRectMake(0.0, CGRectGetHeight(button.bounds), CGRectGetWidth(button.bounds), -(CGRectGetHeight(button.bounds) / 2.0));
        bottomFade.startPoint = CGPointMake(0.35, 1.0);
        bottomFade.endPoint = CGPointMake(0.35, 0.0);
        bottomFade.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0.0 alpha:0.5f] CGColor], (id) [[UIColor colorWithWhite:0.0 alpha:0.0f] CGColor], nil];
        
        [button.layer addSublayer:bottomFade];
        
        
        
        
        [button setBackgroundImage:storyImage forState:UIControlStateNormal];
        
        
        
        
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 10, -80, 0);
        button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        button.titleLabel.numberOfLines = 2;
    
    }
}



@end
