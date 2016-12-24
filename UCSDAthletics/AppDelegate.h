//
//  AppDelegate.h
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/21/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "roster.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property roster * mBballRoster;
@property roster * wBballRoster;

@property (strong, nonatomic) UIWindow *window;


@end

