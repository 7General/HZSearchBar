//
//  CustomSearchBar.h
//  CustomSearchBar
//
//  Created by 王会洲 on 16/6/7.
//  Copyright © 2016年 王会洲. All rights reserved.
//
#define SEMWIDTH [UIScreen mainScreen].bounds.size.width

#define SEMHEIGHT [UIScreen mainScreen].bounds.size.height

#define SEMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


#import <UIKit/UIKit.h>
@class CustomSearchBar;

@protocol CustomsearchResultsUpdater <NSObject>

@required
/**第一步根据输入的字符检索 必须实现*/
-(void)customSearch:(CustomSearchBar *)searchBar inputText:(NSString *)inputText;
@end

@protocol CustomSearchBarDataSouce <NSObject>
@required
// 设置显示列的内容
-(NSInteger)searchBarNumberOfRowInSection;
// 设置显示没行的内容
-(NSString *)customSearchBar:(CustomSearchBar *)searchBar titleForRowAtIndexPath:(NSIndexPath *)indexPath;


@optional
// 每行图片
-(NSString *)customSearchBar:(CustomSearchBar *)searchBar imageNameForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol CustomSearchBarDelegate <NSObject>
@optional
// 点击每一行的效果
- (void)customSearchBar:(CustomSearchBar *)searchBar didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)customSearchBar:(CustomSearchBar *)searchBar cancleButton:(UIButton *)sender;

@end


@interface CustomSearchBar : UIView<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>


// 显示
+(instancetype)show:(CGPoint)orgin andHeight:(CGFloat)height;


@property (nonatomic, weak) id<CustomSearchBarDataSouce>  DataSource;
@property (nonatomic, weak) id<CustomSearchBarDelegate>  delegate;
@property (nonatomic, weak) id<CustomsearchResultsUpdater>  searchResultsUpdater;
@end
