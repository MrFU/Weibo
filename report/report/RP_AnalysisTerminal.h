//
//  RP_AnalysisTerminal.h
//  ChanelAssistant
//
//  Created by xck on 15/8/4.
//  Copyright (c) 2015年 szjn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditColVC.h"//筛选ViewController
#import "ReportView.h"//报表
#import "RP_AnalysisManager.h"//处理相关数据

@interface RP_AnalysisTerminal : UIViewController<EditColVCDelegate,ReportViewDelegate,UIAlertViewDelegate>
@property (nonatomic, readwrite) AnalysisType analysisType;//type类型
@property (nonatomic, readwrite) BOOL isNewFromLink;//此处主要用于是否有下钻，没有可以不要

@end
