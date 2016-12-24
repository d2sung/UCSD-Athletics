//
//  arrayTest.h
//  test
//
//  Created by Daniel Sung on 12/29/15.
//  Copyright (c) 2015 Daniel Sung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "playerProfile.h"

@interface roster : NSObject
@property NSMutableArray *teamArray;
@property playerProfile * teamPlayer;
@property NSMutableDictionary * bioDictionary;
@property int playersCount;

-(void)buildRoster:(bool) isMen;
-(void)buildBio:(bool) isMen;

-(void)addPlayer: (playerProfile*) player;
-(int) iterateToNextLine: (NSString*)statSheet :(int) curIndex;
-(int) iterateThroughCommas: (NSString*)statSheet :(int) curIndex;

@end
