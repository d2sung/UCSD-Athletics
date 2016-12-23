//
//  playerProfileViewController.m
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/21/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import "playerProfileViewController.h"
#import "playerProfile.h"
#import "roster.h"

@interface playerProfileViewController ()

@end

@implementation playerProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * fullName = [NSString stringWithFormat:@"%@ %@", self.player.fName, self.player.lName];
    
    self.nameLabel.text = fullName;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
