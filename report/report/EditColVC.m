//
//  AnalyzeScreenViewController.m
//  iSalesOANew
//
//  Created by 赵 莲锋 on 13-10-9.
//  Copyright (c) 2013年 赵 莲锋. All rights reserved.
//

#import "EditColVC.h"
#import "AnalyzeScreenCell.h"
#import "ResultCol.h"

@interface EditColVC ()
@property (weak, nonatomic) IBOutlet UILabel *importantCol;

@end

@implementation EditColVC

#define Title   @"列"

@synthesize delegate=_delegate;
@synthesize dataArr;
@synthesize firstCol;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = Title;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 40);
    [btn setImage:[UIImage imageNamed:@"Result_ColEditOk"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(editOk) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.importantCol.text = self.firstCol;
}

-(void)editOk
{
    [_delegate selectFinish:dataArr];
    [self.navigationController popViewControllerAnimated:YES];
}

//全部勾选
- (IBAction)selectAllAction:(id)sender
{
    for (int i=0; i<[self.dataArr count]; i++) {
        ResultCol *model = [self.dataArr objectAtIndex:i];
        if (!model.isSelected) {
            model.isSelected = YES;
        }
        [self.dataArr replaceObjectAtIndex:i withObject:model];
    }
    [self.screenTable reloadData];
}

//全部取消
- (IBAction)cancelAllAction:(id)sender
{
    for (int i=0; i<[self.dataArr count]; i++) {
        ResultCol *model = [self.dataArr objectAtIndex:i];
        if (model.isSelected) {
            model.isSelected = NO;
        }
        [self.dataArr replaceObjectAtIndex:i withObject:model];
    }
    [self.screenTable reloadData];
}

//重置
- (IBAction)resetAllAction:(id)sender
{
    for (int i=0; i<[self.dataArr count]; i++) {
        ResultCol *model = [self.dataArr objectAtIndex:i];
        if (!model.isSelected) {
            model.isSelected = YES;
        }
        [self.dataArr replaceObjectAtIndex:i withObject:model];
    }
    [self.screenTable reloadData];
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AnalyzeScreenCell";
    AnalyzeScreenCell *cell = (AnalyzeScreenCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AnalyzeScreenCell" owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[AnalyzeScreenCell class]])
                cell = (AnalyzeScreenCell *)oneObject;
    }
    ResultCol *model = [self.dataArr objectAtIndex:indexPath.row];
    if (model.isSelected) {
        cell.titleImg.image = [UIImage imageNamed:@"Result_ColSelect"];
    }else {
        cell.titleImg.image = [UIImage imageNamed:@"Result_ColUnselect"];
    }
    cell.titleLab.text = model.colName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ResultCol *model = [self.dataArr objectAtIndex:indexPath.row];
    if (model.isSelected) {
        model.isSelected = NO;
    }else {
        model.isSelected = YES;
    }
    [self.dataArr replaceObjectAtIndex:indexPath.row withObject:model];
    [self.screenTable reloadData];
}

@end
