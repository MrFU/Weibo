//
//  AnalyzeScreenCell.m
//  iSalesOANew
//
//  Created by 赵 莲锋 on 13-10-10.
//  Copyright (c) 2013年 赵 莲锋. All rights reserved.
//

#import "AnalyzeScreenCell.h"

@implementation AnalyzeScreenCell

@synthesize titleImg;
@synthesize titleLab;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
