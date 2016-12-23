//
//  arrayTest.m
//  test
//
//  Created by Daniel Sung on 12/29/15.
//  Copyright (c) 2015 Daniel Sung. All rights reserved.
//

#import "roster.h"
#import "playerProfile.h"
#import "statsParser.h"
#import "bioParser.h"
@implementation roster

//Initialization
- (instancetype)init {
    self = [super init];
    if (self) {
        self.teamArray = [[NSMutableArray alloc]init];
    
    }
    return self;
}

//Build the roster
-(void) buildRoster: (bool) isMen {
    
    //Stats parser
    statsParser *parser = [[statsParser alloc]init];
    NSString *statSheet = [[NSString alloc]init];
    statSheet = [parser getStats:isMen];
    
    //Bio parser
    bioParser *bParser = [[bioParser alloc] init];
    NSString *bioSheet = [[NSString alloc] init];
    bioSheet = [bParser getBio:isMen];
    
    
    
    // creating team roster array
    self.teamArray = [[NSMutableArray alloc]init];
    //Starting point of statsheet
    int idx = 278;
    //starting point of biosheet
    int bidx;
    
    //If women, start at 71 because missing weight
    if (isMen)
        bidx = 79;
    else
        bidx = 71;
    
    
    //Get number of players on team
    unsigned numberOfLines, index, stringLength = [statSheet length];
    
    for (index = 0, numberOfLines = 0; index < stringLength; numberOfLines++)
        index = NSMaxRange([statSheet lineRangeForRange:NSMakeRange(index, 0)]);
    
    
    //For number of players in list, add player to roster
    for(int playerIdx = 0; playerIdx < numberOfLines - 5; playerIdx++){
        playerProfile *addingPlayer = [[playerProfile alloc] init];
        
        //Parse through stats
        addingPlayer.number =[parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.lName = [parser parseLastName:statSheet:idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.fName = [parser parseFirstName:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.gp = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.gs = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.totMin = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.avgMin = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.fgMade = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.fgAttempts = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.fgPct = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.threeFg = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.threeAttempts = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.threePct = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.ft = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.ftAttempts = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.ftPct = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.offReb = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.defReb = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.reb = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.rpg = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.fouls = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.foulOuts = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.assists = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.to = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.blk = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.stl = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.pts = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.ppg = [parser parseIntEntry:statSheet :idx];
            idx = [self iterateThroughCommas:statSheet: idx];
        addingPlayer.apg = [parser parseIntEntry:statSheet :idx];
        
        /******************Parse through bio***********************/
        
        //First, skip through number and name
        bidx = [self iterateThroughCommas:bioSheet: bidx];
        bidx = [self iterateThroughCommas:bioSheet: bidx];
        
        addingPlayer.position = [bParser parseStringEntry:bioSheet :bidx];
        bidx = [self iterateThroughCommas:bioSheet: bidx];
        addingPlayer.height = [bParser parseStringEntry:bioSheet :bidx];
        
        //Women does not have weight
        if(isMen){
            bidx = [self iterateThroughCommas:bioSheet: bidx];
            addingPlayer.weight = [bParser parseStringEntry:bioSheet :bidx];
        }
        
        bidx = [self iterateThroughCommas:bioSheet: bidx];
        addingPlayer.year = [bParser parseStringEntry:bioSheet :bidx];
        bidx = [self iterateThroughCommas:bioSheet: bidx];
        addingPlayer.major = [bParser parseStringEntry:bioSheet :bidx];
        bidx = [self iterateThroughCommas:bioSheet: bidx];
        addingPlayer.background = [bParser parseBackgroundEntry:bioSheet :bidx];
        bidx = [self iterateThroughCommas:bioSheet: bidx];
        
        //Add player to roster array
        [self.teamArray addObject:addingPlayer];
    }
    
    //Skip to team stats
    idx = [self iterateToNextLine:statSheet :idx];

    //Adding Team Total
    _teamPlayer = [[playerProfile alloc] init];
    
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.lName = [parser parseLastName:statSheet:idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.fName = @"Team";
    _teamPlayer.gp = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.totMin = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.fgMade = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.fgAttempts = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.fgPct = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.threeFg = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.threeAttempts = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.threePct = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.ft = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.ftAttempts = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.ftPct = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.offReb = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.defReb = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.reb = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.rpg = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.fouls = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.foulOuts = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.assists = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.to = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.blk = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.stl = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.pts = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.ppg = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateThroughCommas:statSheet: idx];
    _teamPlayer.apg = [parser parseIntEntry:statSheet :idx];
        idx = [self iterateToNextLine:statSheet :idx];
    
    //[self.teamArray addObject:addingPlayer];
}

-(int) iterateThroughCommas: (NSString*)statSheet :(int) curIndex{
    while([statSheet characterAtIndex:curIndex] != ','){
        curIndex++;
    }
    curIndex++;
    return curIndex;
}

-(int) iterateToNextLine: (NSString*)statSheet :(int) curIndex{
    while([statSheet characterAtIndex:curIndex] != '\n'){
        curIndex++;
    }
    curIndex++;
    return curIndex;
}

//Add playerProfile to roster
-(void)addPlayer:(playerProfile *)player{
    [self.teamArray addObject:player];
}

@end
