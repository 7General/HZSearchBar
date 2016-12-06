//
//  MainViewController.m
//  CustomSearchBar
//
//  Created by 王会洲 on 16/6/7.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "MainViewController.h"
#import "CustomSearchBar.h"


@interface MainViewController ()<CustomsearchResultsUpdater,CustomSearchBarDataSouce,CustomSearchBarDelegate>
@property (nonatomic, strong) CustomSearchBar * customSearchBar;

@property (nonatomic, strong) UITableView * testTableview;

@property (nonatomic, strong) NSMutableArray * myData;


@property (nonatomic, strong) NSMutableArray * resultFileterArry;
@end

@implementation MainViewController

-(NSMutableArray *)resultFileterArry {
    if (!_resultFileterArry) {
        _resultFileterArry = [NSMutableArray new];
    }
    return _resultFileterArry;
}


-(NSMutableArray *)myData {
    if (!_myData) {
        _myData = [NSMutableArray new];
        [_myData addObject:@"A"];
        [_myData addObject:@"B"];
        [_myData addObject:@"C"];
        [_myData addObject:@"E"];
        [_myData addObject:@"A"];
        [_myData addObject:@"AR"];
        [_myData addObject:@"G"];
        [_myData addObject:@"J"];
        [_myData addObject:@"O"];
        [_myData addObject:@"K"];
        [_myData addObject:@"Y"];
        [_myData addObject:@"AY"];
        [_testTableview reloadData];
    }
    return _myData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义搜索栏";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(SearchClick)];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor grayColor];
    
    
    self.testTableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.testTableview.dataSource = self;
    self.testTableview.delegate = self;
    [self.view addSubview:self.testTableview];
    
    
        

}
-(void)SearchClick {
    [self.resultFileterArry removeAllObjects];
    self.customSearchBar = [CustomSearchBar show:CGPointMake(0, 0) andHeight:SEMHEIGHT];
    self.customSearchBar.searchResultsUpdater = self;
    self.customSearchBar.DataSource = self;
    self.customSearchBar.delegate = self;
    [self.navigationController.view insertSubview:self.customSearchBar aboveSubview:self.navigationController.navigationBar];
}

/**第一步根据输入的字符检索 必须实现*/
-(void)customSearch:(CustomSearchBar *)searchBar inputText:(NSString *)inputText {
    [self.resultFileterArry removeAllObjects];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",inputText];
    NSArray * arry = [self.myData filteredArrayUsingPredicate:predicate];
    for (NSString * taxChat in arry) {
        [self.resultFileterArry addObject:taxChat];
    }
}
// 设置显示列的内容
-(NSInteger)searchBarNumberOfRowInSection {
    return self.resultFileterArry.count;
}
// 设置显示没行的内容
-(NSString *)customSearchBar:(CustomSearchBar *)menu titleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.resultFileterArry[indexPath.row];
}
- (void)customSearchBar:(CustomSearchBar *)segment didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"---->>>>>>>>>%ld",indexPath.row);
}

-(void)customSearchBar:(CustomSearchBar *)segment cancleButton:(UIButton *)sender {

}
-(NSString *)customSearchBar:(CustomSearchBar *)searchBar imageNameForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Search_noraml";
}

#pragma mark -TABLEVIEW DELEGATE
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myData.count;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.myData[indexPath.row];
    return cell;
}


@end
