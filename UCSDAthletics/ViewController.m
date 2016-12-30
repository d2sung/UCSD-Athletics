//
//  ViewController.m
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/21/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import "ViewController.h"
#import "sportViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)mBasketballButton:(id)sender {
}

- (IBAction)wBasketball:(id)sender {
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set bar color
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.02 green:0.16 blue:0.36 alpha:1.0];
    
    //Set arrow color
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    
    [self.navigationItem.backBarButtonItem setTitle:@" "];
    
    //Set text color
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



/* prepareForSegue:
 * Determines the gender segue and sets default with key "gender" accordingly
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   
    if ([segue.identifier isEqualToString:@"menSegueIdentifier"]){
         [defaults setInteger:true forKey:@"gender"];
    }
    
    else if ([segue.identifier isEqualToString: @"womenSegueIdentifier"]){
        [defaults setBool:false forKey:@"gender"];
        }
    
     [defaults synchronize];
    
    

}

@end
