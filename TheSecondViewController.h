//
//  TheSecondViewController.h
//  SwipeToTransferDemo
//
//  Created by lijiangang on 13-4-17.
//  Copyright (c) 2013年 lijiangang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "touchTableView.h"
@interface TheSecondViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,TouchTableViewDelegate>
@property (strong , nonatomic) touchTableView *myTable;
@property (nonatomic,retain) NSMutableArray *screenShotsList;

@end
