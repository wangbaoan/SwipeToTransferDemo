//
//  SideBarViewController.h
//  SwipeToTransferDemo
//
//  Created by lijiangang on 13-4-18.
//  Copyright (c) 2013年 lijiangang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideBarViewController : UIViewController<UINavigationControllerDelegate>
@property (strong,nonatomic)IBOutlet UIView *contentView;
@property (strong,nonatomic)IBOutlet UIView *navBackView;
@end
