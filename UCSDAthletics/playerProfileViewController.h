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
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property playerProfile *player;


@end
