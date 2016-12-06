//
//  CustomSearchBar.m
//  CustomSearchBar
//
//  Created by 王会洲 on 16/6/7.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "CustomSearchBar.h"

@interface CustomSearchBar()
/**搜索框*/
@property (nonatomic, strong) UITextField * searchBarText;

@property (nonatomic, weak) UITableView * searchBarTableView;

@end

@implementation CustomSearchBar

-(instancetype)initWithOrgin:(CGPoint)origin andHeight:(CGFloat)height {
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, SEMWIDTH, height)];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)TapClick {
    //    NSLog(@"---->>>>>>>>>>>>>>>>>>>>>>>");
    [self hidSearchBar:self];
}
-(void)initView {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    UIView * searchBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SEMWIDTH, 64)];
    searchBg.backgroundColor = SEMColor(247, 247, 247);
    [self addSubview:searchBg];
    
    self.searchBarText = [[UITextField alloc] initWithFrame:CGRectMake(7, 27, SEMWIDTH * 0.8 , 31)];
    self.searchBarText.borderStyle = UITextBorderStyleRoundedRect;
    self.searchBarText.delegate = self;
    [searchBg addSubview:self.searchBarText];
    self.searchBarText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.searchBarText becomeFirstResponder];
    [self.searchBarText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 20, 20);
    [leftBtn setImage:[UIImage imageNamed:@"Search_noraml"] forState:UIControlStateNormal];
    self.searchBarText.leftView = leftBtn;
    [self.searchBarText.leftView setFrame:CGRectMake(0, 0, 25, 20)];
    self.searchBarText.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton * cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat cancleBtnW = 40;
    CGFloat cancleBtnH = 18;
    CGFloat cancleBtnX = SEMWIDTH - 10 - cancleBtnW;
    CGFloat cancleBtnY = (44 * 0.5 - 9) + 20;
    cancleBtn.frame = CGRectMake(cancleBtnX, cancleBtnY, cancleBtnW, cancleBtnH);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:SEMColor(132, 134, 137) forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
    [searchBg addSubview:cancleBtn];
    
    UITableView * searchBarTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(searchBg.frame), SEMWIDTH, SEMHEIGHT - CGRectGetMaxY(searchBg.frame)) style:UITableViewStylePlain];
    searchBarTableView.delegate = self;
    searchBarTableView.dataSource = self;
    [self addSubview:searchBarTableView];
    searchBarTableView.tableFooterView = [[UIView alloc] init];
    searchBarTableView.backgroundColor = self.backgroundColor;
    self.searchBarTableView = searchBarTableView;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapClick)];
    singleTap.cancelsTouchesInView = NO;
    [searchBarTableView addGestureRecognizer:singleTap];
    
    
}

-(void)cancleClick:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customSearchBar:cancleButton:)]) {
        [self.delegate customSearchBar:self cancleButton:sender];
    }
    [self hidSearchBar:self];
}
-(void)hidSearchBar:(CustomSearchBar *)searchBar {
    [self.searchBarText resignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    }];
}

+(instancetype)show:(CGPoint)orgin andHeight:(CGFloat)height {
    return [[self alloc] initWithOrgin:orgin andHeight:height];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (self.searchResultsUpdater && [self.searchResultsUpdater respondsToSelector:@selector(customSearch:inputText:)]) {
        [self.searchResultsUpdater customSearch:self inputText:textField.text];
        [self.searchBarTableView reloadData];
    }
}


#pragma mark -TABLEVIEW DELEGATE
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.DataSource && [self.DataSource respondsToSelector:@selector(searchBarNumberOfRowInSection)]) {
        return [self.DataSource searchBarNumberOfRowInSection];
    }else {
        return 0;
    }
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSIndexPath * path = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    // 文字
    if (self.DataSource && [self.DataSource respondsToSelector:@selector(customSearchBar:titleForRowAtIndexPath:)]) {
        cell.textLabel.text = [self.DataSource customSearchBar:self titleForRowAtIndexPath:path];
    }
    
    if (self.DataSource && [self.DataSource respondsToSelector:@selector(customSearchBar:imageNameForRowAtIndexPath:)]) {
        NSString *imageName = [self.DataSource customSearchBar:self imageNameForRowAtIndexPath:path];
        cell.imageView.image = [UIImage imageNamed:imageName];
    }
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.textColor = SEMColor(50, 50, 50);
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath * path = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    if (self.delegate && [self.delegate respondsToSelector:@selector(customSearchBar:didSelectRowAtIndexPath:)]) {
        [self.delegate customSearchBar:self didSelectRowAtIndexPath:path];
        [self hidSearchBar:self];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

@end
