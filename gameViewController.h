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

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *awayLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *homeLabel;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *awayAnalysisLabels;


@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *homeAnalysisLabels;

-(NSArray *) getPointsStats;


@end
