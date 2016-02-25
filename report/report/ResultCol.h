//
//  ResultCol.h
//  Recharge
//
//  Created by liuny on 14-12-8.
//  Copyright (c) 2014年 szjn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DevelopListModel.h"
@interface ResultCol : DevelopListModel
@property(nonatomic, strong) NSString *colName;     //筛选名称
@property(nonatomic, readwrite) BOOL isSelected;    //是否选中

-(instancetype)initWithSelectAndName:(NSString *)name;
@end
