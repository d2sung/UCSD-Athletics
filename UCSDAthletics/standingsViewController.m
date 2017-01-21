//
//  standingsViewController.m
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/26/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import "standingsViewController.h"
#import <Foundation/Foundation.h>


@implementation standingsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSURL *url;
    
    self.activityView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    self.activityView.center = CGPointMake(self.webView.frame.size.width/ 2.0, self.webView.frame.size.height/2.0);
    [self.webView addSubview:self.activityView];
    [self.activityView startAnimating];
    
    self.webView.delegate = self;
    
    //Get URL of either men or women
    if ([defaults boolForKey:@"gender"])
        url = [NSURL URLWithString: @"http://www.goccaa.org/standings.aspx?standings=79&path=mbball"];
    else
        url = [NSURL URLWithString: @"http://www.goccaa.org/standings.aspx?standings=82&path=wbball"];
    
    //Open URL to webview
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestURL];
}

-(void)webViewDidFinishLoad:(UIWebView *) webView{
    [self.activityView setHidden:YES];
}

@end
