//
//  rightReportCell.h
//  WebPro
//
//  Created by liuny on 15-1-13.
//  Copyright (c) 2015年 szjn. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TagOffset   50
@interface RightReportCell : UITableViewCell//右侧cell
@property (weak, nonatomic) IBOutlet UIView *bgView;
+ (NSString *)identifier;

-(id)initWithColWidth:(NSMutableArray *)colWidth data:(NSArray *)colTypes;

//-(id)initWithColWidth:(CGFloat)colWidth textNum:(NSInteger)num hasEndButton:(BOOL)hasBtn btnTitle:(NSString *)title;
@end
