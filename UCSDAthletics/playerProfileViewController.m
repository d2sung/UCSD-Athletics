//
//  playerProfileViewController.m
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/21/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import "playerProfileViewController.h"
#import "playerProfile.h"
#import "roster.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "HTMLParser.h"
#import "HTMLNode.h"

@interface playerProfileViewController ()

@end

@implementation playerProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStats];
    
    //Get last three games
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults boolForKey:@"gender"])
        self.pastGames = appDelegate.mPastGames;
    
    else
        self.pastGames = appDelegate.wPastGames;
    
    self.past3Games = [NSArray arrayWithObjects: self.pastGames[[self.pastGames count] -1], self.pastGames[[self.pastGames count] -2], self.pastGames[[self.pastGames count]-3], nil];
    
    [self setPastThreeGames];
    [self.navigationItem setTitle:@" "];
  
    
    
}


/* viewDidLayoutSubviews:
 * Set scroll view
 * Set gradient colors
 */
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.02 green:0.16 blue:0.36 alpha:1.0];
    self.yellowColorView.backgroundColor = [UIColor colorWithRed:0.96 green:0.80 blue:0.05 alpha:1.0];
    
    [self.playerScrollView layoutIfNeeded];
    self.playerScrollView.contentSize = self.playerContentView.bounds.size;
    
    //Set gradient layer
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.playerContentView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.96 green:0.80 blue:0.05 alpha:1.0] CGColor], (id)[[UIColor colorWithRed:0.02 green:0.16 blue:0.36 alpha:1.0] CGColor], nil];
    gradient.locations = @[@0.0, @0.45];
    
    [self.playerContentView.layer insertSublayer:gradient atIndex:0];
    
    
    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize = self.contentView.bounds.size;
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString * fileName = [NSString stringWithFormat:@"%@%@", [[self.player.fName substringToIndex:1] lowercaseString], self.player.lName];
    
    [self.profileImage setImage:[UIImage imageNamed:fileName]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setPastThreeGames {
    NSArray * gameArray = [self getTitleforLastThreeGames];
    
    self.gameLabel1.text = gameArray[0];
    self.gameLabel2.text = gameArray[1];
    self.gameLabel3.text = gameArray[2];
    
    NSArray *statsArray = [self getPlayerStats];
    //Set past three game labels
    
    
    for (int x = 0; x < [statsArray[0] count]; x++){
        UILabel *label = self.statsLabel1[x];
        label.text = statsArray[0][x];
    }
    
    for (int x = 0; x < [statsArray[0] count]; x++){
        UILabel *label = self.statsLabel2[x];
        label.text = statsArray[1][x];
    }
    
    for (int x = 0; x < [statsArray[0] count]; x++){
        UILabel *label = self.statsLabel3[x];
        label.text = statsArray[2][x];
    }

}

/* setStats:
 * Get player bio and stats and assign to corresponding text label
 */
-(void)setStats{
    
    //Set Name, number
    self.fnameLabel.text = self.player.fName;
    self.lNameLabel.text = self.player.lName;
    self.numberLabel.text = self.player.number;
    self.backgroundLabel.text = self.player.background;
    self.majorLabel.text = self.player.major;
    self.weightLabel.text = self.player.weight;
    self.heightLabel.text = self.player.height;
    
    //Set position
    if ([self.player.position isEqual: @"G"])
        self.positionLabel.text = @"Guard";
    else if ([self.player.position isEqual: @"F"])
        self.positionLabel.text = @"Forward";
    else if ([self.player.position isEqual: @"C"])
        self.positionLabel.text = @"Center";
    else if ([self.player.position isEqual: @"G/F"])
        self.positionLabel.text = @"G/F";
    else if ([self.player.position isEqual: @"F/C"])
        self.positionLabel.text = @"F/C";
    else
        self.positionLabel.text = @"Player";
    
    //Set Year
    if ([self.player.year isEqual: @"Fr."])
        self.yearLabel.text = @"Freshman";
    else if ([self.player.year isEqual: @"RFr."])
        self.yearLabel.text = @"Redshirt Fr.";
    else if ([self.player.year isEqual: @"So."])
        self.yearLabel.text = @"Sophomore";
    else if ([self.player.year isEqual: @"RSo."])
        self.yearLabel.text = @"Redshirt So.";
    else if ([self.player.year isEqual: @"Jr."])
        self.yearLabel.text = @"Junior";
    else if ([self.player.year isEqual: @"RJr."])
        self.yearLabel.text = @"Redshirt Jr.";
    else if ([self.player.year isEqual: @"Sr."])
        self.yearLabel.text = @"Senior";
    else if ([self.player.year isEqual: @"RSr."])
        self.yearLabel.text = @"Redshirt Sr.";
    else
        self.yearLabel.text = @"Undergraduate";
    
    //Set stats
    self.ppgValueLabel.text = [NSString stringWithFormat:@"%.01f", self.player.ppg];
    self.rpgValueLabel.text = [NSString stringWithFormat:@"%.01f", self.player.rpg];
    self.apgValueLabel.text = [NSString stringWithFormat:@"%.01f", self.player.apg];
    
    self.stlValueLabel.text = @(self.player.stl).stringValue;
    self.blkValueLabel.text = @(self.player.blk).stringValue;
    self.threeptValueLabel.text = @(self.player.threeFg).stringValue;
    
    self.fgPctValueLabel.text =[NSString stringWithFormat:@"%.01f", self.player.fgPct*100];
    self.ftPctValueLabel.text = [NSString stringWithFormat:@"%.01f", self.player.ftPct*100];
    self.threeptPctValueLabel.text = [NSString stringWithFormat:@"%.01f", self.player.threePct*100];
}

-(NSArray*) getTitleforLastThreeGames {
    NSMutableArray * retArray = [[NSMutableArray alloc]init];
    
    for (NSArray * gameArray in self.past3Games){
        
        NSArray *titleArray = [gameArray[0] componentsSeparatedByString:@":"];
        NSString * gameTitle = titleArray[1];
        
        [retArray addObject: gameTitle];
      }
    
    return retArray;
}

-(NSString *) getStatsURL: (int) i {
    
    NSMutableString *statsURL = [[NSMutableString alloc] init];
        
    NSString *descriptionString = self.past3Games[i][1];
    
    NSError *error = nil;
    
    HTMLParser *parser = [[HTMLParser alloc] initWithString:descriptionString error:&error];
        
        if (error) {
            NSLog(@"Error: %@", error);
            return nil;
        }
        
        HTMLNode *bodyNode = [parser body];
        
        NSArray *pNodes = [bodyNode findChildTags: @"p"];
        
        HTMLNode * attrNode;
        for (HTMLNode *node in pNodes){
            attrNode = [node findChildWithAttribute: @"href" matchingName: @"http://www.ucsdtritons.com" allowPartial:YES];
        }
        
        NSString * nodeString = [attrNode rawContents];
        int quoteMark = 0;
        
        int index = 0;
        
        while ( quoteMark < 3){
            if ([nodeString characterAtIndex:index] == '"'){
                quoteMark++;
                index++;
            }
            
            else {
                index++;
            }
        }
        
        while ([nodeString characterAtIndex:index] != '"'){
            [statsURL appendFormat:@"%c", [nodeString characterAtIndex:index]];
            index++;
        }
    return statsURL;
}

-(NSArray *) getPlayerStats {
    
    NSMutableArray * retArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [self.past3Games count]; i++){
        
        NSString * url = [self getStatsURL:i];
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        NSString *htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSError *error = nil;
        
        HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlString error:&error];
        
        if (error) {
            NSLog(@"Error: %@", error);
            return nil;
        }
        
        HTMLNode *bodyNode = [parser body];
        NSArray *inputNodes = [bodyNode findChildTags:@"td"];
        NSArray * gameStatsArray = [[NSMutableArray alloc]init];
        
        
        
        for (int i = 0; i < [inputNodes count]; i++) {
            
            HTMLNode *tdNode = inputNodes[i];
            
            NSString *content = [NSString stringWithFormat: @"%@, %@\u00a0", self.player.lName, self.player.fName];
            
            //If the tdNode is the team total
            if ([[tdNode allContents] isEqualToString:content]){
                gameStatsArray = [NSArray arrayWithObjects: [inputNodes[i+13]allContents], [inputNodes[i+8]allContents], [inputNodes[i+2]allContents], [inputNodes[i+3]allContents], [inputNodes[i+4]allContents], [inputNodes[i+6]allContents], [inputNodes[i+9]allContents], [inputNodes[i+12]allContents],[inputNodes[i+11]allContents], [inputNodes[i+10]allContents], [inputNodes[i+7]allContents], nil];
                    break;
                
                }
        }
        
        [retArray addObject:gameStatsArray];
    
    }
    return retArray;
}


@end
