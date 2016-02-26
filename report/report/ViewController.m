//
//  ViewController.m
//  report
//
//  Created by xck on 15/8/20.
//  Copyright (c) 2015年 szjn. All rights reserved.
//

#import "ViewController.h"
#import "RP_AnalysisTerminal.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    btn.frame = CGRectMake(60, 110, 100, 30);
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(changeOption) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    NSLog(@"发布的版本1");
    
}
-(void)changeOption{
    RP_AnalysisTerminal *vc = [[RP_AnalysisTerminal alloc]init];
    vc.analysisType = DevelopMark;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
