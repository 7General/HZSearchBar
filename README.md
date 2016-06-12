# HZSearchBar
自定义searcher，完全模仿系统样式
# 选择遵循协议 
  1. CustomsearchResultsUpdater 

   及时筛选代理同系统的searchResultsUpdater代理一样的用法。

  2. CustomSearchBarDataSouce
   设置数据源
   ```objc
   // 设置显示列的内容
   -(NSInteger)searchBarNumberOfRowInSection;\
   // 设置显示没行的内容
   -(NSString *)CustomSearchBar:(CustomSearchBar *)searchBar titleForRowAtIndexPath:(NSIndexPath *)indexPath;
   ```
   设置每行显示的图片
   ```objc
   // 每行图片
   -(NSString *)CustomSearchBar:(CustomSearchBar *)searchBar imageNameForRowAtIndexPath:(NSIndexPath *)indexPath;
   ```
   
  3. CustomSearchBarDelegate
   设置点击效果和监听取消按钮动作
   ```objc
   // 点击每一行的效果
   - (void)CustomSearchBar:(CustomSearchBar *)searchBar didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

   -(void)CustomSearchBar:(CustomSearchBar *)searchBar cancleButton:(UIButton *)sender;
   ```
   
   
# 添加HZSearchBar（以添加到导航栏为例）
```objc
    self.customSearchBar = [CustomSearchBar show:CGPointMake(0, 0) andHeight:SEMHEIGHT];
    self.customSearchBar.searchResultsUpdater = self;
    self.customSearchBar.DataSource = self;
    self.customSearchBar.delegate = self;
    [self.navigationController.view insertSubview:self.customSearchBar aboveSubview:self.navigationController.navigationBar];
```
# 代理的使用
```objc
/**第一步根据输入的字符检索 必须实现*/
-(void)CustomSearch:(CustomSearchBar *)searchBar inputText:(NSString *)inputText {
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
-(NSString *)CustomSearchBar:(CustomSearchBar *)menu titleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.resultFileterArry[indexPath.row];
}
- (void)CustomSearchBar:(CustomSearchBar *)segment didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"---->>>>>>>>>%ld",indexPath.row);
}

-(void)CustomSearchBar:(CustomSearchBar *)segment cancleButton:(UIButton *)sender {

}
-(NSString *)CustomSearchBar:(CustomSearchBar *)searchBar imageNameForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Search_noraml";
}
```
##各位看官如有不明白的地方可以查看Demo或者添加洲洲哥的QQ号：1290925041 
# 还可以
关注洲洲哥的公众号，提高装逼技能就靠他了

![这里写图片描述](http://img.blog.csdn.net/20160426092941254)

 
