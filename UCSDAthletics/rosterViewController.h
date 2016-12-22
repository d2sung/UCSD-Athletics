//
//  rosterViewController.h
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/22/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "playerProfile.h"
#import "roster.h"

@interface rosterViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    
    roster * teamRoster;
    NSArray * teamTable;
    NSInteger selectedIndex;
}

@property (weak, nonatomic) IBOutlet UITableView *tableViewObject;
@property(strong, nonatomic) NSString * genderString;


@end
