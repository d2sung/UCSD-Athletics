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
#import "appDelegate.h"

@interface rosterViewController ()

@end

@implementation rosterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupStyle];
    
    
    //Get AppDelegate and defaults
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //Set tabbar title
    if ([defaults boolForKey:@"gender"]){
        [self.tabBarController setTitle:@"Men's Basketball"];
        self -> teamTable = appDelegate.mBballRoster.teamArray;
    }
    
    else {
        [self.tabBarController setTitle:@"Women's Basketball"];
        self -> teamTable = appDelegate.wBballRoster.teamArray;
    }
    
    //Sort array alphabetically
    self -> teamTable = [self -> teamTable sortedArrayUsingSelector:@selector(compare:)];
    
    //Set Delegates
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
        cell.textLabel.textColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0];
        
        if(indexPath.row % 2 == 0)
            cell.backgroundColor = [UIColor colorWithRed:0.00 green:0.22 blue:0.44 alpha:1.0];
        else
            cell.backgroundColor = [UIColor colorWithRed:0.00 green:0.22 blue:0.44 alpha:0.96];
    }
    
    //If cell name is TEAM TOTAL
    else
        cell.textLabel.text = @"- Team Totals - ";
    
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

-(void) setupStyle {
    self.view.backgroundColor = [UIColor colorWithRed:0.00 green:0.22 blue:0.44 alpha:0.95];
}

@end
