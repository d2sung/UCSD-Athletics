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
#import "storyViewController.h"

@interface sportViewController ()

@end

@implementation sportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Scroll View
    [self.sportScrollView layoutIfNeeded];
    self.sportScrollView.contentSize = self.sportContentView.bounds.size;
    
    
    //Create AppDelegate and NSUserDefaults objects
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
    [self style];
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
    [[self.tabBarController.tabBar.items objectAtIndex:0] initWithTitle: @"Men's Basketball" image:[UIImage imageNamed:@"basketball"] tag: 0];
}

/*setupWomen:
 * Load women's stories, roster, schedule
 */
-(void)setupWomen {
    [self.tabBarController setTitle:@"Women's Basketball"];
    [[self.tabBarController.tabBar.items objectAtIndex:0] initWithTitle: @"Women's Basketball" image:[UIImage imageNamed:@"basketball"]tag:0];
    
}


-(void)getRSS {
    //Set RSS items to corresponding buttons
    for (int i = 0; i < 5; i++){
        NSArray *item = self.rssArray[i];
        UIButton *button = self.storyButton[i];
        
        //Set title
        NSString *title = [item[0] stringByDecodingHTMLEntities];
        
        
        //Set image
        UIImage * storyImage = item[1];
        [button setBackgroundImage:storyImage forState:UIControlStateNormal];
        
        //Floor Fade
        CAGradientLayer *bottomFade = [CAGradientLayer layer];
        bottomFade.frame = CGRectMake(0.0, CGRectGetHeight(button.bounds), CGRectGetWidth(button.bounds), -(CGRectGetHeight(button.bounds) / 3.5));
        bottomFade.startPoint = CGPointMake(0.5, 1.0);
        bottomFade.endPoint = CGPointMake(0.5, 0.0);
        bottomFade.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0.6f alpha:0.4f] CGColor], (id)[[UIColor colorWithWhite:0.6f alpha:0.5f] CGColor], nil];
        [button.layer insertSublayer:bottomFade atIndex:0];
        
        [button setTitle: title forState: UIControlStateNormal];
        
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 10, -105, 0);
        button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        button.titleLabel.numberOfLines = 2;
        button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
}

/* Style:
 * Sets scroll view, subview's bgColor, sets title and icons of tabBar items.
 */
-(void) style {
    
    //Color
    self.view.backgroundColor = [UIColor whiteColor];
    self.sportContentView.backgroundColor = [UIColor whiteColor];
    self.sportScrollView.backgroundColor = [UIColor whiteColor];
    
    //Set tab bar image and title
    [[self.tabBarController.tabBar.items objectAtIndex:1] initWithTitle: @"Schedule" image:[UIImage imageNamed:@"schedule"] tag: 1];
    [[self.tabBarController.tabBar.items objectAtIndex:2] initWithTitle: @"Roster" image:[UIImage imageNamed:@"roster"] tag: 2];
    [[self.tabBarController.tabBar.items objectAtIndex:3] initWithTitle: @"Standings" image:[UIImage imageNamed:@"standings"] tag: 3];
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:0.00 green:0.22 blue:0.44 alpha:0.95]];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.0]];

}


/* prepareForSegue:
 * Correspondingly sets the storyView's storyArray
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    storyViewController * storyView = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"story1Segue"]){
        storyView.storyArray = self.rssArray[0];
    }
    
    else if ([segue.identifier isEqualToString: @"story2Segue"]){
        storyView.storyArray = self.rssArray[1];
    }
    
    else if ([segue.identifier isEqualToString: @"story3Segue"]){
        storyView.storyArray = self.rssArray[2];
    }
    
    else if ([segue.identifier isEqualToString: @"story4Segue"]){
        storyView.storyArray = self.rssArray[3];
    }
    
    else if ([segue.identifier isEqualToString: @"story5Segue"]){
        storyView.storyArray = self.rssArray[4];
    }
    
    else {
            
    }
}





@end
