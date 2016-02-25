//
//  AnalyzeScreenCell.h
//  iSalesOANew
//
//  Created by 赵 莲锋 on 13-10-10.
//  Copyright (c) 2013年 赵 莲锋. All rights reserved.
//

/*
 * 列筛选cell
 */

#import <UIKit/UIKit.h>

@interface AnalyzeScreenCell : UITableViewCell
{
    UIImageView *titleImg;
    UILabel *titleLab;
}
@property (nonatomic,retain) IBOutlet UIImageView *titleImg;
@property (nonatomic,retain) IBOutlet UILabel *titleLab;

@end
