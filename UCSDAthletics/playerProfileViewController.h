//
//  playerProfileViewController.h
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/21/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "playerProfile.h"
#import "roster.h"

@interface playerProfileViewController : UIViewController

//Label
@property (weak, nonatomic) IBOutlet UILabel *fnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *backgroundLabel;

@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *ppgLabel;
@property (weak, nonatomic) IBOutlet UILabel *rpgLabel;
@property (weak, nonatomic) IBOutlet UILabel *apgLabel;
@property (weak, nonatomic) IBOutlet UILabel *stlLabel;
@property (weak, nonatomic) IBOutlet UILabel *blkLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeptMadeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fgPctLabel;
@property (weak, nonatomic) IBOutlet UILabel *ftPctLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeptPctLabel;

//Value label
@property (weak, nonatomic) IBOutlet UILabel *ppgValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *rpgValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *apgValueLabel;

@property (weak, nonatomic) IBOutlet UILabel *stlValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *blkValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeptValueLabel;

@property (weak, nonatomic) IBOutlet UILabel *fgPctValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *ftPctValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeptPctValueLabel;

@property playerProfile *player;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;


@end
