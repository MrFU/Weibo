//
//  rightReportCell.m
//  WebPro
//
//  Created by liuny on 15-1-13.
//  Copyright (c) 2015年 szjn. All rights reserved.
//

#import "rightReportCell.h"
#import "ReportData.h"

#define buttonWidth 60
#define buttonHeight    30

@implementation RightReportCell

- (void)awakeFromNib {
    // Initialization code
}

+ (NSString *)identifier
{
    static NSString *idetifierStr = @"RightReportCell";
    return idetifierStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithColWidth:(NSMutableArray *)colWidth data:(NSArray *)colTypes
{
    self = [[NSBundle mainBundle] loadNibNamed:@"RightReportCell" owner:nil options:nil][0];
    if(self){
        CGFloat addWidth = 0;
        for(int i=0;i<colTypes.count;i++){
            ReportColData *data = [colTypes objectAtIndex:i];
            
            switch (data.type) {
                case TableColType_Button:
                {
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
                    btn.center = CGPointMake(addWidth+[colWidth[i] floatValue]/2, 44.0/2.0);
                    [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
                    btn.tag = i+TagOffset;
                    [self.bgView addSubview:btn];
                    break;
                }
                case TableColType_Label:
                {
                    UILabel *textLab = [[UILabel alloc] init];
                    textLab.tag = i+TagOffset;
                    textLab.frame = CGRectMake(addWidth, 0, [colWidth[i] floatValue], 44);
                    [self defaultStyle:textLab];
                    [self.bgView addSubview:textLab];
                    break;
                }
                default:
                    break;
            }
            addWidth += [colWidth[i] floatValue];
        }
    }
    return self;
}

#if 0
-(id)initWithColWidth:(CGFloat)colWidth textNum:(NSInteger)num hasEndButton:(BOOL)hasBtn btnTitle:(NSString *)title
{
    self = [[NSBundle mainBundle] loadNibNamed:@"RightReportCell" owner:nil options:nil][0];
    if(self){
        NSInteger labelNum = hasBtn?(num-1):num;
        for(int i=0; i< labelNum; i++){
            UILabel *textLab = [[UILabel alloc] init];
            textLab.tag = i+TagOffset;
            textLab.frame = CGRectMake(i*colWidth, 0, colWidth, 44);
            [self defaultStyle:textLab];
            [self.bgView addSubview:textLab];
        }
        if(hasBtn){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
            btn.center = CGPointMake(labelNum*colWidth+colWidth/2, 44.0/2.0);
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
            [self.bgView addSubview:btn];
            self.endBtn = btn;
        }
    }
    return self;
}
#endif

-(void)defaultStyle:(UILabel *)label
{
    label.textColor = [UIColor darkGrayColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 1;
}
@end
