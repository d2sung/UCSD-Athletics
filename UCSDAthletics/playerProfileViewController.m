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
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface playerProfileViewController ()

@end

@implementation playerProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStats];
}


/* viewDidLayoutSubviews:
 * Set scroll view
 * Set gradient colors
 */
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.00 green:0.22 blue:0.44 alpha:1.0];
    self.yellowColorView.backgroundColor = [UIColor colorWithRed:0.96 green:0.80 blue:0.05 alpha:1.0];
    
    [self.playerScrollView layoutIfNeeded];
    self.playerScrollView.contentSize = self.playerContentView.bounds.size;
    
    //Set gradient layer
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.playerContentView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.96 green:0.80 blue:0.05 alpha:1.0] CGColor], (id)[[UIColor colorWithRed:0.00 green:0.22 blue:0.44 alpha:1.0] CGColor], nil];
    gradient.locations = @[@0.0, @0.55];
    
    [self.playerContentView.layer insertSublayer:gradient atIndex:0];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString * fileName = [NSString stringWithFormat:@"%@%@", [[self.player.fName substringToIndex:1] lowercaseString], self.player.lName];
    
    [self.profileImage setImage:[UIImage imageNamed:fileName]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* setStats:
 * Get player bio and stats and assign to corresponding text label
 */
-(void)setStats{
    
    //Set Name, number
    self.fnameLabel.text = self.player.fName;
    self.lNameLabel.text = self.player.lName;
    self.numberLabel.text = self.player.number;
    self.backgroundLabel.text = self.player.background;
    self.majorLabel.text = self.player.major;
    self.prevSchool.text = self.player.prevSchool;
    
    //Set position
    if ([self.player.position isEqual: @"G"])
        self.positionLabel.text = @"Guard";
    else if ([self.player.position isEqual: @"F"])
        self.positionLabel.text = @"Forward";
    else if ([self.player.position isEqual: @"C"])
        self.positionLabel.text = @"Center";
    else if ([self.player.position isEqual: @"G/F"])
        self.positionLabel.text = @"G/F";
    else if ([self.player.position isEqual: @"F/C"])
        self.positionLabel.text = @"F/C";
    else
        self.positionLabel.text = @"Player";
    
    //Set Year
    if ([self.player.year isEqual: @"Fr."])
        self.yearLabel.text = @"Freshman";
    else if ([self.player.year isEqual: @"RFr."])
        self.yearLabel.text = @"Redshirt Fr.";
    else if ([self.player.year isEqual: @"So."])
        self.yearLabel.text = @"Sophomore";
    else if ([self.player.year isEqual: @"RSo."])
        self.yearLabel.text = @"Redshirt So.";
    else if ([self.player.year isEqual: @"Jr."])
        self.yearLabel.text = @"Junior";
    else if ([self.player.year isEqual: @"RJr."])
        self.yearLabel.text = @"Redshirt Jr.";
    else if ([self.player.year isEqual: @"Sr."])
        self.yearLabel.text = @"Senior";
    else if ([self.player.year isEqual: @"RSr."])
        self.yearLabel.text = @"Redshirt Sr.";
    else
        self.yearLabel.text = @"Undergraduate";
    
    //Set stats
    self.ppgValueLabel.text = [NSString stringWithFormat:@"%.01f", self.player.ppg];
    self.rpgValueLabel.text = [NSString stringWithFormat:@"%.01f", self.player.rpg];
    self.apgValueLabel.text = [NSString stringWithFormat:@"%.01f", self.player.apg];
    
    self.stlValueLabel.text = @(self.player.stl).stringValue;
    self.blkValueLabel.text = @(self.player.blk).stringValue;
    self.threeptValueLabel.text = @(self.player.threeFg).stringValue;
    
    self.fgPctValueLabel.text =[NSString stringWithFormat:@"%.01f", self.player.fgPct*100];
    self.ftPctValueLabel.text = [NSString stringWithFormat:@"%.01f", self.player.ftPct*100];
    self.threeptPctValueLabel.text = [NSString stringWithFormat:@"%.01f", self.player.threePct*100];
}



@end
