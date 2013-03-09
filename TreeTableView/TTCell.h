//
//  TTCell.h
//  TreeTableView
//
//  Created by Vallard Benincosa on 2/25/13.
//  Copyright (c) 2013 Vallard Benincosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTTableViewController;
@protocol TTCellDelegate; 

@interface TTCell : UITableViewCell   {
    BOOL expanded;
    int numberOfVisibleCells;
}

@property (nonatomic, copy) NSArray *subTree;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *twister;
@property (nonatomic, strong) TTTableViewController *subTTTableViewController;
@property (nonatomic, strong) TTTableViewController<TTCellDelegate> *delegate;


- (void)twisterTapped;
- (void)twistUp;
- (void)twistDown;
- (void)showSubTable;
- (void)showTwister;
- (void)hideTwister;


@end

@protocol TTCellDelegate <NSObject>

- (void)cellSizeChanged:(TTCell *)ttCell numberOfCells:(NSNumber *)numberOfCells;

@end
