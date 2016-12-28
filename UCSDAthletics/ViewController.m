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
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/* prepareForSegue:
 * Determines the gender segue and sets genderString in sportController accordingly
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
