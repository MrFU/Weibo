//
//  RP_AnalysisTerminal.m
//  ChanelAssistant
//
//  Created by xck on 15/8/4.
//  Copyright (c) 2015年 szjn. All rights reserved.
//

#import "RP_AnalysisTerminal.h"
#import "ResultCol.h"
#import "ViewController.h"
#define documentsPath [NSString stringWithFormat:@"%@", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]]                                   //终端用
//#define documentsPath @"/Users/xck/Desktop"//mac测试用
@interface RP_AnalysisTerminal ()
{
    ReportView *reportView;//报表
    NSMutableArray *columnTitles;//标题
    NSArray *dataList;
    RP_AnalysisManager *vcManager;//用于显示的标题与数据
    
    CGFloat lastPosition;
    BOOL isAnimating;
    BOOL hidden;
    BOOL isClick;
}
@property (weak, nonatomic) IBOutlet UIView *bottomView;//底部view
@property (weak, nonatomic) IBOutlet UIView *reportBG;//报表
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;//显示页数
@property (weak, nonatomic) IBOutlet UIButton *leftButton;//上一页
@property (weak, nonatomic) IBOutlet UIButton *rightButton;//下一页
@property (strong, nonatomic) NSMutableArray *columnsMaxWidth;//右侧数据宽度组成的数组
@property (assign, nonatomic) CGFloat maxHeadWidth;//左侧数据最大宽度
@property (strong, nonatomic) NSMutableArray *columnsRightMaxWidth;//右侧标题宽度组成的数组
@property (assign, nonatomic) CGFloat maxLeftHeadWidth;//左侧标题最大宽度
@end
#define anim_time 0.3
@implementation RP_AnalysisTerminal
@synthesize analysisType;

- (void)viewDidLoad {
    [super viewDidLoad];
    isClick = NO;
    [self initUI];
   }
-(void)initUI{
    vcManager = [[RP_AnalysisManager alloc] init];
    //设置标题
    self.title = [vcManager vcTitleWithType:self.analysisType];
    NSLog(@"%@",self.title);

    [self initColumns];
     [self setRequestWithPage:1];
    [self initReportView];
    //右边变换按钮
    [self addRightChange];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"UserRecharge_back"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 30, 40);
    [btn addTarget:self action:@selector(backOption) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [self setRequestWithPage:1];
    [reportView refresh];
}
-(void)backOption{
    NSArray *viewControllers = self.navigationController.viewControllers;
    UIViewController *rootVc = nil;
    for (UIViewController *vc in viewControllers) {
        if ([vc isKindOfClass:[ViewController class]]) {
            rootVc = vc;
        } 
    }
    [self.navigationController popToViewController:rootVc animated:YES];
}
//添加右边条件查找按钮
-(void)addRightChange
{
    NSString *title = @"";
    switch (self.analysisType) {
        case RegionMark:
            title = @"发展";
            break;
        case DevelopMark:
            title = @"收入";
            break;
        default:
            break;
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    btn.frame = CGRectMake(0, 0, 40, 40);
    CGSize size = [title sizeWithFont:btn.titleLabel.font];
    btn.frame = CGRectMake(0, 0, size.width, 30);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(changeOption) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
//条件选择按钮事件（根据请求的analysisType判断进入的是哪个报表）
-(void)changeOption
{
    switch (self.analysisType) {
        case RegionMark:
            self.analysisType = DevelopMark;
            break;
        case DevelopMark:
            self.analysisType = RegionMark;
            break;
        default:
            break;
    }
    RP_AnalysisTerminal *analysisVC = [[RP_AnalysisTerminal alloc] init];
    analysisVC.analysisType = self.analysisType;
    analysisVC.isNewFromLink = YES;
    [self.navigationController pushViewController:analysisVC animated:YES];
//    [self initUI];
}
-(void)editAchievementRefresh
{
    int currPage = [self getCurrPage];
    [self setRequestWithPage:currPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if(reportView){
        CGSize size = self.reportBG.frame.size;
        CGRect frame = CGRectZero;
        frame.size = size;
        reportView.frame = frame;
    }
    
}
//初始化整个报表（计算表头宽度）
-(void)initReportView
{
        NSArray *titles = [vcManager columnTitlesWithType:self.analysisType];
        //计算左侧标题宽度
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName];
        
        NSString *str = [NSString stringWithFormat:@"%@",[titles firstObject]];
        CGSize size = [str sizeWithAttributes:attributes];
        self.maxLeftHeadWidth = size.width;
        //计算右侧标题宽度
    self.columnsRightMaxWidth  = [[NSMutableArray alloc]init];

    NSMutableArray * inarray = [[NSMutableArray alloc]init];
        ResultCol *col = [[ResultCol alloc] init];
        for(int i= 1;i<titles.count;i++){
           
            col = [columnTitles objectAtIndex:i];
            if (col.isSelected) {
                [inarray addObject:[titles objectAtIndex:i]];
                NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName];
                NSString *str2 = [NSString stringWithFormat:@"%@",titles[i]];
                CGSize size2 = [str2 sizeWithAttributes:attributes];
                [self.columnsRightMaxWidth addObject:[NSString stringWithFormat:@"%f",size2.width]];
            }
            
        }
        NSArray *array = [vcManager columnDataWithType:self.analysisType showArray:inarray];
        reportView = [[ReportView alloc] initWithLeftData:nil rightData:nil columnsTitle:array columnsMaxWidth:self.columnsMaxWidth maxHeadWidth:self.maxHeadWidth columnsRightMaxWidth:self.columnsRightMaxWidth maxLeftHeadWidth:self.maxLeftHeadWidth];
        reportView.delegate = self;
        NSLog(@"%@",array);
    [self.reportBG addSubview:reportView];
    reportView.frame = CGRectMake(0, 0, self.reportBG.frame.size.width, self.reportBG.frame.size.height);
}
//初始化表头
-(void)initColumns
{
    //反归档
    if (self.analysisType == DevelopMark) {
        NSString *archPath = [documentsPath stringByAppendingPathComponent:@"names.arch"];
        NSFileManager *manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath:archPath]) {
        NSData *data = [NSData dataWithContentsOfFile:archPath];
        NSKeyedUnarchiver *unArch = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        NSArray *names = [unArch decodeObjectForKey:@"names"];
        NSLog(@"%@",names);
        columnTitles = [NSMutableArray arrayWithArray:names];
        }
    }else if (self.analysisType == RegionMark){
        NSString *archPath = [documentsPath stringByAppendingPathComponent:@"names2.arch"];
        NSFileManager *manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath:archPath]) {
        NSData *data = [NSData dataWithContentsOfFile:archPath];
        NSKeyedUnarchiver *unArch = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        NSArray *names = [unArch decodeObjectForKey:@"names2"];
        NSLog(@"%@",names);
        columnTitles = [NSMutableArray arrayWithArray:names];
        }
    }
    
    
    NSLog(@"%@",columnTitles);
    if(columnTitles == nil){
        NSArray *array = [vcManager columnTitlesWithType:self.analysisType];
        columnTitles = [[self changeColumnsData:array] mutableCopy];
        NSLog(@"%@",array);
    }
}

-(NSArray *)changeColumnsData:(NSArray *)strArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for(NSString *str in strArray){
        ResultCol *col = [[ResultCol alloc] init];
        
        col.isSelected = YES;
        col.colName = str;
        [array addObject:col];
    }
    //归档
    if (self.analysisType == DevelopMark) {
        NSArray *names = [NSMutableArray arrayWithArray:array];
        NSMutableData *data = [NSMutableData data];
        NSKeyedArchiver *arch = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
        [arch encodeObject:names forKey:@"names"];
        [arch finishEncoding];
        NSString *archPath = [documentsPath stringByAppendingPathComponent:@"names.arch"];
        [data writeToFile:archPath atomically:YES];
        NSLog(@"%@",names);
    }else if(self.analysisType == RegionMark){
        NSArray *names = [NSMutableArray arrayWithArray:array];
        NSMutableData *data = [NSMutableData data];
        NSKeyedArchiver *arch = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
        [arch encodeObject:names forKey:@"names2"];
        [arch finishEncoding];
        NSString *archPath = [documentsPath stringByAppendingPathComponent:@"names2.arch"];
        [data writeToFile:archPath atomically:YES];
        NSLog(@"%@",names);
    }
    
    return array;
}

-(NSArray *)strArrayFromColData:(NSArray *)colArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for(ResultCol *col in colArray){
        if(col.isSelected == YES){
            [array addObject:col.colName];
        }
    }
    return array;
}

-(int)getCurrPage
{
    NSString *pageText = self.pageLabel.text;
    NSArray *array = [pageText componentsSeparatedByString:@"/"];
    return [array.firstObject intValue];
}

-(void)updateShowPage:(NSString *)curr total:(NSString *)total
{
    NSString *currText = curr.length == 0?@"1":curr;
    NSString *totalText = total.length == 0?@"1":total;
    if(totalText.intValue == 0){
        totalText = @"1";
    }
    NSString *text = [NSString stringWithFormat:@"%@/%@",currText,totalText];
    self.pageLabel.text = text;
    [self updatePageButton:total.intValue currPage:curr.intValue];
}

//更新翻页按钮的状态
-(void)updatePageButton:(int)maxPage currPage:(int)currPage
{
    if(maxPage < currPage || currPage < 1){
        self.leftButton.enabled = NO;
        self.rightButton.enabled = NO;
        return;
    }
    
    if(currPage > 1){
        self.leftButton.enabled = YES;
    }else{
        self.leftButton.enabled = NO;
    }
    
    if(currPage < maxPage){
        self.rightButton.enabled = YES;
    }else{
        self.rightButton.enabled = NO;
    }
}
//
-(NSArray *)checkRightColWithSelect:(NSArray *)rightAllData
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for(int i=0;i<rightAllData.count;i++){
        NSArray *oneObject = [rightAllData objectAtIndex:i];
        NSMutableArray *inArray = [[NSMutableArray alloc] init];
        for(int j=1; j<columnTitles.count;j++){
            ResultCol *col = [columnTitles objectAtIndex:j];
            if(col.isSelected == YES && oneObject.count > (j-1)){
                [inArray addObject:[oneObject objectAtIndex:(j-1)]];
            }
        }
        [array addObject:inArray];
    }
    return array;
}
//数据报表中显示（计算数据的最大宽度）
-(void)refreshToShow:(NSArray *)list
{
    NSArray *leftData = [vcManager allFirstColumnDataFromList:list type:self.analysisType callBack:^(CGFloat maxHeadWidth) {
        self.maxHeadWidth = maxHeadWidth;
    }];
    NSLog(@"%@",leftData);
        self.columnsMaxWidth = [[NSMutableArray alloc]init];
    NSArray *rightAllData = [vcManager allColumnDataExceptFirstFromList:list type:self.analysisType callBack:^(NSMutableArray *maxWidth) {
        ResultCol *col = [[ResultCol alloc] init];
        for (int i = 0; i < maxWidth.count; i++) {
            col = [columnTitles objectAtIndex:i+1];
            if (col.isSelected) {
                [self.columnsMaxWidth addObject:[maxWidth objectAtIndex:i]];
            }
        }
        //self.columnsMaxWidth = maxWidth;
    }];
    NSLog(@"%@",rightAllData);
    
    NSArray *rightData = [self checkRightColWithSelect:rightAllData];
    NSLog(@"%@",rightData);
    NSArray *titles = [self strArrayFromColData:columnTitles];
    reportView.columns = [vcManager columnDataWithType:self.analysisType showArray:titles];
    reportView.leftData = leftData;
    reportView.rightData = rightData;
    [reportView refresh];
}
//请求数据成功，对数据处理
-(void)requestSucess:(NSDictionary *)result
{
    NSString *totalPages = [self getDicValue:result key:@"totalPages"];;
    NSString *pageNo = [self getDicValue:result key:@"pageNo"];
    [self updateShowPage:pageNo total:totalPages];
    NSArray *array = result[@"result"];
    NSLog(@"%@",array);
    NSString *totalCount = [self getDicValue:result key:@"totalCount"];;
    if((totalCount.intValue == 0)&& isClick){
        isClick = !isClick;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"暂无数据！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    NSArray *list = [vcManager dataListWithJSONArray:array type:self.analysisType];
    dataList = [NSArray arrayWithArray:list];
    [self refreshToShow:dataList];
}
//请求数据失败
-(void)requestFail:(NSString *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[error hasPrefix:@"0"] ? @"网络异常！" : error delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}
//请求数据结果是否为空设置
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

//请求数据（这里写请求代码）
-(void)setRequestWithPage:(int)page
{
    NSDictionary *result;
    if (self.analysisType == DevelopMark) {
        NSDictionary *dic1 = @{@"region":@"广州港",@"ydDevelop":@"51097223",@"ydhbDevelop":@"13.00%",@"hfDevelop":@"145317",@"hfhbDevelop":@"7.86%",@"yfDevelop":@"365655",@"yfhbDevelop":@"15.19%",@"kdDevelop":@"13893",@"kdhbDevelop":@"-39.49%",@"sxDevelop":@"247",@"sxhbDevelop":@"35.22%",@"zhwj":@"31544",@"zhwjhb":@"67.89%"};
        NSArray *dic = @[dic1];
        result = @{@"autoCount":@(true),@"first":@(1),@"hasNext":@(false),@"hasPre":@(false),@"message":@"操作成功",@"nextPage":@(1),@"pageNo":@(1),@"pageSize":@(6),@"prePage":@(1),@"result": dic,@"state":@"1",@"totalCount":@(1),@"totalPages":@(1)};
    }
   
    [self requestSucess:result];
}


#pragma mark - button action
//上一页
- (IBAction)abovePageAction:(id)sender {
    int currPage = [self getCurrPage];
    [self setRequestWithPage:(currPage-1)];
}

//下一页
- (IBAction)nextPageAction:(id)sender {
    int currPage = [self getCurrPage];
    [self setRequestWithPage:(currPage+1)];
}
//点击筛选表头
- (IBAction)editColAction:(id)sender {
    EditColVC *edit = [[EditColVC alloc] init];
    edit.delegate = self;
    ResultCol *firstCol = [columnTitles firstObject];
    edit.firstCol = firstCol.colName;
    NSMutableArray *array = [NSMutableArray arrayWithArray:columnTitles];
    [array removeObjectAtIndex:0];
    edit.dataArr = [NSMutableArray arrayWithArray:array];
    [self.navigationController pushViewController:edit animated:YES];
}

//筛选表头完成
#pragma mark - EditColVCDelegate
-(void)selectFinish:(NSMutableArray *)selectArr
{
    //归档
    if (self.analysisType == DevelopMark) {
        NSString *archPath = [documentsPath stringByAppendingPathComponent:@"names.arch"];
        NSFileManager *manager = [NSFileManager defaultManager];
        NSError *error;
        if ([manager fileExistsAtPath:archPath]) {
            [manager removeItemAtPath:archPath error:&error];
        }
        [selectArr insertObject:[columnTitles firstObject] atIndex:0];
        NSArray *names = [NSMutableArray arrayWithArray:selectArr];
        NSMutableData *data = [NSMutableData data];
        NSKeyedArchiver *arch = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
        [arch encodeObject:names forKey:@"names"];
        [arch finishEncoding];
        
        [data writeToFile:archPath atomically:YES];
        NSLog(@"%@",names);
        columnTitles = [names mutableCopy];
    }else if(self.analysisType == RegionMark){
        NSString *archPath = [documentsPath stringByAppendingPathComponent:@"names2.arch"];
        NSFileManager *manager = [NSFileManager defaultManager];
        NSError *error;
        if ([manager fileExistsAtPath:archPath]) {
            [manager removeItemAtPath:archPath error:&error];
        }
        [selectArr insertObject:[columnTitles firstObject] atIndex:0];
        NSArray *names = [NSMutableArray arrayWithArray:selectArr];
        NSMutableData *data = [NSMutableData data];
        NSKeyedArchiver *arch = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
        [arch encodeObject:names forKey:@"names2"];
        [arch finishEncoding];
        
        [data writeToFile:archPath atomically:YES];
        NSLog(@"%@",names);
        columnTitles = [names mutableCopy];
    }
    if(reportView){
        [reportView removeFromSuperview];
        reportView = nil;
    }
     [self refreshToShow:dataList];
    [self initReportView];
    [self refreshToShow:dataList];
}

#pragma mark - ReportViewDelegate（这个是当报表有下钻时，调用，没有就不需要写）
-(void)didClickLinkWithSelectIndex:(NSInteger)index
{
    //下钻操作
   
}

-(void) showView{
    hidden = NO;
    isAnimating = YES;
    [UIView animateWithDuration:anim_time animations:^(void){
        CGRect frame = self.bottomView.frame;
        frame.origin.y -= frame.size.height;
        self.bottomView.frame = frame;
    } completion:^(BOOL finished) {
        isAnimating = NO;
    }];
}

-(void) hideView{
    hidden = YES;
    isAnimating = YES;
    [UIView animateWithDuration:anim_time animations:^(void){
        CGRect frame = self.bottomView.frame;
        frame.origin.y += frame.size.height;
        self.bottomView.frame = frame;
    } completion:^(BOOL finished){
        isAnimating = NO;
    }];
}
//此处是判断界面滚动时底部的view是否隐藏
-(void)didScroll:(UIScrollView *)scrollView
{
    //table height
    CGFloat tableHeight = scrollView.frame.size.height;
    //滚动高度
    CGFloat scrollH = scrollView.contentSize.height-tableHeight;
    
    CGFloat currentPostion = scrollView.contentOffset.y;
    
    if(scrollH <= 0){ //数据条数没有超过一屏
        return;
    }
    //向上滚动或者滚动到了底部
    if (currentPostion - lastPosition > 10 || currentPostion >= scrollH) {
        lastPosition = currentPostion;
        if (isAnimating) {
            return;
        }
        if (hidden == NO) {
            [self hideView];
        }
    } else if (lastPosition - currentPostion > 10 || currentPostion <= 0) {
        lastPosition = currentPostion;
        if (isAnimating) {
            return;
        }
        if(hidden == YES){
            [self showView];
        }
    }
}

//报表中button事件delegate
-(void)didClickButtonAtRow:(NSInteger)row col:(NSInteger)col title:(NSString *)title
{
}
//alert代理
#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){

           }
}

@end
