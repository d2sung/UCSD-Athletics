//
//  teamControllerView.m
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/29/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import "teamControllerView.h"
#import "AppDelegate.h"

@implementation teamControllerView

-(void)viewDidLoad{
    UIImage *image = [UIImage imageNamed: @"trident_logo"];
    [self.logoImageView setImage:image];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSLog([defaults boolForKey:@"gender"] ? @"yes" : @"no");
    
    if([defaults boolForKey:@"gender"]){
        self.teamLabel.text = @"UC San Diego Men's Basketball";
        self.teamPlayer = appDelegate.menTeamPlayer;
    }
    
    else {
        self.teamLabel.text = @"UC San Diego Men's Basketball";
        self.teamPlayer = appDelegate.womenTeamPlayer;
    }
    
    self.ptsLabel.text = [NSString stringWithFormat:@"%.01f", self.teamPlayer.ppg];
    self.fgLabel.text = [NSString stringWithFormat:@"%.01f", self.teamPlayer.fgPct * 100];
    self.threeptPerLabel.text = [NSString stringWithFormat:@"%.01f", self.teamPlayer.threePct * 100];
    self.ftPerLabel.text = [NSString stringWithFormat:@"%.01f", self.teamPlayer.ftPct*100];
    self.rebLabel.text = [NSString stringWithFormat:@"%.01f", self.teamPlayer.rpg];
    self.assistsLabel.text = [NSString stringWithFormat:@"%.01f", self.teamPlayer.apg];
    
    
    self.threeptLabel.text = [NSString stringWithFormat:@"%.1f", (double)self.teamPlayer.threeFg/(double)self.teamPlayer.gp];

    
    
    
    
}



@end
