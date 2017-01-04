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
        
        UILabel * away= [[UILabel alloc] initWithFrame: CGRectMake(10, 35, 140, 65)];
        UILabel * awayScore =[[UILabel alloc] initWithFrame: CGRectMake(50, 75, 90, 50)];
        UILabel * home = [[UILabel alloc] initWithFrame: CGRectMake(170, 35, 140, 65)];
        UILabel * homeScore =[[UILabel alloc] initWithFrame: CGRectMake(170, 75, 90, 50)];
        UILabel * date =[[UILabel alloc] initWithFrame: CGRectMake(10, -10, 140, 65)];
        UILabel * at = [[UILabel alloc] initWithFrame: CGRectMake(155, 35, 40, 65)];
        
        UIImageView * arrow = [[UIImageView alloc] initWithFrame: CGRectMake(290, 10, 24, 24)];
        arrow.image = [UIImage imageNamed:@"rightArrow"];
        [view addSubview: arrow];
        
        
        
        homeScore.textAlignment = NSTextAlignmentRight;
        home.textAlignment = NSTextAlignmentRight;
        at.text = @"@";
        
        
        if ([gameDetails[4] isEqualToString:@"<p>at UC San Diego"]){
            away.text = gameDetails[0];
            UIImageView * ucsd_logo = [[UIImageView alloc] initWithFrame: CGRectMake(190, 35, 120, 65)];
            
            ucsd_logo.image = [UIImage imageNamed:@"ucsd_logo"];
            [view addSubview: ucsd_logo];
            home.lineBreakMode = NSLineBreakByWordWrapping;
            away.numberOfLines = 2;
            away.lineBreakMode = NSLineBreakByWordWrapping;
            home.numberOfLines = 2;
            date.text = gameDetails[1];
            homeScore.text = gameDetails[2];
            awayScore.text = gameDetails[3];
        }
        
        else {
            UIImageView * ucsd_logo = [[UIImageView alloc] initWithFrame: CGRectMake(10, 30, 120, 65)];
            ucsd_logo.image = [UIImage imageNamed:@"ucsd_logo"];
            [view addSubview: ucsd_logo];
            home.text = gameDetails[0];
            home.lineBreakMode = NSLineBreakByWordWrapping;
            home.numberOfLines = 2;
            away.numberOfLines = 2;
            away.lineBreakMode = NSLineBreakByWordWrapping;
            date.text = gameDetails[1];
            awayScore.text = gameDetails[2];
            homeScore.text = gameDetails[3];
            
        }
        
        
        home.textColor = [UIColor blackColor];
        away.textColor = [UIColor blackColor];
        date.textColor = [UIColor blackColor];
        at.textColor = [UIColor blackColor];
        
        
        if ([homeScore.text integerValue] > [awayScore.text integerValue]){
            homeScore.textColor = [UIColor colorWithRed:0.96 green:0.72 blue:0 alpha:.75];            awayScore.textColor = [UIColor blackColor];
            
        }
        
        else {
            homeScore.textColor = [UIColor blackColor];
            awayScore.textColor = [UIColor colorWithRed:0.96 green:0.72 blue:0 alpha:.75];;
        }
        
        
        away.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size: 15];
        home.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size: 15];
        awayScore.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size: 20];
        homeScore.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size: 20];
        at.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size: 15];
        
        
        
        UIButton *button = [[UIButton alloc] initWithFrame: CGRectMake(0, self.y, 320, 150)];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        button.tag = i;
        
        [button addTarget:self
                   action:@selector(pushMyNewViewController:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview: home];
        [view addSubview: away];
        [view addSubview: awayScore];
        [view addSubview: homeScore];
        [view addSubview: date];
        [view addSubview: at];
        
        [self.contentView addSubview: view];
        [self.contentView addSubview: button];
        
        self.y = self.y + 151;
    }
        
}
    
-(void) createUpcomingGameTiles {
        for (int i = 0; i < [self.upcomingGames count]; i++){
            UIView *view = [[UIView alloc] initWithFrame: CGRectMake(0, self.y, 320, 150)];
            view.backgroundColor = [UIColor colorWithRed:0.02 green:0.16 blue:0.36 alpha:.60];
    
            NSArray * gameDetails = [self getUpcomingGameDetail: i];
            
            UILabel * away = [[UILabel alloc] initWithFrame: CGRectMake(10, 45, 140, 65)];
            UILabel * home = [[UILabel alloc] initWithFrame: CGRectMake(170, 45, 140, 65)];
            UILabel *date =[[UILabel alloc] initWithFrame: CGRectMake(10, -10, 140, 65)];
            UILabel * at = [[UILabel alloc] initWithFrame: CGRectMake(155, 45, 40, 65)];
          
            home.textAlignment = NSTextAlignmentRight;
            at.text = @"@";

            if ([gameDetails[2] isEqualToString:@"<p>at UC San Diego"]){
                away.text = gameDetails[0];
                UIImageView * ucsd_logo = [[UIImageView alloc] initWithFrame: CGRectMake(190, 40, 120, 65)];
                
                ucsd_logo.image = [UIImage imageNamed:@"ucsd_logo"];
                [view addSubview: ucsd_logo];

                away.numberOfLines = 2;
                away.lineBreakMode = NSLineBreakByWordWrapping;
                date.text = gameDetails[1];
            
            }
            
            else {
                UIImageView * ucsd_logo = [[UIImageView alloc] initWithFrame: CGRectMake(10, 40, 120, 65)];
                ucsd_logo.image = [UIImage imageNamed:@"ucsd_logo"];
                
                [view addSubview: ucsd_logo];
                home.text = gameDetails[0];
                home.lineBreakMode = NSLineBreakByWordWrapping;
                home.numberOfLines = 2;
                
                date.text = gameDetails[1];
                
            }

            
            home.textColor = [UIColor whiteColor];
            away.textColor = [UIColor whiteColor];
            date.textColor = [UIColor whiteColor];
            at.textColor = [UIColor whiteColor];
            
            home.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size: 17];
            away.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size: 17];
            [self.contentView addSubview: view];
            
            [view addSubview: home];
            [view addSubview: away];
            [view addSubview: date];
            [view addSubview: at];
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
    
    NSString *location = self.pastGames[i][1];
    
    location = [location substringToIndex:18];
    
    NSArray *retArray = @[opponent, date, tritonScore, opponentScore, location, @5 ];
    
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
    
    NSString *location = self.upcomingGames[i][1];
    
    location = [location substringToIndex:18];
    
    NSArray *retArray = @[opponent, date, location, @3 ];

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
