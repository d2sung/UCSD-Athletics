//
//  statsParser.h
//  tritonBasketball
//
//  Created by Daniel Sung on 12/28/15.
//  Copyright (c) 2015 Daniel Sung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface statsParser : NSObject


//Methods
-(NSString*) getStats: (bool) isMen;

-(NSString*)parseLastName: (NSString*) statFile
                         : (int) idx;
-(NSString*)parseFirstName: (NSString*) statFile
                           : (int) idx;
-(double)parseIntEntry: (NSString*) statFile
                      :(int) idx;

@end
