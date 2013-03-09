//
//  TTTableViewController.m
//  TreeTableView
//
//  Created by Vallard Benincosa on 2/25/13.
//  Copyright (c) 2013 Vallard Benincosa. All rights reserved.
//

#import "TTTableViewController.h"
#import "TTCell.h"

#define TTCELL_IDENTIFIER @"TTCell"


@interface TTTableViewController ()

@property (nonatomic, strong) NSMutableDictionary *cellHeights;

@end

@implementation TTTableViewController

@synthesize cellHeights = _cellHeights;


#pragma mark - TTCell Delegate Methods

// look out!  Double recursion!!
- (void)cellSizeChanged:(TTCell *)ttCell numberOfCells:(NSNumber *)numberOfCells {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:ttCell];
    if (numberOfCells.intValue == 1) {
        [self.cellHeights removeObjectForKey:indexPath];
    }else {
        [self.cellHeights setObject:numberOfCells forKey:indexPath];  // this is now the size of our cell.
    }
    
    if (self.delegate) {
        int tableHeight = [self.tree count];
        for (id key in self.cellHeights){
            int thisHeight = ((NSNumber *)[self.cellHeights objectForKey:key]).intValue;
            tableHeight += thisHeight;  // this height takes the place of the old height.
            tableHeight -= 1;  // subtract the standard height of the cell
        }
        tableHeight += 1; // add the height of the cell header which is not in this tree.
        [self.delegate updateNumberOfTableCells:self numberOfCells:[NSNumber numberWithInt:tableHeight]];
    }
    // I found this cool trick on the internet.  Resizes cells without reloading data!
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}



#pragma mark - Init Methods
- (id)initWithArray:(NSArray *)tree{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.tree = tree;
        self.level = 0;
        self.cellHeights = [[NSMutableDictionary alloc] init];
    }
    return self;
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[TTCell class] forCellReuseIdentifier:TTCELL_IDENTIFIER];
    //self.tableView.rowHeight = TABLE_CELL_HEIGHT;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = TABLEVIEW_BACKGROUND_COLOR;
    //self.tableView.separatorColor = TABLEVIEW_SEPARATOR_COLOR;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // We don't support sections in Tree Table View
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tree count];
}

// recursive function to get the first element of the sub tree.
// goes all the way down to the bottom most turtle.

- (NSString *)getRootForBranch:(NSObject *)item {
    if ([item isKindOfClass:[NSString class]]) {
        return (NSString *)item;
    }else if([item isKindOfClass:[NSArray class]]){
        return [self getRootForBranch:[(NSArray *)item objectAtIndex:0]];
    }else {
        NSLog(@"errror in data formation.  This should not happen");
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TTCell *cell = [tableView dequeueReusableCellWithIdentifier:TTCELL_IDENTIFIER forIndexPath:indexPath];
    cell.delegate = self;
    cell.label.text = [self getRootForBranch:[self.tree objectAtIndex:indexPath.row]];
    if ([[self.tree objectAtIndex:indexPath.row] isKindOfClass:[NSArray class]]) {
        cell.subTree = [self.tree objectAtIndex:indexPath.row];
        [cell showTwister];
        [cell showSubTable];
    }else {
        [cell hideTwister];
    }    
    return cell;
}

#pragma mark - Table Appearance Properties


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heightForCell = TABLE_CELL_HEIGHT;
    if ([self.cellHeights objectForKey:indexPath]) {
        heightForCell = [(NSNumber *)[self.cellHeights objectForKey:indexPath] floatValue] * TABLE_CELL_HEIGHT;
    }

    return heightForCell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
      *detailViewController = [[ta alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
