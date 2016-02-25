//
//  DevelopListModel.h
//  JNsjjf
//
//  Created by xck on 15/8/18.
//  Copyright (c) 2015年 szjn. All rights reserved.
//

#import <Foundation/Foundation.h>
//数据model  按顺序来的
@interface DevelopListModel : NSObject
@property (nonatomic,copy) NSString *region;
@property (nonatomic,copy) NSString *ydDevelop;
@property (nonatomic,copy) NSString *ydhbDevelop;
@property (nonatomic,copy) NSString *hfDevelop;
@property (nonatomic,copy) NSString *hfhbDevelop;
@property (nonatomic,copy) NSString *yfDevelop;
@property (nonatomic,copy) NSString *yfhbDevelop;
@property (nonatomic,copy) NSString *kdDevelop;
@property (nonatomic,copy) NSString *kdhbDevelop;
@property (nonatomic,copy) NSString *sxDevelop;
@property (nonatomic,copy) NSString *sxhbDevelop;
@property (nonatomic,copy) NSString *zhwj;
@property (nonatomic,copy) NSString *zhwjhb;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
