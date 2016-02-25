//
//  DevelopListModel.m
//  JNsjjf
//
//  Created by xck on 15/8/18.
//  Copyright (c) 2015年 szjn. All rights reserved.
//

#import "DevelopListModel.h"
@implementation DevelopListModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _region = [self getDicValue:dict key:@"region"];
        _ydDevelop = [self getDicValue:dict key:@"ydDevelop"];
        _ydhbDevelop = [self getDicValue:dict key:@"ydhbDevelop"];
        _hfDevelop = [self getDicValue:dict key:@"hfDevelop"];
        _hfhbDevelop = [self getDicValue:dict key:@"hfhbDevelop"];
        _yfDevelop = [self getDicValue:dict key:@"yfDevelop"];
        _yfhbDevelop = [self getDicValue:dict key:@"yfhbDevelop"];
        _kdDevelop = [self getDicValue:dict key:@"kdDevelop"];
        _kdhbDevelop = [self getDicValue:dict key:@"kdhbDevelop"];
        _sxDevelop = [self getDicValue:dict key:@"sxDevelop"];
        _sxhbDevelop = [self getDicValue:dict key:@"sxhbDevelop"];
        _zhwj = [self getDicValue:dict key:@"zhwj"];
        _zhwjhb = [self getDicValue:dict key:@"zhwjhb"];
        
    }
    return self;
}
-(NSString *)getDicValue:(NSDictionary *)dic key:(NSString *)key
{
    NSString *value = dic[key];
    if(value == nil || [value isEqual:[NSNull null]]){
        value = @"";
    }else{
        value = [NSString stringWithFormat:@"%@",value];
    }
    return value;
}

#pragma mark - NSCoding Delegate
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.region forKey:@"region"];
    [encoder encodeObject:self.ydDevelop forKey:@"ydDevelop"];
    [encoder encodeObject:self.ydhbDevelop forKey:@"ydhbDevelop"];
    [encoder encodeObject:self.hfDevelop forKey:@"hfDevelop"];
    [encoder encodeObject:self.hfhbDevelop forKey:@"hfhbDevelop"];
    [encoder encodeObject:self.yfDevelop forKey:@"yfDevelop"];
    [encoder encodeObject:self.yfhbDevelop forKey:@"yfhbDevelop"];
    [encoder encodeObject:self.kdDevelop forKey:@"kdDevelop"];
    [encoder encodeObject:self.kdhbDevelop forKey:@"kdhbDevelop"];
    [encoder encodeObject:self.sxDevelop forKey:@"sxDevelop"];
    [encoder encodeObject:self.sxhbDevelop forKey:@"sxhbDevelop"];
    [encoder encodeObject:self.zhwj forKey:@"zhwj"];
    [encoder encodeObject:self.zhwjhb forKey:@"zhwjhb"];
   
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.region = [decoder decodeObjectForKey:@"region"];
        self.ydDevelop = [decoder decodeObjectForKey:@"ydDevelop"];
        self.ydhbDevelop = [decoder decodeObjectForKey:@"ydhbDevelop"];
        self.hfDevelop = [decoder decodeObjectForKey:@"hfDevelop"];
        self.hfhbDevelop = [decoder decodeObjectForKey:@"hfhbDevelop"];
        self.yfDevelop= [decoder decodeObjectForKey:@"yfDevelop"];
        self.yfhbDevelop = [decoder decodeObjectForKey:@"yfhbDevelop"];
        self.kdDevelop = [decoder decodeObjectForKey:@"kdDevelop"];
        self.kdhbDevelop = [decoder decodeObjectForKey:@"kdhbDevelop"];
        self.sxDevelop = [decoder decodeObjectForKey:@"sxDevelop"];
        self.sxhbDevelop = [decoder decodeObjectForKey:@"sxhbDevelop"];
        self.zhwj = [decoder decodeObjectForKey:@"zhwj"];
        self.zhwjhb = [decoder decodeObjectForKey:@"zhwjhb"];
    }
    return self;
}

@end
