//
//  ReportColData.m
//  ReportTest
//
//  Created by liuny on 15/2/11.
//  Copyright (c) 2015年 szjn. All rights reserved.
//

#import "ReportData.h"

@implementation ReportColData

-(instancetype)initWithType:(TableColType)colType title:(NSString *)title
{
    if(self = [super init]){
        self.type = colType;
        self.colName = title;
    }
    return self;
}
@end

@implementation CellData
-(instancetype)initWithCellType:(TableColType)type buttonStyle:(ButtonStyle)style title:(NSString *)text;
{
    if(self = [super init]){
        self.cellType = type;
        switch (type) {
            case TableColType_Label:
                self.title = text;
                break;
            case TableColType_Button:
                self.buttonStyle = style;
                self.title = text;
                break;
            default:
                break;
        }
    }
    return self;
}
@end