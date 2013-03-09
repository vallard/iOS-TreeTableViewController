//
//  TTTableViewController.h
//  TreeTableView
//
//  Created by Vallard Benincosa on 2/25/13.
//  Copyright (c) 2013 Vallard Benincosa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTSkin.h"
#import "TTCell.h"

@class TTTableViewController;

@protocol TTTableExpanderDelegate <NSObject>

- (void)updateNumberOfTableCells:(TTTableViewController *)tableViewController numberOfCells:(NSNumber *)numberOfCells;

@end


@interface TTTableViewController : UITableViewController  <TTCellDelegate>

@property (nonatomic) NSInteger level;
@property (nonatomic, strong) NSArray *tree;
@property (nonatomic, strong) TTCell<TTTableExpanderDelegate> *delegate;
 
- (id)initWithArray:(NSArray *)tree;


@end
