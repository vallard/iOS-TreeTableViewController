//
//  TTSkin.h
//  TreeTableView
//
//  Created by Vallard Benincosa on 2/25/13.
//  Copyright (c) 2013 Vallard Benincosa. All rights reserved.
//

#ifndef TreeTableView_TTSkin_h
#define TreeTableView_TTSkin_h

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// TABLE VIEW
#define TABLEVIEW_BACKGROUND_COLOR UIColorFromRGB(0x550011)
#define TABLEVIEW_SEPARATOR_COLOR UIColorFromRGB(0x555555)

// Table Cell Height
#define TABLE_CELL_HEIGHT 44.0
#define TABLE_CELL_COLOR UIColorFromRGB(0x555550)
#define TABLE_FONT_COLOR UIColorFromRGB(0xeeeeee)
#define TABLE_INDENTATION_SIZE 5.0
/* 
 Make sure TWISTER_BOX_SIZE is not greater than TABLE_CELL_HEIGHT
 */
#define TWISTER_BOX_SIZE 40.0   

#endif
