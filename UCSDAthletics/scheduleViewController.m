//
//  scheduleViewController.m
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/29/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import "scheduleViewController.h"
#import "AppDelegate.h"
#import "HTMLParser.h"
#import "HTMLNode.h"
#import "gameViewController.h"
#import <UIKit/UIKit.h>

@implementation scheduleViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.y = 0;
    //Setup views
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 455)];
    self.contentView = [[UIStackView alloc] initWithFrame: CGRectMake(0, 0, 320, 455)];
    [self.scrollView addSubview: self.contentView];
    [self.view addSubview:self.scrollView];
    
    if ([defaults boolForKey:@"gender"]){
        self.upcomingGames = appDelegate.mUpcomingGames;
        self.pastGames = appDelegate.mPastGames;
    }
    
    else {
        self.upcomingGames = appDelegate.wUpcomingGames;
        self.pastGames = appDelegate.wPastGames;
    }
    
    [self createPastGameTiles];
    [self createUpcomingGameTiles];
    [self.contentView setFrame: CGRectMake(0, 0, 320, ([self.pastGames count] + [self.upcomingGames count]) * 151)];
    
    
    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize = self.contentView.bounds.size;
    
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}
    
    
    

-(void) createPastGameTiles {
        
    for (int i = 0; i < [self.pastGames count]; i++){
        //Create buttons
        UIView *view = [[UIView alloc] initWithFrame: CGRectMake(0, self.y, 320, 150)];
        view.backgroundColor = [UIColor whiteColor];
        
        NSArray * gameDetails = [self getGameDetails:i];
        
        UILabel * opponent = [[UILabel alloc] initWithFrame: CGRectMake(10, 20, 140, 65)];
        UILabel *opponentScore =[[UILabel alloc] initWithFrame: CGRectMake(10, 60, 90, 50)];
        UILabel * ucsd = [[UILabel alloc] initWithFrame: CGRectMake(210, 20, 140, 65)];
        UILabel *ucsdScore =[[UILabel alloc] initWithFrame: CGRectMake(294, 60, 90, 50)];
        UILabel *date =[[UILabel alloc] initWithFrame: CGRectMake(10, 100, 140, 65)];
        
        
        ucsd.text = @"UC San Diego";
        opponent.text = gameDetails[0];
        opponent.lineBreakMode = NSLineBreakByWordWrapping;
        opponent.numberOfLines = 2;
        date.text = gameDetails[1];
        ucsdScore.text = gameDetails[2];
        opponentScore.text = gameDetails[3];
        
        ucsd.textColor = [UIColor blackColor];
        opponent.textColor = [UIColor blackColor];
        date.textColor = [UIColor blackColor];
        
        
        if ([ucsdScore.text integerValue] > [opponentScore.text integerValue]){
            ucsdScore.textColor = [UIColor colorWithRed:0.96 green:0.72 blue:0 alpha:.75];            opponentScore.textColor = [UIColor blackColor];
            
        }
        
        else {
            ucsdScore.textColor = [UIColor blackColor];
            opponentScore.textColor = [UIColor colorWithRed:0.96 green:0.72 blue:0 alpha:.75];;
        }
        
        
        opponent.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size: 15];
        ucsd.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size: 15];
        opponentScore.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size: 20];
        ucsdScore.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size: 20];
        
        
        
        UIButton *button = [[UIButton alloc] initWithFrame: CGRectMake(0, self.y, 320, 150)];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        button.tag = i;
        
        [button addTarget:self
                   action:@selector(pushMyNewViewController:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview: ucsd];
        [view addSubview: opponent];
        [view addSubview: opponentScore];
        [view addSubview: ucsdScore];
        [view addSubview: date];

        [self.contentView addSubview: view];
        [self.contentView addSubview: button];
        
        self.y = self.y + 151;
    }
        
}
    
-(void) createUpcomingGameTiles {
        for (int i = 0; i < [self.upcomingGames count]; i++){
            UIView *view = [[UIView alloc] initWithFrame: CGRectMake(0, self.y, 320, 150)];
            view.backgroundColor = [UIColor lightGrayColor];
    
            NSArray * gameDetails = [self getUpcomingGameDetail: i];
            
            UILabel * opponent = [[UILabel alloc] initWithFrame: CGRectMake(10, 40, 140, 65)];
            UILabel * ucsd = [[UILabel alloc] initWithFrame: CGRectMake(210, 40, 140, 65)];
            UILabel *date =[[UILabel alloc] initWithFrame: CGRectMake(10, 100, 140, 65)];
            ucsd.text = @"UC San Diego";
            
            
            opponent.text = gameDetails[0];
            opponent.lineBreakMode = NSLineBreakByWordWrapping;
            opponent.numberOfLines = 2;
            date.text = gameDetails[1];
            
            ucsd.textColor = [UIColor blackColor];
            opponent.textColor = [UIColor blackColor];
            date.textColor = [UIColor blackColor];

            opponent.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size: 15];
            ucsd.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size: 15];
            [self.contentView addSubview: view];
            
            [view addSubview: ucsd];
            [view addSubview: opponent];
            [view addSubview: date];
            
            self.y = self.y + 151;
        }
}



-(NSArray*) getGameDetails: (int) i {
    NSString * gameDetails = self.pastGames[i][0];
    NSMutableString * opponent = [[NSMutableString alloc] init];
    int j = 0;
    
    //Skip until ':'
    while ([gameDetails characterAtIndex:j] != ':'){
        j++;
    }
    
    //Skip to opponent name
    j = j + 5;
    
    //Get opponent name
    while(!isdigit([gameDetails characterAtIndex:j])){
        [opponent appendFormat:@"%c", [gameDetails characterAtIndex:j]];
        j++;
    }
    
    opponent = [opponent substringToIndex:[opponent length] - 2];
    
    //Get date
    NSMutableString *date = [[NSMutableString alloc] init];
    
    while([gameDetails characterAtIndex:j] != ')'){
        [date appendFormat:@"%c", [gameDetails characterAtIndex:j]];
        j++;
    }
    
    j = j+7;
    
    //Get tritons score
    NSMutableString * tritonScore = [[NSMutableString alloc] init];
    while ([gameDetails characterAtIndex:j] != '-'){
        [tritonScore appendFormat:@"%c", [gameDetails characterAtIndex:j]];
        j++;
    }
    
    j++;
    
    //Opponents Score
    NSMutableString * opponentScore = [[NSMutableString alloc] init];
    while ([gameDetails characterAtIndex:j] != ')'){
        [opponentScore appendFormat:@"%c", [gameDetails characterAtIndex:j]];
        j++;
    }
    
    NSArray * retArray = [NSArray arrayWithObjects:opponent, date, tritonScore, opponentScore, nil];
    
    return retArray;
}







-(NSString *) getStatsURL: (int) i {
    NSString* description = self.pastGames[i][1];
    
    NSError *error = nil;
    
    HTMLParser *parser = [[HTMLParser alloc] initWithString: description error: &error];
    
    if (error){
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
    NSMutableString *statsURL = [[NSMutableString alloc] init];
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

-(NSArray *) getUpcomingGameDetail: (int) i {
    
    NSString * gameDetails = self.upcomingGames[i][0];
    NSMutableString * opponent = [[NSMutableString alloc] init];
    int j = 0;
    
    //Skip until ':'
    while ([gameDetails characterAtIndex:j] != ':'){
        j++;
    }
    
    //Skip to opponent name
    j = j + 5;
    
    //Get opponent name
    while(!isdigit([gameDetails characterAtIndex:j])){
        [opponent appendFormat:@"%c", [gameDetails characterAtIndex:j]];
        j++;
    }
    
    opponent = [opponent substringToIndex:[opponent length] - 2];
    
    //Get date
    NSMutableString *date = [[NSMutableString alloc] init];
    
    while([gameDetails characterAtIndex:j] != ')'){
        [date appendFormat:@"%c", [gameDetails characterAtIndex:j]];
        j++;
    }
    
    
    NSArray * retArray = [NSArray arrayWithObjects:opponent, date, nil];
    
    return retArray;
    
}

- (IBAction)pushMyNewViewController: (id) sender {
   UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    gameViewController *nextVC  = [storyboard instantiateViewControllerWithIdentifier:@"gameViewController"];
    
    UIButton *button = (UIButton *)sender;
    nextVC.gameDetailsLink = [self getStatsURL: button.tag];
    
    [self.navigationController pushViewController:nextVC animated:YES];
}

    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    


@end
