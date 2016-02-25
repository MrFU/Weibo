//
//  AnalyzeScreenViewController.h
//  iSalesOANew
//
//  Created by 赵 莲锋 on 13-10-9.
//  Copyright (c) 2013年 赵 莲锋. All rights reserved.
//

/*
 ** 经营分析表头筛选
 */

#import <UIKit/UIKit.h>

@protocol EditColVCDelegate <NSObject>

- (void)selectFinish:(NSMutableArray *)selectArr;       //选择条件完成后返回数组

@end
  
@interface EditColVC : UIViewController
@property (nonatomic,assign) id <EditColVCDelegate> delegate;
@property (nonatomic,retain) NSMutableArray *dataArr;               //传递过来的数据
@property (nonatomic,retain) NSString *firstCol;                    //传递过来的数据
@property (nonatomic,retain) IBOutlet UITableView *screenTable;

- (IBAction)selectAllAction:(id)sender;     //全部勾选
- (IBAction)cancelAllAction:(id)sender;     //全部取消
- (IBAction)resetAllAction:(id)sender;      //重置

@end
