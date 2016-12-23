//
//  rosterViewController.m
//  UCSDAthletics
//
//  Created by Daniel Sung on 12/22/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

#import "rosterViewController.h"
#import "playerProfile.h"
#import "roster.h"
#import "playerProfileViewController.h"

@interface rosterViewController ()

@end

@implementation rosterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set navbar title
    if ([self.genderString  isEqual: @"men"]){
        self.title = @"Men's Roster";
        //build men roster
        //Create roster
        self -> teamRoster = [[roster alloc]init];
        [self -> teamRoster buildRoster: true];
        self -> teamTable = self -> teamRoster.teamArray;
    
    }
    else {
        self.title = @"Women's Roster";
        //build women roster
        //Create roster
        self -> teamRoster = [[roster alloc]init];
        [self -> teamRoster buildRoster: false];
        self -> teamTable = self -> teamRoster.teamArray;
    }
    /*
    //Create roster
    self -> teamRoster = [[roster alloc]init];
    [self -> teamRoster buildRoster: false];
    self -> teamTable = self -> teamRoster.teamArray;
     */
    
    //Sort array alphabetically
    self -> teamTable = [self -> teamTable sortedArrayUsingSelector:@selector(compare:)];
    
    self.tableViewObject.dataSource = self;
    self.tableViewObject.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/* numberOfRowsInSection:
 * Return teamTable (NSArray) length
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self->teamTable count];
}


/* cellForRowAtIndexPath:
 * Set name to each UITableView cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    playerProfile *player = [self->teamTable objectAtIndex: indexPath.row];
    
    //Set label of cell to player
    if (![player.fName isEqual: @"Team"]){
        NSString *comma = @", ";
        NSString *fullName = [ player.lName stringByAppendingString: comma];
        fullName = [fullName stringByAppendingString: player.fName];
        cell.textLabel.text = fullName;
    }
    
    //If cell name is TEAM TOTAL
    else {
        cell.textLabel.text = @"- Team Totals - ";
    }
    
    return cell;
}


/* didSelectRowAtIndexPath:
 * Segue to playerViewController when cell is selected
 */
-(void)tableView: (UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"playerSegue" sender:self];
}


/* prepareForSegue:
 * Set the player variable accordingly before segueing to destination view (playerViewController)
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    playerProfileViewController * playerController = segue.destinationViewController;
    
    playerController.player = [self -> teamTable objectAtIndex: selectedIndex];
    

    
}

@end
