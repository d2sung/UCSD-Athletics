//
//  teamControllerView.m
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/29/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import "teamControllerView.h"
#import "AppDelegate.h"
#import "AppDelegate.h"
#import "HTMLParser.h"
#import "HTMLNode.h"

@implementation teamControllerView

-(void)viewDidLoad{
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed: @"trident_logo"];
    [self.logoImageView setImage:image];
    
    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize = self.contentView.bounds.size;
    
    [self.statScrollView layoutIfNeeded];
    self.statScrollView.contentSize = self.statContentView.bounds.size;
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if([defaults boolForKey:@"gender"]){
        self.teamLabel.text = @"UC San Diego Men's Basketball";
        self.teamPlayer = appDelegate.menTeamPlayer;
        self.pastGames = appDelegate.mPastGames;
    }
    
    else {
        self.teamLabel.text = @"UC San Diego Women's Basketball";
        self.teamPlayer = appDelegate.womenTeamPlayer;
        self.pastGames = appDelegate.wPastGames;
    }
    
    self.past3Games = [NSArray arrayWithObjects: self.pastGames[[self.pastGames count] -1], self.pastGames[[self.pastGames count] -2], self.pastGames[[self.pastGames count]-3], nil];
    
    self.teamLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.teamLabel.numberOfLines = 3;
    
    self.ptsLabel.text = [NSString stringWithFormat:@"%.01f", self.teamPlayer.ppg];
    self.fgLabel.text = [NSString stringWithFormat:@"%.01f", self.teamPlayer.fgPct * 100];
    self.threeptPerLabel.text = [NSString stringWithFormat:@"%.01f", self.teamPlayer.threePct * 100];
    self.ftPerLabel.text = [NSString stringWithFormat:@"%.01f", self.teamPlayer.ftPct*100];
    self.rebLabel.text = [NSString stringWithFormat:@"%.01f", self.teamPlayer.rpg];
    self.assistsLabel.text = [NSString stringWithFormat:@"%.01f", self.teamPlayer.apg];
    
    
    self.threeptLabel.text = [NSString stringWithFormat:@"%.1f", (double)self.teamPlayer.threeFg/(double)self.teamPlayer.gp];
    
    [self setPastThreeGames];
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
  

}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
   
    
}



-(void) setPastThreeGames {
    NSArray * gameArray = [self getTitleforLastThreeGames];
    
    int i = 0;
    for (UILabel * gameLabel in self.gameLabels){
        gameLabel.text = gameArray[i];
        i++;
    }
    NSArray *statsArray = [self getPlayerStats];
    //Set past three game labels
    
    
    for (int x = 0; x < [statsArray[0] count]; x++){
        UILabel *label = self.game1StatLabel[x];
        label.text = statsArray[0][x];
    }
    
    
    for (int x = 0; x < [statsArray[0] count]; x++){
        UILabel *label = self.game2StatLabel[x];
        label.text = statsArray[1][x];
    }
    
    for (int x = 0; x < [statsArray[0] count]; x++){
        UILabel *label = self.game3StatLabel[x];
        label.text = statsArray[2][x];
    }
    
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
    Boolean atHome;
    
    for (int i = 0; i < [self.past3Games count]; i++){
        
        NSString * url = [self getStatsURL:i];
        
        if ([self.pastGames[[self.pastGames count] - (i+1)][1] isEqualToString: @"<p>at UC San Di"])
            atHome = true;
        else
            atHome = false;
        
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
        
        
        
        for (int x = 0; x < [inputNodes count]; x++) {
            
            HTMLNode *tdNode = inputNodes[x];
            
            //If the tdNode is the team total
            if ([[tdNode allContents] isEqualToString:@"Totals..............\u00a0"]){
                
                gameStatsArray = [NSArray arrayWithObjects:[inputNodes[x+8]allContents], [inputNodes[x+6]allContents], [inputNodes[x+9]allContents], [inputNodes[x+2]allContents], [inputNodes[x+4]allContents], [inputNodes[x+3]allContents], [inputNodes[x+12]allContents],[inputNodes[x+11]allContents], [inputNodes[x+10]allContents], [inputNodes[x+7]allContents], nil];
            
                if (atHome == false)
                    atHome = true;
                
                else
                    break;
            }
        }
        
        [retArray addObject:gameStatsArray];
        
    }
    return retArray;
}





@end
