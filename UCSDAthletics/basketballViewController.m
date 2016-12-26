//
//  basketballViewController.m
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/21/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import "basketballViewController.h"
#import "roster.h"
#import "rosterViewController.h"


@interface basketballViewController ()

@end

@implementation basketballViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults boolForKey:@"gender"])
        [self setupMen];
    else
        [self setupWomen];
    
    [[self.tabBarController.tabBar.items objectAtIndex:1] initWithTitle: @"Schedule" image:[UIImage imageNamed:@"schedule"] tag: 1];
    
    [[self.tabBarController.tabBar.items objectAtIndex:2] initWithTitle: @"Roster" image:[UIImage imageNamed:@"roster"] tag: 2];
    
      [[self.tabBarController.tabBar.items objectAtIndex:3] initWithTitle: @"Standings" image:[UIImage imageNamed:@"standings"] tag: 3];
    
   
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*setupMen:
 * Load men's stories, roster, schedule
 */
-(void)setupMen {
    self.title = @"Men's Basketball";
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

@end
