//
//  bioParser.m
//  tritonBasketball
//
//  Created by Daniel Sung on 12/22/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "bioParser.h"

@implementation bioParser

//Gets bio from website and returns it into string

-(NSString*) getBio: (bool) isMen {
    NSURL *targetURL;
    
    if (isMen) {
        targetURL = [NSURL URLWithString:@"https://docs.google.com/spreadsheets/d/1u15DsOWdGMIP4AIBPSwKuHKMQA03GN425U2H5zcH07Y/pub?gid=847045433&single=true&output=csv"];
    }
    
    else {
        
        targetURL = [NSURL URLWithString:@"https://docs.google.com/spreadsheets/d/1u15DsOWdGMIP4AIBPSwKuHKMQA03GN425U2H5zcH07Y/pub?gid=1945535660&single=true&output=csv"];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    return dataString;
}

-(NSString*)parseStringEntry: (NSString *)bioFile
                                :(int) idx {
    NSMutableString *stringEntry = [[NSMutableString alloc]init];
    
    char letter;
    letter = [bioFile characterAtIndex: idx];
    
    while (letter != ','){
        
        [stringEntry appendFormat:@"%c", letter];
        idx++;
        letter = [bioFile characterAtIndex: idx];
    }
    
    return stringEntry;
}


-(NSString*) parseBackgroundEntry: (NSString *) bioFile
                                 :(int) idx {
    
    NSMutableString *stringEntry = [[NSMutableString alloc]init];
    char letter;
    letter = [bioFile characterAtIndex: idx];
    bool lastQuote = false;
    
    if (letter == '"'){
        letter = nil;
    }
    
    while (lastQuote == false){
        [stringEntry appendFormat:@"%c", letter];
        idx++;
        letter = [bioFile characterAtIndex:idx];
        
        if (letter == '"'){
            lastQuote = true;
        }
    }
    return stringEntry;
    
}

@end
