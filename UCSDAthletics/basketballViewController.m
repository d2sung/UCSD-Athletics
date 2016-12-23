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
    
    if ([self.genderString isEqualToString:@"men"]){
        [self setupMen];
    }
    
    else {
        [self setupWomen];
    }
    // Do any additional setup after loading the view.
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
    
}

/*setupWomen:
 * Load women's stories, roster, schedule
 */
-(void)setupWomen {
    self.title = @"Women's Basketball";

}

/* prepareForSegue:
 * Determines the gender segue and sets genderString in sportController accordingly
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    rosterViewController * rosterController = segue.destinationViewController;
    if ([self.genderString  isEqual: @"men"]) {
        rosterController.genderString = @"men";
    }
    
    else {
        rosterController.genderString = @"women";
    }
    
}


@end
