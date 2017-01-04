//
//  teamControllerView.h
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/29/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "playerProfile.h"

@interface teamControllerView : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
@property (weak, nonatomic) IBOutlet UILabel *ptsLabel;
@property (weak, nonatomic) IBOutlet UILabel *fgLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeptPerLabel;
@property (weak, nonatomic) IBOutlet UILabel *ftPerLabel;
@property (weak, nonatomic) IBOutlet UILabel *rebLabel;
@property (weak, nonatomic) IBOutlet UILabel *assistsLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeptLabel;

@property playerProfile * teamPlayer;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;


//Last three games
@property (weak, nonatomic) IBOutlet UIScrollView *statScrollView;
@property (weak, nonatomic) IBOutlet UIView *statContentView;

@property NSArray * pastGames;
@property NSArray * past3Games;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *gameLabels;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *game1StatLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *game2StatLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *game3StatLabel;


//Leaders
@property (weak, nonatomic) IBOutlet UIImageView *pointsLeaderImage;
@property (weak, nonatomic) IBOutlet UILabel *ptsLeaderNumber;
@property (weak, nonatomic) IBOutlet UILabel *pointsLeaderName;
@property (weak, nonatomic) IBOutlet UILabel *ptsLeaderStat;
@property (weak, nonatomic) IBOutlet UILabel *ptsLeaderSimStat;


@property (weak, nonatomic) IBOutlet UIView *rebLeaderImage;
@property (weak, nonatomic) IBOutlet UILabel *rebLeaderNumber;
@property (weak, nonatomic) IBOutlet UILabel *rebLeaderName;
@property (weak, nonatomic) IBOutlet UILabel *rebLeaderStat;
@property (weak, nonatomic) IBOutlet UILabel *rebLeaderSimilarStat;

@property (weak, nonatomic) IBOutlet UIImageView *astLeaderImage;
@property (weak, nonatomic) IBOutlet UILabel *astLeaderNumber;
@property (weak, nonatomic) IBOutlet UILabel *astLeaderName;
@property (weak, nonatomic) IBOutlet UILabel *astLeaderStat;
@property (weak, nonatomic) IBOutlet UILabel *astLeaderSimStat;


@end
