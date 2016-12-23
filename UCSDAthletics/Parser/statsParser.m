//
//  statsParser.m
//  tritonBasketball
//
//  Created by Daniel Sung on 12/28/15.
//  Copyright (c) 2015 Daniel Sung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "statsParser.h"

@implementation statsParser

//Gets stats from website and returns it into string
-(NSString*) getStats: (bool) isMen{
    NSURL *targetURL;
    
    if (isMen){
        targetURL = [NSURL URLWithString:@"https://docs.google.com/spreadsheets/d/1u15DsOWdGMIP4AIBPSwKuHKMQA03GN425U2H5zcH07Y/pub?gid=0&single=true&output=csv"];
    }
    
    else {
         targetURL = [NSURL URLWithString:@"https://docs.google.com/spreadsheets/d/1u15DsOWdGMIP4AIBPSwKuHKMQA03GN425U2H5zcH07Y/pub?gid=1483798495&single=true&output=csv"];
    }
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    return dataString;
}

//Returns the lastName
-(NSString*)parseLastName: (NSString*) statFile
                         :(int) idx {
    //Instance variables
    NSMutableString *stringEntry = [[NSMutableString alloc]init];
    char character;
    character = [statFile characterAtIndex:idx];
    
    while(character !=','){
        if(character == '"'){
            idx++;
            character = [statFile characterAtIndex:idx];
        }
        
        else if(character != '"'){
            [stringEntry appendFormat:@"%c", character];
            idx++;
            character = [statFile characterAtIndex:idx];
        }
    }
    NSString *returnString = stringEntry;
    return returnString;
}





//Returns the first name
-(NSString*) parseFirstName: (NSString*) statFile
                           : (int) idx {
    //Instance variables
    NSMutableString *stringEntry = [[NSMutableString alloc]init];
    char character;
    character = [statFile characterAtIndex:idx];
    
    while(character !='"' ){
        if(character == ' '){
            idx++;
            character = [statFile characterAtIndex:idx];
        }
        
        else {
            [stringEntry appendFormat:@"%c", character];
            idx++;
            character = [statFile characterAtIndex:idx];
        }
    }
    
    NSString *returnString = stringEntry;
    return returnString;
}




//Returns the int entry, specifically for jersey number or stats
-(double)parseIntEntry:(NSString *)statFile
                          :(int) idx {
    NSMutableString *intEntry = [[NSMutableString alloc]init];
    char number;
    number = [statFile characterAtIndex:idx];
    
    while (number != ','){
        [intEntry appendFormat:@"%c", number];
        idx++;
        number = [statFile characterAtIndex:idx];
        
        if (number == ' '){
            number = ',';
        }
    }
    
    double returnDouble = [intEntry doubleValue];
    return returnDouble;
}

@end
