//
//  ReportView.m
//  WebPro
//
//  Created by liuny on 15-1-13.
//  Copyright (c) 2015年 szjn. All rights reserved.
//

#import "ReportView.h"
#import "LeftReportCell.h"
#import "RightReportCell.h"
@interface ReportView(){
    CGFloat totalLeftWidth;
    NSMutableArray *totalRightWidth;
    CGFloat totalWidth;
}
@end
#define defaulTextColor [UIColor darkGrayColor]
//渠道名下钻字体颜色
#define groupTextColor [UIColor colorWithRed:120.0/255.0 green:96.0/255.0 blue:150.0/255.0 alpha:1.0]

@implementation ReportView
@synthesize leftData,rightData,columns,delegate;
-(ReportView *)instanceReportView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ReportView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

-(ReportView *)initWithLeftData:(NSArray *)leftDataT rightData:(NSArray *)rightDataT columnsTitle:(NSArray *)columnsT columnsMaxWidth:(NSMutableArray *)columnsMaxWidth maxHeadWidth:(CGFloat)maxHeadWidth columnsRightMaxWidth:(NSMutableArray *)columnsRightMaxWidth maxLeftHeadWidth:(CGFloat)maxLeftHeadWidth
{
    NSLog(@"%@,%f,%@,%f",columnsMaxWidth,maxHeadWidth,columnsRightMaxWidth,maxLeftHeadWidth);
    self = [self instanceReportView];
    [self defaultInit];
    totalRightWidth = [[NSMutableArray alloc]init];
    totalLeftWidth = 0;
    totalWidth = 0;
    if (maxHeadWidth) {
        if (maxHeadWidth < maxLeftHeadWidth) {
            totalLeftWidth = maxLeftHeadWidth + 20;
        }else{
            totalLeftWidth = maxHeadWidth + 20;
        }
    }else{
        totalLeftWidth = maxLeftHeadWidth + 20;
    }
    if (columnsMaxWidth && columnsMaxWidth.count > 0) {
        for (int i = 0;  i < columnsRightMaxWidth.count; i++) {
            if ([columnsMaxWidth[i] floatValue] < [columnsRightMaxWidth[i] floatValue]) {
                [totalRightWidth addObject:[NSString stringWithFormat:@"%f",[columnsRightMaxWidth[i] floatValue]+20 ]];
            }else{
                [totalRightWidth addObject:[NSString stringWithFormat:@"%f",[columnsMaxWidth[i] floatValue]+20 ]];
            }
        }
    }else{
        for (int i = 0;  i < columnsRightMaxWidth.count; i++) {
        [totalRightWidth addObject:[NSString stringWithFormat:@"%f",[columnsRightMaxWidth[i] floatValue]+20 ]];
        }
    }
    
    for (int i = 0; i < totalRightWidth.count; i++) {
        totalWidth += [totalRightWidth[i] floatValue];
    }
    NSLog(@"%f,%@,%f",totalLeftWidth,totalRightWidth,totalWidth);
    self.leftData = leftDataT;
    self.rightData = rightDataT;
    self.columns = columnsT;
    [self refresh];
    return self;
}

-(ReportView *)initWithLeftData:(NSArray *)leftDataT rightData:(NSArray *)rightDataT columnsTitle:(NSArray *)columnsT hasEndBtn:(BOOL)hasBtn btnTitle:(NSString *)title btnShowData:(NSArray *)btnDataT
{
    self = [self instanceReportView];
    [self defaultInit];
    self.leftData = leftDataT;
    self.rightData = rightDataT;
    self.columns = columnsT;
    [self refresh];
    return self;
}

-(void)setColumns:(NSArray *)columnsT
{
    columns = columnsT;
    rightColCount = self.columns.count-1;
}

-(void)refresh
{
    [self refreshLeft];
    [self refreshRight];
}

-(void)refreshLeft
{
    [self.leftTable reloadData];
}

-(void)refreshRight
{
    CGSize size = CGSizeZero;
//    size.width = rightColCount * KRightColWidth;
    //计算右侧宽
    size.width = totalWidth;
    size.height = self.rightScroll.frame.size.height;
    self.rightScroll.contentSize = size;
    self.rightTable.frame = CGRectMake(0, 0, size.width, size.height);
    [self.rightTable reloadData];
}

-(void)defaultInit
{
    self.leftTable.dataSource = self;
    self.leftTable.delegate = self;
    self.leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftTable.showsHorizontalScrollIndicator = NO;
    self.leftTable.showsVerticalScrollIndicator = NO;
    
    self.rightTable.dataSource = self;
    self.rightTable.delegate = self;
    self.rightTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.rightScroll.bounces = NO;
    
    UINib *nib = [UINib nibWithNibName:@"LeftReportCell" bundle:nil];
    [self.leftTable registerNib:nib forCellReuseIdentifier:[LeftReportCell identifier]];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    CGRect viewFrame = self.frame;
    self.leftTable.frame = CGRectMake(0, 0, totalLeftWidth, viewFrame.size.height);
    self.rightScroll.frame = CGRectMake(totalLeftWidth, 0, viewFrame.size.width-totalLeftWidth, viewFrame.size.height);
    CGSize contentSize = self.rightScroll.contentSize;
    contentSize.height = viewFrame.size.height;
    self.rightScroll.contentSize = contentSize;
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 34.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    UIColor *bgColor = [UIColor colorWithRed:243.0/255.0 green:226.0/255.0 blue:206.0/255.0 alpha:1.0];
    view.backgroundColor = bgColor;
    CGFloat height = 34;
    if(self.leftTable == tableView){
        view.frame = CGRectMake(0, 0, totalLeftWidth, height);
        UILabel *label = [[UILabel alloc] initWithFrame:view.frame];
        ReportColData *data = [columns firstObject];
        label.text = data.colName;
        [self headerStyle:label];
        [view addSubview:label];
    }else if(self.rightTable == tableView){
        view.frame = CGRectMake(0, 0, totalWidth, height);
        CGFloat addWidth = 0;
        for(int i=1;i<columns.count;i++){
            UILabel *label = [[UILabel alloc] init];
            CGRect frame = CGRectMake(addWidth, 0, [totalRightWidth[i-1] floatValue], height);
            label.frame = frame;
            [self headerStyle:label];
            ReportColData *data = [columns objectAtIndex:i];
            label.text = data.colName;
            [view addSubview:label];
            addWidth += [totalRightWidth[i-1] floatValue];
        }
    }
    return view;
}

-(void)headerStyle:(UILabel *)label
{
    label.textColor = [UIColor colorWithRed:171.0/255.0 green:70.0/255.0 blue:50.0/255.0 alpha:1.0];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:13.0];
    label.numberOfLines = 1;
    label.textAlignment = NSTextAlignmentCenter;
}

-(void)linkStyle:(UILabel *)label clickBtn:(UIButton *)btn
{
    btn.enabled = YES;
    label.textColor = groupTextColor;
}

-(void)noLinkStyle:(UILabel *)lable clickBtn:(UIButton *)btn
{
    btn.enabled = NO;
    lable.textColor = defaulTextColor;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.leftTable){
        LeftReportCell *cell = [tableView dequeueReusableCellWithIdentifier:[LeftReportCell identifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = [self.leftData objectAtIndex:indexPath.row];
        if(self.linkData){
            cell.clickBtn.tag = indexPath.row;
            [cell.clickBtn addTarget:self action:@selector(linkBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            NSNumber *num = [self.linkData objectAtIndex:indexPath.row];
            BOOL flag = num.boolValue;
            if(flag){
                [self linkStyle:cell.titleLab clickBtn:cell.clickBtn];
            }else{
                [self noLinkStyle:cell.titleLab clickBtn:cell.clickBtn];
            }
        }
        return cell;
    }else{
        RightReportCell *cell = [tableView dequeueReusableCellWithIdentifier:[RightReportCell identifier]];
        if(cell == nil){
            NSMutableArray *data = [columns mutableCopy];
            [data removeObjectAtIndex:0];
            cell = [[RightReportCell alloc] initWithColWidth:totalRightWidth data:data];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NSArray *array = [self.rightData objectAtIndex:indexPath.row];
        cell.bgView.tag = indexPath.row;
        
        for(int i=0;i<array.count;i++){
            CellData *cellData = [array objectAtIndex:i];
            UIView *view = [cell.bgView viewWithTag:i+TagOffset];
            switch (cellData.cellType) {
                case TableColType_Label:
                    if([view isKindOfClass:[UILabel class]]){
                        UILabel *label = (UILabel *)view;
                        label.text = cellData.title;
                    }
                    break;
                case TableColType_Button:
                    if([view isKindOfClass:[UIButton class]]){
                        UIButton *btn = (UIButton *)view;
                        switch (cellData.buttonStyle) {
                            case ButtonStyle_Green:
                                [self buttonGreenStyle:btn title:cellData.title];
                                break;
                            case ButtonStyle_None:
                                [self buttonNoneStyle:btn title:cellData.title];
                                break;
                            default:
                                break;
                        }
                        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    break;
                default:
                    break;
            }
        }
        
        //设置背景颜色
        if (indexPath.row%2==0) {
            cell.bgView.backgroundColor = [UIColor whiteColor];
        }else {
            cell.bgView.backgroundColor = [UIColor colorWithRed:253.0f/255 green:243.0f/255 blue:231.0f/255 alpha:1.0];
        }
        return cell;
    }
}

-(void)buttonGreenStyle:(UIButton *)btn title:(NSString *)title
{
    btn.backgroundColor = [UIColor whiteColor];
    btn.layer.borderColor = [[UIColor greenColor] CGColor];
    btn.layer.borderWidth = 1.0;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    btn.enabled = YES;
}

-(void)buttonNoneStyle:(UIButton *)btn title:(NSString *)title
{
    btn.backgroundColor = [UIColor clearColor];
    btn.layer.borderWidth = 0.0;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    btn.enabled = NO;
}

-(void)buttonAction:(id)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didClickButtonAtRow:col:title:)]){
        UIButton *btn = (UIButton *)sender;
        NSInteger row = btn.superview.tag;
        NSInteger col = btn.tag - TagOffset;
        NSString *btnTitle = [btn titleForState:UIControlStateNormal];
        [self.delegate didClickButtonAtRow:row col:col title:btnTitle];
    }
}

-(void)linkBtnAction:(id)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didClickLinkWithSelectIndex:)]){
        UIButton *btn = (UIButton *)sender;
        [self.delegate didClickLinkWithSelectIndex:btn.tag];
    }
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.leftTable == scrollView){
        self.rightTable.contentOffset = self.leftTable.contentOffset;
    }else if(self.rightTable == scrollView){
        self.leftTable.contentOffset = self.rightTable.contentOffset;
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(didScroll:)])
    {
        [self.delegate didScroll:scrollView];
    }
}
@end
