//
//  main.m
//  tritonBasketball
//
//  Created by Daniel Sung on 12/27/15.
//  Copyright (c) 2015 Daniel Sung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "playerProfile.h"
#import "statsParser.h"
#import "roster.h"
#import "DBManager.h"
#import <sqlite3.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        roster *team = [[roster alloc] init];
        [team buildRoster:false];
        
        NSArray *teamRoster = [[NSArray alloc]init];
        teamRoster = team.teamArray;
        
        playerProfile *rand = [[playerProfile alloc]init];
        rand = [teamRoster objectAtIndex:2];
        
        NSLog(@"number: %@", rand.number);
        NSLog(@"Last name: %@", rand.lName);
        NSLog(@"First name: %@", rand.fName);
        NSLog(@"height: %@", rand.height);
        NSLog(@"weight: %@", rand.weight);
        NSLog(@"position: %@", rand.position);
        NSLog(@"year: %@", rand.year);
        NSLog(@"major: %@", rand.major);
        NSLog(@"background: %@", rand.background);
        NSLog(@"gamesplayed: %d", rand.gp);
        NSLog(@"total minutes%d", rand.totMin);
        //NSLog(@"%f", rand.avgMin);
        NSLog(@"fg made: %d", rand.fgMade);
        NSLog(@"fg attempts %d", rand.fgAttempts);
        NSLog(@"fg pct %f", rand.fgPct);
        NSLog(@"three fg %d", rand.threeFg);
        NSLog(@"three attempts %d", rand.threeAttempts);
        NSLog(@"three pct: %f", rand.threePct);
        NSLog(@"free throw made: %d", rand.ft);
        NSLog(@"free throw attempts: %d", rand.ftAttempts);
        NSLog(@"ft pct: %f", rand.ftPct);
        NSLog(@"off rebounds: %d", rand.offReb);
        NSLog(@"def reboudns: %d", rand.defReb);
        NSLog(@"total rebounds: %d", rand.reb);
        NSLog(@"avg rebounds: %f", rand.rpg);
        NSLog(@"fouls: %d", rand.fouls);
        NSLog(@"foul outs: %d", rand.foulOuts);
        NSLog(@"assists: %d", rand.assists);
        NSLog(@"turnovers: %d", rand.to);
        NSLog(@"blks: %d", rand.blk);
        NSLog(@"stl: %d", rand.stl);
        NSLog(@"pts: %d", rand.pts);
        NSLog(@"ppg: %f", rand.ppg);
        NSLog(@"apg: %f", rand.apg);





        
        
        
        
      
        
    }
    return 0;
}
