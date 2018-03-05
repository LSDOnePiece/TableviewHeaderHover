//
//  ViewController.m
//  UITableView头部悬停问题
//
//  Created by 神州锐达 on 2018/3/5.
//  Copyright © 2018年 onePiece. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView *tableview;

@end

CGFloat sectionHeaderHeight = 100;
CGFloat sectionFooterHeight = 100;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    ///2.Header悬停,Footer不悬停,使用UITableViewStylePlain 首先要隐藏第一组的尾部视图
    self.tableview.contentInset =UIEdgeInsetsMake(0,0,-100,0);
 
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 30;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.text  = [NSString stringWithFormat:@"第%zd组第%zd条数据",indexPath.section,indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *headerView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    headerView.backgroundColor = [UIColor greenColor];
    headerView.text = [NSString stringWithFormat:@"我是第%zd组头",section];
    
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UILabel *headerView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    headerView.backgroundColor = [UIColor yellowColor];
    headerView.text = [NSString stringWithFormat:@"我是第%zd组尾",section];
    return headerView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
 
    return 100;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    

    
    ///1.Header不悬停,Footer悬停,使用UITableViewStylePlain
//    if (scrollView.contentOffset.y <= 100 && scrollView.contentOffset.y >= 0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    }else if (scrollView.contentOffset.y >= 100) {
//        scrollView.contentInset = UIEdgeInsetsMake(-100, 0, 0, 0);
//    }
    
    ///2.Header悬停,Footer不悬停,使用UITableViewStylePlain
//    CGRect rectInTableview = [self.tableview rectForHeaderInSection:0];
//    CGRect rect =  [self.tableview convertRect:rectInTableview toView:self.tableview.superview];
//    NSLog(@"offY == %f",scrollView.contentOffset.y);
//    NSLog(@"rect.origin.y == %f",rect.origin.y);
//    NSLog(@"height == %f",self.tableview .contentSize.height);
//
//    if (rect.origin.y > -self.tableview.contentSize.height + [UIScreen mainScreen].bounds.size.height) {
//        self.tableview.contentInset = UIEdgeInsetsMake(0, 0, -100, 0);
//    }else{
//
//        self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    }
    ///3.指定某个head悬停 使用UITableViewStylePlain
    CGRect SectionOneRectInTableview = [self.tableview rectForHeaderInSection:1];

    CGRect SectionTwoRectInTableview = [self.tableview rectForHeaderInSection:2];

    ///处理foot使用
    CGRect SectionZeroInTableview = [self.tableview rectForHeaderInSection:0];
    CGRect rect =  [self.tableview convertRect:SectionZeroInTableview toView:self.tableview.superview];


    if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, -sectionFooterHeight, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
///section=1的header悬停 其他section的header不悬停
        /*
         scrollView.contentOffset.y > SectionOneRectInTableview.origin.y &&  scrollView.contentOffset.y <SectionTwoRectInTableview.origin.y
         
         关于header的偏移量判断
         */
        if (scrollView.contentOffset.y > SectionOneRectInTableview.origin.y &&  scrollView.contentOffset.y <SectionTwoRectInTableview.origin.y) {
                ///悬停header
        
            /*
             rect.origin.y > -self.tableview.contentSize.height + [UIScreen mainScreen].bounds.size.height
             
             关于foot的偏移量判断
             */
            if (rect.origin.y > -self.tableview.contentSize.height + [UIScreen mainScreen].bounds.size.height) {
                ///隐藏foot
                self.tableview.contentInset = UIEdgeInsetsMake(0, 0, -sectionFooterHeight, 0);
            }else{
                //显示foot
                 self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            }
        
        }else{
                ///不悬停header
            
            if (rect.origin.y > -self.tableview.contentSize.height + [UIScreen mainScreen].bounds.size.height) {
                
                ///隐藏foot
                self.tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
            }else{
                //显示foot
                self.tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
            }
            
        }

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)tableview{
    
    if (_tableview == nil) {
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        if (@available(iOS 11.0, *)) {
            _tableview.estimatedRowHeight = 0;
            _tableview.estimatedSectionFooterHeight = 0;
            _tableview.estimatedSectionHeaderHeight = 0;
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableview;
}


@end
