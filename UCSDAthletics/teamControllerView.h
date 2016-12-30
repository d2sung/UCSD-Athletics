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

@end
