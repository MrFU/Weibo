//
//  leftReportCell.h
//  WebPro
//
//  Created by liuny on 15-1-13.
//  Copyright (c) 2015年 szjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftReportCell : UITableViewCell//左侧cell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *clickBtn;
+ (NSString *)identifier;
@end
