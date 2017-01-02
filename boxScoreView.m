//
//  boxScoreView.m
//  UCSDAthletics
//
//  Created by Daniel Sung on 1/1/17.
//  Copyright © 2017 Daniel Sung. All rights reserved.
//

#import "boxScoreView.h"
#import "gameViewController.h"

@implementation boxScoreView

-(void) viewDidLoad{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSURLRequest *requestURL = [NSURLRequest requestWithURL: [defaults URLForKey:@"gameURL"]];
    
    [self.boxScoreWebView loadRequest:requestURL];
}

@end
