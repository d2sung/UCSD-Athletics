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
    
    if ([defaults boolForKey:@"gender"]){
        url = [NSURL URLWithString: @"http://www.goccaa.org/standings.aspx?standings=79&path=mbball"];
    }
    
    else{
        url = [NSURL URLWithString: @"http://www.goccaa.org/standings.aspx?standings=82&path=wbball"];
    }
    
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:requestURL];
    
    
}

@end
