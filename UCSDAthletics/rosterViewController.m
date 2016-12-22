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
    }
    
    else {
        self.title = @"Women's Roster";
    }
    
    //Create roster
    self -> teamRoster = [[roster alloc]init];
    [self -> teamRoster buildRoster];
    self -> teamTable = self -> teamRoster.teamArray;
    
    self -> teamTable = [self -> teamTable sortedArrayUsingSelector:@selector(compare:)];
    
    self.tableViewObject.dataSource = self;
    self.tableViewObject.delegate = self;
    
    self.tableViewObject.dataSource = self;
    self.tableViewObject.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self->teamTable count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    playerProfile *player = [self->teamTable objectAtIndex: indexPath.row];
    
    //Setting name of cell
    NSString *comma = @", ";
    NSString *fullName = [ player.fName stringByAppendingString: comma];
    fullName = [fullName stringByAppendingString: player.lName];
    cell.textLabel.text = fullName;
    
    return cell;
}

-(void)tableView: (UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"playerSegue" sender:self];
}





// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    playerProfileViewController * playerController = segue.destinationViewController;
    
    playerController.player = [self -> teamTable objectAtIndex: selectedIndex];
    

    
}

@end
