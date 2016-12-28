//
//  storyViewController.m
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/27/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import "storyViewController.h"
#import "HTMLParser.h"
#import "HTMLNode.h"

@interface storyViewController ()

@end

@implementation storyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.00 green:0.22 blue:0.44 alpha:0.95];
    self.storyTextView.backgroundColor = [UIColor colorWithRed:0.00 green:0.22 blue:0.44 alpha:0.95];
    self.storyTextView.textColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0];
    
    self.titleLabel.textColor = [UIColor colorWithRed:0.96 green:0.80 blue:0.05 alpha:0.75];

    
    self.titleLabel.text = self.storyArray[0];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 2;
    
    [self.storyImageView setImage: self.storyArray[1]];
    
    
    
    
    //Convert story into string
    NSURLRequest *request = [NSURLRequest requestWithURL:self.storyArray[2]];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    
    //Parse through HTML source code
    NSError *error = nil;
    HTMLParser *htmlParser = [[HTMLParser alloc] initWithString:dataString error:&error];
    
    if (error){
        NSLog(@"Error: %@", error);
        return;
    }
    
    HTMLNode *bodyNode = [htmlParser body];
    NSArray * inputNodes = [bodyNode findChildTags:@"p"];
    
    NSMutableString * storyString = [[NSMutableString alloc] init];
    
    for (HTMLNode * inputNode in inputNodes){
        NSString * para  =  [NSString stringWithFormat: @"%@\n", [inputNode allContents]];
        para = [NSString stringWithFormat: @"%@\n", para];
        [storyString appendString: para];
    }
    
    self.storyTextView.text = storyString;
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
