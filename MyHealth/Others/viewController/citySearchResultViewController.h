//
//  citySearchResultViewController.h
//  MyHealth
//
//  Created by imac on 15/11/9.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface citySearchResultViewController : UITableViewController
//接收从搜索框传过来的搜索条件
@property (nonatomic, copy) NSString *searchText;
@end
