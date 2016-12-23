
//
//  playerProfile.m
//  tritonBasketball
//
//  Created by Daniel Sung on 12/27/15.
//  Copyright (c) 2015 Daniel Sung. All rights reserved.
//

#import "playerProfile.h"

@implementation playerProfile

-(instancetype) initWithLastName:(NSString *)lastName {
    self = [super init];
    if (self) {
        self.lName = lastName;
    }
    return self;
}

-(NSComparisonResult) compare: (playerProfile *)  otherPlayer{
    return [self.lName compare:otherPlayer.lName];
}



@end
