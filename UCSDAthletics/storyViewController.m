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
    
    [self style];
    [self htmlToStoryTextView];
    
    //Set title of story
    self.titleLabel.text = self.storyArray[0];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 5;
    
                            
    NSDate *pubDate = self.storyArray[3];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM-dd-YYYY"];
    NSString * dateString = [df stringFromDate:pubDate];
    
    self.dateLabel.text = dateString;
    //Set image
    [self.storyImageView setImage: self.storyArray[1]];
    
    //Adjust view size based on story length
    [self textViewDidChange:self.storyTextView];
    CGRect totHeight = self.storyContentView.frame;
    totHeight.size.height = self.storyImageView.frame.size.height + self.titleLabel.frame.size.height + self.storyTextView.frame.size.height;
    self.storyContentView.frame = totHeight;

    //Setup for scroll view
    [self.storyScrollView layoutIfNeeded];
    self.storyScrollView.contentSize = self.storyContentView.bounds.size;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*textViewDidChange:
 *
 */
- (void)textViewDidChange:(UITextView *)textView {
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    textView.frame = newFrame;
}



/* style:
 * Set bg color for view, storyTextView, titleLabel;
 */
-(void) style {
    //Background colors
    self.view.backgroundColor = [UIColor whiteColor];
    self.storyTextView.backgroundColor = [UIColor whiteColor];
    self.storyContentView.backgroundColor = [UIColor whiteColor];
    self.storyScrollView.backgroundColor = [UIColor whiteColor];
    
    //Text Colors
    self.storyTextView.textColor = [UIColor blackColor];
    self.titleLabel.textColor = [UIColor whiteColor];
}


/* htmlToStoryTextView:
 * Converts source code into textView.text;
 */
-(void) htmlToStoryTextView {
    //Get source code of HTML
    NSURLRequest *request = [NSURLRequest requestWithURL:self.storyArray[2]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    //Parse through HTML source code
    NSError *error = nil;
    HTMLParser *htmlParser = [[HTMLParser alloc] initWithString:dataString error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error);
        return;
    }
    
    //Insert <p> elements into storyView
    HTMLNode *bodyNode = [htmlParser body];
    NSArray * inputNodes = [bodyNode findChildTags:@"p"];
    NSMutableString * storyString = [[NSMutableString alloc] init];
    
    for (HTMLNode * inputNode in inputNodes){
        NSString * para  =  [NSString stringWithFormat: @"%@\n", [inputNode rawContents]];
        para = [NSString stringWithFormat: @"%@\n", para];
        [storyString appendString: para];
    }
    
   
    
    NSString * htmlString = [NSString stringWithFormat:@"<html><div style='color:#000000; font-size:13px; font-family:HelveticaNeue;'>%@</div></html>", storyString];
    
     NSMutableAttributedString *insertString = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];


    self.storyTextView.attributedText = insertString;
}

@end
