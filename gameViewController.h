//
//  gameViewController.h
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/30/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gameViewController : UIViewController

@property NSString * gameDetailsLink;

@property (weak, nonatomic) IBOutlet UILabel *awayTeam;
@property (weak, nonatomic) IBOutlet UILabel *homeTeam;
@property (weak, nonatomic) IBOutlet UILabel *dateLocationLabel;

@end
