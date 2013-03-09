//
//  TTCell.m
//  TreeTableView
//
//  Created by Vallard Benincosa on 2/25/13.
//  Copyright (c) 2013 Vallard Benincosa. All rights reserved.
//

#import "TTCell.h"
#import "TTTableViewController.h"
#import "TTSkin.h"


@interface TTCell() <TTTableExpanderDelegate>

@end


@implementation TTCell




- (UILabel *)label {
    if (!_label) {
        CGRect labelRect = CGRectMake(TWISTER_BOX_SIZE, 0, self.frame.size.width - TWISTER_BOX_SIZE, TABLE_CELL_HEIGHT);
        _label = [[UILabel alloc] initWithFrame:labelRect];
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = TABLE_FONT_COLOR;
        _label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_label];

    }
    return _label;
}

- (UIButton *)twister {
    if (!_twister ) {
        float y = (TABLE_CELL_HEIGHT - TWISTER_BOX_SIZE) / 2;
        CGRect twisterRect = CGRectMake(0, y, TWISTER_BOX_SIZE, TWISTER_BOX_SIZE);
        _twister = [[UIButton alloc] initWithFrame:twisterRect];
        [_twister setImage:[UIImage imageNamed:@"disclosure"] forState:UIControlStateNormal];
        [_twister addTarget:self action:@selector(twisterTapped) forControlEvents:UIControlEventTouchUpInside];
        _twister.alpha = 0.45;
    }
    return _twister;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = TABLE_CELL_COLOR;
        self.contentView.clipsToBounds = YES;
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)showTwister{
    [self.contentView addSubview:self.twister];
}

- (void)hideTwister{
    if (self.twister) {
        [self.twister removeFromSuperview];
    }
}



- (void)showSubTable {
    NSRange myRange;
    myRange.location =1;
    myRange.length = [self.subTree count] - 1;
    NSArray *subArray = [self.subTree subarrayWithRange:myRange];
    self.subTTTableViewController = [[TTTableViewController alloc] initWithArray:subArray];
    
    UIView *parentView = [self superview];
    CGRect parentRect = parentView.frame;
    CGRect tableRect = CGRectMake(parentRect.origin.x + TABLE_INDENTATION_SIZE, TABLE_CELL_HEIGHT, parentRect.size.width - TABLE_INDENTATION_SIZE, TABLE_CELL_HEIGHT*([self.subTree count] - 1) );
    //NSLog(@"tableRect %f, %f, %f, %f", tableRect.origin.x, tableRect.origin.y, tableRect.size.width, tableRect.size.height);
    
    self.subTTTableViewController.view.frame = tableRect;
    self.subTTTableViewController.delegate = self;
    [self addSubview:self.subTTTableViewController.view];
    
    
}


- (void)twistDown {
    // twist down (expand)
    [UIView beginAnimations:@"Rotate Down" context:nil];
    [UIView setAnimationDuration:0.2];
    self.twister.transform = CGAffineTransformMakeRotation(M_PI*2.5);
    [UIView commitAnimations];
}

- (void)twistUp {
    // twist up (collapse)
    [UIView beginAnimations:@"rotateDisclosureButt" context:nil];
    [UIView setAnimationDuration:0.2];
    self.twister.transform = CGAffineTransformMakeRotation(M_PI*2);
    [UIView commitAnimations];
}

- (void)twisterTapped {
    if (expanded) {
        [self twistUp];
        expanded = NO;
        // not expanded anymore.  remove total visible cells except one!
        NSLog(@"new size of cell in containing table: %d", 1);
        
        [self.delegate cellSizeChanged:self numberOfCells:[NSNumber numberWithInt:1]];

        // find some way to close everyone elses trees or remember the size.
    }else {
        [self twistDown];
        expanded = YES;
        // expand, make bigger.
    
        if (! numberOfVisibleCells) {
            numberOfVisibleCells = [self.subTree count];
        }
        NSLog(@"new size of cell in containing table: %d", numberOfVisibleCells);
        [self.delegate cellSizeChanged:self numberOfCells:[NSNumber numberWithInt:(numberOfVisibleCells)]];
    }

}

#pragma mark -
#pragma mark - TTTableExpanderDelegate Method

// Double recursion!  Agghhh!
- (void)updateNumberOfTableCells:(TTTableViewController *)tableViewController numberOfCells:(NSNumber *)numberOfCells {
    // tack on one for the first cell?
    
    NSLog(@"UPDATNUMBEROFTABLECELLS");
    //assert(numberOfCells.intValue >= [self.subTree count]);
    if (numberOfCells.intValue < [self.subTree count] && expanded) {
        numberOfCells = [NSNumber numberWithInt:[self.subTree count]];
    }
    numberOfVisibleCells = numberOfCells.intValue;
    NSLog(@"\theight of table is will now be: %d", numberOfVisibleCells);
    [self.delegate cellSizeChanged:self numberOfCells:numberOfCells];
}


@end
