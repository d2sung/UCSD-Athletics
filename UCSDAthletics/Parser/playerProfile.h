//
//  playerProfile.h
//  tritonBasketball
//
//  Created by Daniel Sung on 12/27/15.
//  Copyright (c) 2015 Daniel Sung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface playerProfile : NSObject

//Vitals
@property (nonatomic, assign) int uniqueId;
@property NSString *fName;
@property NSString *lName;
@property NSString *position;
@property NSString *number;
@property NSString *height;
@property NSString *weight;
@property NSString *year;
@property NSString *major;
@property NSString *background;
@property NSString *prevSchool;

//Stats
@property int gp;
@property int gs;
@property int totMin;
@property double avgMin;
@property int fgMade;
@property int fgAttempts;
@property double fgPct;
@property int threeFg;
@property int threeAttempts;
@property double threePct;
@property int ft;
@property int ftAttempts;
@property double ftPct;
@property int offReb;
@property int defReb;
@property int reb;
@property double rpg;
@property int fouls;
@property int foulOuts;
@property int assists;
@property int to;
@property int blk;
@property int stl;
@property int pts;
@property double ppg;
@property double apg;

//Comparator
-(NSComparisonResult) compare: (playerProfile *)  otherPlayer;

















-(instancetype)initWithLastName: (NSString*) lastName;

@end
