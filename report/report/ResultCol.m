//
//  ResultCol.m
//  Recharge
//
//  Created by liuny on 14-12-8.
//  Copyright (c) 2014年 szjn. All rights reserved.
//

#import "ResultCol.h"

@implementation ResultCol

- (instancetype)init
{
    if (self = [super init]) {
        self.isSelected = YES; //默认为YES
    }
    return self;
}

-(instancetype)initWithSelectAndName:(NSString *)name
{
    if(self = [super init]){
        self.isSelected = YES;
        self.colName = name;
    }
    return self;
}

#pragma mark - NSCoding Delegate
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.colName forKey:@"colName"];
    [encoder encodeBool:self.isSelected forKey:@"isSelected"];

}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.colName = [decoder decodeObjectForKey:@"colName"];
        self.isSelected = [decoder decodeBoolForKey:@"isSelected"];
    }
    return self;
}

@end
