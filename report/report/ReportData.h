//
//  ReportColData.h
//  ReportTest
//
//  Created by liuny on 15/2/11.
//  Copyright (c) 2015年 szjn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TableColType_Label,
    TableColType_Button,
}TableColType;

typedef enum {
    ButtonStyle_Green,
    ButtonStyle_None,
}ButtonStyle;

@interface ReportColData : NSObject
@property (nonatomic, readwrite) TableColType type;  //列的类型
@property (nonatomic, strong) NSString *colName;  //列名

-(instancetype)initWithType:(TableColType)colType title:(NSString *)title;

@end

@interface CellData : NSObject
@property (nonatomic, readwrite) TableColType cellType;  //列的类型
@property (nonatomic, readwrite) ButtonStyle buttonStyle; //按钮表现样式
@property (nonatomic, strong) NSString *title;         //显示数据

-(instancetype)initWithCellType:(TableColType)type buttonStyle:(ButtonStyle)style title:(NSString *)title;

@end
