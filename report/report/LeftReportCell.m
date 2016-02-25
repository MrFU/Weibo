//
//  leftReportCell.m
//  WebPro
//
//  Created by liuny on 15-1-13.
//  Copyright (c) 2015年 szjn. All rights reserved.
//

#import "LeftReportCell.h"

@implementation LeftReportCell

- (void)awakeFromNib {
    // Initialization code
}

+ (NSString *)identifier
{
    static NSString *idetifierStr = @"LeftReportCell";
    return idetifierStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
