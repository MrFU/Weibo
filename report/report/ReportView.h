//
//  ReportView.h
//  WebPro
//
//  Created by liuny on 15-1-13.
//  Copyright (c) 2015年 szjn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportData.h"

@protocol ReportViewDelegate <NSObject>
- (void)didClickButtonAtRow:(NSInteger)row col:(NSInteger)col title:(NSString *)title;
- (void)didScroll:(UIScrollView *)scrollView;
- (void)didClickLinkWithSelectIndex:(NSInteger)index;
@end

@interface ReportView : UIView<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    NSUInteger rightColCount;
}
@property (assign, nonatomic) id<ReportViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *leftTable;
@property (weak, nonatomic) IBOutlet UITableView *rightTable;
@property (weak, nonatomic) IBOutlet UIScrollView *rightScroll;

@property (strong, nonatomic) NSArray *leftData;
@property (strong, nonatomic) NSArray *rightData;
@property (strong, nonatomic) NSArray *linkData;
@property (strong, nonatomic) NSArray *columns;  //列名

//初始化相关数据及最大宽度问题
-(ReportView *)initWithLeftData:(NSArray *)leftDataT rightData:(NSArray *)rightDataT columnsTitle:(NSArray *)columnsT columnsMaxWidth:(NSMutableArray *)columnsMaxWidth maxHeadWidth:(CGFloat)maxHeadWidth columnsRightMaxWidth:(NSMutableArray *)columnsRightMaxWidth maxLeftHeadWidth:(CGFloat)maxLeftHeadWidth;

//最后有按钮
-(ReportView *)initWithLeftData:(NSArray *)leftDataT rightData:(NSArray *)rightDataT columnsTitle:(NSArray *)columnsT hasEndBtn:(BOOL)hasBtn btnTitle:(NSString *)title btnShowData:(NSArray *)btnDataT;

-(void)refresh;
@end
