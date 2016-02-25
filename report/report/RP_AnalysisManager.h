//
//  AnalysisManager.h
//  ChanelAssistant
//
//  Created by liuny on 15-1-28.
//  Copyright (c) 2015年 szjn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum{
    RegionMark,
    DevelopMark,
}AnalysisType;
typedef void(^MaxWidth) (NSMutableArray *maxWidth);//用于传右侧最大数据宽度（数组）
typedef void(^MaxHeadWidth) (CGFloat maxHeadWidth);//用于传左侧最大数据宽度

@interface RP_AnalysisManager : NSObject
//ViewController Title
-(NSString *)vcTitleWithType:(AnalysisType)type;

//报表的所有列名
-(NSArray *)columnTitlesWithType:(AnalysisType)type;

//报表所需数据
-(NSArray *)columnDataWithType:(AnalysisType)type showArray:(NSArray *)columnTitles;

//根据JSON数据转化为相应的data
-(NSArray *)dataListWithJSONArray:(NSArray *)array type:(AnalysisType)type;

//根据data，获取报表的第一列数据
-(NSArray *)allFirstColumnDataFromList:(NSArray *)list type:(AnalysisType)type callBack:(MaxHeadWidth)callback;

//根据data，获取报表除第一列外其他列的所有数据,返回的NSArray中存放的是NSArray元素
-(NSArray *)allColumnDataExceptFirstFromList:(NSArray *)list type:(AnalysisType)type callBack:(MaxWidth)callback;

//请求服务器
-(void)requestWithCurrPage:(int)currPage
                  dealDate:(NSString *)dealDate
                   orgCode:(NSString *)orgCode
                  orgLevel:(NSString *)orgLevel
                      type:(AnalysisType)type
                   success:(void (^)(NSDictionary *result))success
                      fail:(void (^)(NSString *errorMsg))fail;

-(NSArray *)dataForEndBtnFormList:(NSArray *)list type:(AnalysisType)type;

//报表下钻数据
-(NSArray *)dataForLinkFormList:(NSArray *)list type:(AnalysisType)type currLevel:(NSString *)level;
@end
