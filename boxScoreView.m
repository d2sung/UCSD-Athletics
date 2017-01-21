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
    
    self.activityView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    self.activityView.center = CGPointMake(self.boxScoreWebView.frame.size.width/ 2.0, self.boxScoreWebView.frame.size.height/2.0);
    [self.boxScoreWebView addSubview:self.activityView];
    [self.activityView startAnimating];
    
    [self.boxScoreWebView loadRequest:requestURL];
    
    self.boxScoreWebView.delegate = self;
}

-(void)webViewDidFinishLoad:(UIWebView *) webView{
    [self.activityView setHidden:YES];
}


@end
