//
//  gameViewController.m
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/30/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import "gameViewController.h"
#import "HTMLParser.h"
#import "HTMLNode.h"

@implementation gameViewController

-(void) viewDidLoad{
    [super viewDidLoad];
    
    NSArray * infoArray = [self getGameInfo];
    
    
    self.awayTeam.text = infoArray[0];
    self.homeTeam.text = infoArray[1];
    self.dateLocationLabel.text = infoArray[2];
    
    
    }


-(NSArray *) getGameInfo{
    
    NSError *error = nil;
    
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.gameDetailsLink]];
    
    NSString *htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlString error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error);
        return nil;
    }
    
    HTMLNode *bodyNode = [parser body];
    NSArray *inputNodes = [bodyNode findChildTags:@"h3"];
    
    NSString *title = [inputNodes[0] allContents];
    
    NSLog(@"Content: %@", title);
    
    //Get opponent string
    int titleIndex = 0;
    
    NSMutableString * awayTeam = [[NSMutableString alloc] init];
    NSMutableString * homeTeam = [[NSMutableString alloc] init];
    NSMutableString * dateLocation = [[NSMutableString alloc] init];
    
    //Get away name
    while(!([title characterAtIndex:titleIndex] == ' ' && [title characterAtIndex:titleIndex+1] == 'v' && [title characterAtIndex:titleIndex+2] == 's' && [title characterAtIndex:titleIndex+3] == ' ')){
        
        [awayTeam appendFormat:@"%c", [title characterAtIndex:titleIndex]];
        
        titleIndex++;
    }
    
    titleIndex = titleIndex + 4;
    
    //Get home name
    while(!([title characterAtIndex:titleIndex] == ' ' && [title characterAtIndex:titleIndex+1] == '(' && [title characterAtIndex:titleIndex+2] && isdigit([title characterAtIndex:titleIndex+3]))){
        [homeTeam appendFormat:@"%c", [title characterAtIndex:titleIndex]];
        titleIndex++;
    }
        
    while([title characterAtIndex:titleIndex] != '('){
        titleIndex++;
    }
    titleIndex++;
    
    while ( !([title characterAtIndex:titleIndex] == ')' && [title characterAtIndex:titleIndex+1] == ')')){
        [dateLocation appendFormat:@"%c", [title characterAtIndex:titleIndex]];
        titleIndex++;
    }
    
    titleIndex++;
    [dateLocation appendFormat:@"%c", [title characterAtIndex:titleIndex]];

    NSArray *retArray = [NSArray arrayWithObjects: awayTeam, homeTeam, dateLocation, nil];
    
    return retArray;
}



@end
