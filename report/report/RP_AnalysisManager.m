//
//  AnalysisManager.m
//  ChanelAssistant
//
//  Created by liuny on 15-1-28.
//  Copyright (c) 2015年 szjn. All rights reserved.
//

#import "RP_AnalysisManager.h"
#import "ReportData.h"
#import "DevelopListModel.h"
#import <UIKit/UIKit.h>
@interface RP_AnalysisManager()
@property(nonatomic,strong)NSMutableArray *maxWidth;
@property(nonatomic,assign)CGFloat maxHeadWidth;
@end
@implementation RP_AnalysisManager
-(NSString *)vcTitleWithType:(AnalysisType)type
{
    NSString *rtn = nil;
    switch (type) {
        case RegionMark:
            rtn = @"地市对标-收入";
            break;
        case DevelopMark:
            rtn = @"地市对标-发展";
            break;
        default:
            break;
    }
    return rtn;
}

//报表的所有列名
-(NSArray *)columnTitlesWithType:(AnalysisType)type
{
    NSArray *array;
    switch (type) {
        case RegionMark:
            array = @[@"地市",@"累计收入",@"累计收入环比",@"移动业务",@"移动环比",@"固网",@"固网环比",@"宽带",@"宽带环比",@"双线",@"双线环比"];
            break;
        case DevelopMark:
            array = @[@"地市",@"移动发展",@"移动发展环比",@"后付发展",@"后付发展环比",@"预付发展",@"预付发展环比",@"宽带发展",@"宽带发展环比",@"双线发展",@"双线发展环比",@"智慧沃家",@"智慧沃家环比"];
            break;
        default:
            break;
    }    return array;
}

-(NSArray *)columnDataWithType:(AnalysisType)type showArray:(NSArray *)columnTitles
{
    NSMutableArray *rtn = [[NSMutableArray alloc] init];
    switch (type) {
        case RegionMark:
            for(NSString *str in columnTitles){
                [rtn addObject:[[ReportColData alloc] initWithType:TableColType_Label title:str]];
            }
            break;
        case DevelopMark:
            for(NSString *str in columnTitles){
                [rtn addObject:[[ReportColData alloc] initWithType:TableColType_Label title:str]];
            }
            break;
        default:
            break;
    }
    return rtn;
}

-(NSArray *)cellDataWithType:(AnalysisType)type list:(NSArray *)allDatas
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    switch (type) {
        default:
            break;
    }
    return array;
}

//根据JSON数据转化为相应的data
-(NSArray *)dataListWithJSONArray:(NSArray *)array type:(AnalysisType)type
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    switch (type) {
        case RegionMark:
            for(NSDictionary *dic in array){
                //                AddQueryListModel *addModel = [[AddQueryListModel alloc] initWithDict:dic];
                //                [dataList addObject:addModel];
            }
            break;
        case DevelopMark:
            for(NSDictionary *dic in array){
                DevelopListModel *addModel = [[DevelopListModel alloc] initWithDict:dic];
                [list addObject:addModel];
                NSLog(@"%@",list);
            }
            break;
        default:
            break;
    }
    return list;
}

//根据data，获取报表的第一列数据
-(NSArray *)allFirstColumnDataFromList:(NSArray *)list type:(AnalysisType)type callBack:(MaxHeadWidth)callback
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    switch (type) {
        case RegionMark:
            //            for(AddQueryListModel *model in list){
            //                [dataList addObject:model.addTime];
            //            }
            break;
        case DevelopMark:
        {
           // _maxHeadWidth = 0;
            for(DevelopListModel *model in list){
                [array addObject:model.region];
                NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName];
                if (model.region) {
                    NSString *str = [NSString stringWithFormat:@"%@",model.region];
                    CGSize size = [str sizeWithAttributes:attributes];
//                    if(_maxHeadWidth < size.width){
//                        _maxHeadWidth = size.width;
//                    }
                    _maxHeadWidth = size.width;
                }
            }
            NSLog(@"第一列内容最大宽度%f",_maxHeadWidth);
            callback(_maxHeadWidth);
        }
            break;
        default:
            break;
    }
    return array;
}

//根据data，获取报表除第一列外其他列的所有数据,返回的NSArray中存放的是NSArray元素
-(NSArray *)allColumnDataExceptFirstFromList:(NSArray *)list type:(AnalysisType)type callBack:(MaxWidth)callback
{
    NSMutableArray *rtn = [[NSMutableArray alloc] init];
    switch (type) {
        case DevelopMark:
        {
            self.maxWidth = [[NSMutableArray alloc]init];
//            for (int i = 0 ; i < 12; i++) {
//                [self.maxWidth addObject:@(i)];
//            }
            for(DevelopListModel *model in list){
                NSArray *array = @[model.ydDevelop,
                                   model.ydhbDevelop,
                                   model.hfDevelop,
                                   model.hfhbDevelop,
                                   model.yfDevelop,
                                   model.yfhbDevelop,
                                   model.kdDevelop,
                                   model.kdhbDevelop,
                                   model.sxDevelop,
                                   model.sxhbDevelop,
                                   model.zhwj,
                                   model.zhwjhb
                                   ];
                NSMutableArray *cellDatas = [[NSMutableArray alloc] init];
                NSLog(@"%@",array);
                for (int i = 0;i < array.count ;i++) {
                    
                    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName];
                    if (array[i]) {
                        NSString *str = [NSString stringWithFormat:@"%@",array[i]];
                        CGSize size = [str sizeWithAttributes:attributes];
                        NSLog(@"右侧内容宽度%f,%f",size.width,size.height);
//                        if([self.maxWidth[i] floatValue] < size.width){
//                            [self.maxWidth replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%f",size.width]];
                        [self.maxWidth addObject:[NSString stringWithFormat:@"%f",size.width]];
                    }else{
                        [self.maxWidth addObject:@""];
                    }
                        
                    }
                
                for(NSString *str in array){
                    [cellDatas addObject:[[CellData alloc] initWithCellType:TableColType_Label buttonStyle:0 title:str]];
                }
                [rtn addObject:cellDatas];
            }
            callback(self.maxWidth);
            
        }
            break;
        default:
            break;
    }
    return rtn;
}

//请求服务器
-(void)requestWithCurrPage:(int)currPage
                  dealDate:(NSString *)dealDate
                   orgCode:(NSString *)orgCode
                  orgLevel:(NSString *)orgLevel
                      type:(AnalysisType)type
                   success:(void (^)(NSDictionary *result))success
                      fail:(void (^)(NSString *errorMsg))fail
{
    switch (type) {
        default:
            break;
    }
}
-(NSArray *)dataForEndBtnFormList:(NSArray *)list type:(AnalysisType)type
{
    NSArray *rtn;
    switch (type) {
        default:
            break;
    }
    return rtn;
}

-(NSArray *)dataForLinkFormList:(NSArray *)list type:(AnalysisType)type currLevel:(NSString *)level
{
    NSArray *rtn;
    switch (type) {
        default:
            break;
    }
    return rtn;
}
@end
