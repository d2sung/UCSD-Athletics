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
    NSArray * statsArray = [self getStats];
    NSArray * playAnalysis = [self getPointsStats];

    //Set game info labels
    self.awayTeam.text = infoArray[0];
    self.homeTeam.text = infoArray[1];
    self.dateLocationLabel.text = infoArray[2];
    
    //Set home stat labels
    NSArray *homeArray = statsArray[1];
    for (int i = 0; i < [homeArray count]; i++){
            ((UILabel *)[self.homeLabel objectAtIndex:i]).text = homeArray[i];
    }
    
    //Set away stat labels
    NSArray *awayArray = statsArray[0];
    for (int i = 0; i < [awayArray count]; i++){
        ((UILabel *)[self.awayLabel objectAtIndex:i]).text = awayArray[i];
    }
    
    //Set play analysis labels
    int x = 0;
    
    for (NSString *string in playAnalysis[0]){
        ((UILabel *)[self.awayAnalysisLabels objectAtIndex:x]).text = string;
        
        x++;
    }
    
    int y = 0;
    
    for (NSString *string in playAnalysis[1]){
        ((UILabel *)[self.homeAnalysisLabels objectAtIndex:y]).text = string;
        y++;
    }
    
    //Colors higher stat to yellow
    [self checkHigher];
    
}

/* getGameInfo:
 * Returns array of size 3, with awayTeam name, homeTeam name and date/location
 */
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



/*getStats:
 * Returns array of size 2, with first index holding away team stats and second holding home team stats
 */
-(NSArray *) getStats {
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.gameDetailsLink]];
    NSString *htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlString error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error);
        return nil;
    }
    
    HTMLNode *bodyNode = [parser body];
    NSArray *inputNodes = [bodyNode findChildTags:@"td"];
    NSMutableArray * retArray = [[NSMutableArray alloc]init];
    
    int statsCounter = 0;   //Keeps track of which team
   
    
    for (int i = 0; i < [inputNodes count]; i++) {
        
        HTMLNode *tdNode = inputNodes[i];
        
        //If the tdNode is the team total
        if ([[tdNode rawContents] isEqualToString:@"<td align=\"left\"><font face=\"verdana\" size=\"1\" color=\"#000000\">Totals.............. </font></td>"]){
            
            //Away stats
            if (statsCounter == 0){
                NSArray *awayArray = [NSArray arrayWithObjects: [inputNodes[i+2]allContents], [inputNodes[i+3]allContents], [inputNodes[i+4]allContents], [inputNodes[i+6]allContents], [inputNodes[i+7]allContents], [inputNodes[i+8]allContents], [inputNodes[i+9]allContents], [inputNodes[i+10]allContents], [inputNodes[i+11]allContents],[inputNodes[i+12]allContents], nil];
                
                [retArray addObject:awayArray];
                
                statsCounter++;
            }
            
            //Home Stats
            else {
                NSArray *homeArray = [NSArray arrayWithObjects: [inputNodes[i+2] allContents], [inputNodes[i+3] allContents], [inputNodes[i+4] allContents], [inputNodes[i+6] allContents], [inputNodes[i+7] allContents], [inputNodes[i+8] allContents], [inputNodes[i+9] allContents], [inputNodes[i+10] allContents], [inputNodes[i+11] allContents], [inputNodes[i+12]allContents], nil];
                
                [retArray addObject:homeArray];
                
                return retArray;
            }
        }
    }
    return nil;
}


-(NSArray *) getPointsStats {
    NSMutableString * awayPtsOffTO = [[NSMutableString alloc] init];
    NSMutableString * homePtsOffTO = [[NSMutableString alloc] init];
    NSMutableString * awayPtsinPaint = [[NSMutableString alloc] init];
    NSMutableString * homePtsinPaint = [[NSMutableString alloc] init];
    NSMutableString * awaySecondPoints = [[NSMutableString alloc] init];
    NSMutableString * homeSecondPoints = [[NSMutableString alloc] init];
    NSMutableString * awayFastBreakPoints = [[NSMutableString alloc] init];
    NSMutableString * homeFastBreakPoints = [[NSMutableString alloc] init];
    NSMutableString * awayBenchPoints = [[NSMutableString alloc] init];
    NSMutableString * homeBenchPoints = [[NSMutableString alloc] init];
    
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.gameDetailsLink]];
    NSString *htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlString error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error);
        return nil;
    }
    
    HTMLNode *bodyNode = [parser body];
    NSArray *inputNodes = [bodyNode findChildTags:@"pre"];
    
    NSString * playAnalysis = [inputNodes[0] rawContents];
    
    int index = 0;
    
    
    //Skip Detail Line
    while ([playAnalysis characterAtIndex:index] != ')'){
        index++;
    }
    
    index++;
    
    //Skip POINT OFF TURNOVER LINE
    while ([playAnalysis characterAtIndex:index] != '-'){
        index++;
    }
    
    index++;
    
    //Get away team POT
    while ([playAnalysis characterAtIndex:index] != '-'){
        index++;
    }
    
    index++;

    while (!(isdigit([playAnalysis characterAtIndex:index]))){
        index++;
    }
    
    while (isdigit([playAnalysis characterAtIndex:index])){
        [awayPtsOffTO appendFormat: @"%c", [playAnalysis characterAtIndex:index]];
         index++;
    }
    
    index++;
    
    //Get home team POT
    while ([playAnalysis characterAtIndex:index] != '-'){
        index++;
    }
    
    index++;

    while (!(isdigit([playAnalysis characterAtIndex:index]))){
        index++;
    }
    
    while (isdigit([playAnalysis characterAtIndex:index])){
        [homePtsOffTO appendFormat: @"%c", [playAnalysis characterAtIndex:index]];
        index++;
    }
    
    index++;

    //Skip PIP
    while ([playAnalysis characterAtIndex:index] != '-'){
        index++;
    }
    
    index++;
    
    //Get away pip
    while ([playAnalysis characterAtIndex:index] != '-'){
        index++;
    }
    
    while (!(isdigit([playAnalysis characterAtIndex:index]))){
        index++;
    }
    
    while (isdigit([playAnalysis characterAtIndex:index])){
        [awayPtsinPaint appendFormat: @"%c", [playAnalysis characterAtIndex:index]];
        index++;
    }
    
    //Get home pip
    while ([playAnalysis characterAtIndex:index] != '-'){
        index++;
    }

    while (!(isdigit([playAnalysis characterAtIndex:index]))){
        index++;
    }
    
    while (isdigit([playAnalysis characterAtIndex:index])){
        [homePtsinPaint appendFormat: @"%c", [playAnalysis characterAtIndex:index]];
        index++;
    }
    
    //Skip 2nd chance point
    while ([playAnalysis characterAtIndex:index] != '-'){
        index++;
    }
    
    index++;
    
    //Get away 2nd chance points
    while ([playAnalysis characterAtIndex:index] != '-'){
        index++;
    }

    while (!(isdigit([playAnalysis characterAtIndex:index]))){
        index++;
    }
    
    while (isdigit([playAnalysis characterAtIndex:index])){
        [awaySecondPoints appendFormat: @"%c", [playAnalysis characterAtIndex:index]];
        index++;
    }
    
    //Get home 2nd chance points
    while ([playAnalysis characterAtIndex:index] != '-'){
        index++;
    }
    
    while (!(isdigit([playAnalysis characterAtIndex:index]))){
        index++;
    }
    
    while (isdigit([playAnalysis characterAtIndex:index])){
        [homeSecondPoints appendFormat: @"%c", [playAnalysis characterAtIndex:index]];
        index++;
    }
    
    //Skip fastbreak pts
    while ([playAnalysis characterAtIndex:index] != '-'){
        index++;
    }
    
    index++;
    
    //Get line 11
    while ([playAnalysis characterAtIndex:index] != '-'){
        index++;
    }
    
    while (!(isdigit([playAnalysis characterAtIndex:index]))){
        index++;
    }
    
    //Get home pts off TO
    while (isdigit([playAnalysis characterAtIndex:index])){
        [awayFastBreakPoints appendFormat: @"%c", [playAnalysis characterAtIndex:index]];
        index++;
    }
    
    //Get line 9
    while ([playAnalysis characterAtIndex:index] != '-'){
        index++;
    }
    
    while (!(isdigit([playAnalysis characterAtIndex:index]))){
        index++;
    }
    
    //Get away pts off TO
    while (isdigit([playAnalysis characterAtIndex:index])){
        [homeFastBreakPoints appendFormat: @"%c", [playAnalysis characterAtIndex:index]];
        index++;
    }
    
    //Skip 10th line
    while ([playAnalysis characterAtIndex:index] != '-'){
        index++;
    }
    
    index++;
    
    //Get line 11
    while ([playAnalysis characterAtIndex:index] != '-'){
        index++;
    }
    
    while (!(isdigit([playAnalysis characterAtIndex:index]))){
        index++;
    }
    
    //Get home pts off TO
    while (isdigit([playAnalysis characterAtIndex:index])){
        [awayBenchPoints appendFormat: @"%c", [playAnalysis characterAtIndex:index]];
        index++;
    }
    
    //Get line 9
    while ([playAnalysis characterAtIndex:index] != '-'){
        index++;
    }
    
    while (!(isdigit([playAnalysis characterAtIndex:index]))){
        index++;
    }
    
    //Get away pts off TO
    while (isdigit([playAnalysis characterAtIndex:index])){
        [homeBenchPoints appendFormat: @"%c", [playAnalysis characterAtIndex:index]];
        index++;
    }
    
    NSArray *awayArray = [NSArray arrayWithObjects: awayPtsinPaint, awayPtsOffTO, awayFastBreakPoints, awaySecondPoints, awayBenchPoints, nil];
    
    NSArray *homeArray = [NSArray arrayWithObjects: homePtsinPaint, homePtsOffTO,  homeFastBreakPoints, homeSecondPoints, homeBenchPoints, nil];

    NSArray *retArray = [NSArray arrayWithObjects: awayArray, homeArray, nil];
    
    return retArray;
}

-(void) checkHigher {
    
    for (int i = 0; i < [self.awayLabel count]; i++){
        
        if ([((UILabel *)[self.awayLabel objectAtIndex:i]).text integerValue] > [((UILabel *)[self.homeLabel objectAtIndex:i]).text integerValue]){
            ((UILabel *)[self.awayLabel objectAtIndex:i]).textColor = [UIColor colorWithRed:0.96 green:0.72 blue:0 alpha:.75];
        }
            
        else if ([((UILabel *)[self.awayLabel objectAtIndex:i]).text integerValue] < [((UILabel *)[self.homeLabel objectAtIndex:i]).text integerValue]){
            
            ((UILabel *)[self.homeLabel objectAtIndex:i]).textColor = [UIColor colorWithRed:0.96 green:0.72 blue:0 alpha:.75];
        }
            
        else {
                
        }
    }
    
    
}


@end
