//
//  bioParser.h
//  tritonBasketball
//
//  Created by Daniel Sung on 12/22/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bioParser : NSObject

@property NSString *dataString;

-(NSString*) getBio: (bool) isMen;

-(NSString*) parseStringEntry:(NSString *) bioFile
                             : (int) idx;

-(NSString*) parseBackgroundEntry: (NSString *) bioFile
                                 :(int) idx;

@end