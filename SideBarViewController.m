//
//  SideBarViewController.m
//  SwipeToTransferDemo
//
//  Created by lijiangang on 13-4-18.
//  Copyright (c) 2013年 lijiangang. All rights reserved.
//

#import "SideBarViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface SideBarViewController ()<SiderBarDelegate>
@property (strong,nonatomic)LeftViewController *leftSideBarViewController;
@property (strong,nonatomic)RightViewController *rightSideBarViewController;

@end

@implementation SideBarViewController
{
    UIViewController  *currentMainController;
    UITapGestureRecognizer *tapGestureRecognizer;
    UIPanGestureRecognizer *panGestureReconginzer;
    BOOL sideBarShowing;
    CGFloat currentTranslate;
}
static  SideBarViewController *rootViewCon;
const int ContentOffset=230;
const int ContentMinOffset=60;
const float MoveAnimationDuration = 0.2;

+ (id)share
{
    return rootViewCon;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (rootViewCon) {
        rootViewCon = nil;
    }
    sideBarShowing = NO;
    currentTranslate = 0;
    _contentView.layer.shadowOffset = CGSizeMake(0, 0);
    _contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    _contentView.layer.shadowOpacity = 1;
    LeftViewController *left=[[LeftViewController alloc]init];
    left.delegate = self;
    _leftSideBarViewController = left;
    RightViewController *right = [[RightViewController alloc]init];
    _rightSideBarViewController =right;
  //  [self addChildViewController:_leftSideBarViewController];
    [self addChildViewController:_rightSideBarViewController];
    [_navBackView addSubview:_leftSideBarViewController.view];
    [_navBackView addSubview:_rightSideBarViewController.view];
    panGestureReconginzer  = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panInContentView:)];
    [self.contentView addGestureRecognizer:panGestureReconginzer];
}
- (void)showSideBarControllerWithDirection:(SideBarShowDirection)direction
{
    
    if (direction!=SideBarShowDirectionNone) {
        UIView *view ;
        if (direction == SideBarShowDirectionLeft)
        {
            view = self.leftSideBarViewController.view;
        }else
        {
            view = self.rightSideBarViewController.view;
        }
        [self.navBackView bringSubviewToFront:view];
    }
    [self moveAnimationWithDirection:direction duration:MoveAnimationDuration];
}


- (void)leftSideBarSelectWithController:(UIViewController *)controller
{
    if ([controller isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)controller setDelegate:self];
    }
    if (currentMainController == nil) {
		controller.view.frame = self.contentView.bounds;
		currentMainController = controller;
		[self addChildViewController:currentMainController];
		[self.contentView addSubview:currentMainController.view];
		[currentMainController didMoveToParentViewController:self];
	} else if (currentMainController != controller && controller !=nil) {
		controller.view.frame = self.contentView.bounds;
		[currentMainController willMoveToParentViewController:nil];
		[self addChildViewController:controller];
		self.view.userInteractionEnabled = NO;
		[self transitionFromViewController:currentMainController
						  toViewController:controller
								  duration:0
								   options:UIViewAnimationOptionTransitionNone
								animations:^{}
								completion:^(BOOL finished){
									self.view.userInteractionEnabled = YES;
									[currentMainController removeFromParentViewController];
									[controller didMoveToParentViewController:self];
									currentMainController = controller;
								}
         ];
	}
    
    [self showSideBarControllerWithDirection:SideBarShowDirectionNone];
}
- (void)rightSideBarSelectWithController:(UIViewController *)controller
{
    
}
- (void)panInContentView:(UIPanGestureRecognizer *)abc
{
    
	if (abc.state == UIGestureRecognizerStateChanged)
    {
        CGFloat translation = [abc translationInView:self.contentView].x;
        self.contentView.transform = CGAffineTransformMakeTranslation(translation+currentTranslate, 0);
        UIView *view ;
        if (translation+currentTranslate>0)
        {
            view = self.leftSideBarViewController.view;
        }else
        {
            view = self.rightSideBarViewController.view;
        }
        [self.navBackView bringSubviewToFront:view];
        
	} else if (panGestureReconginzer.state == UIGestureRecognizerStateEnded)
    {
		currentTranslate = self.contentView.transform.tx;
        if (!sideBarShowing) {
            if (fabs(currentTranslate)<ContentMinOffset) {
                [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
            }else if(currentTranslate>ContentMinOffset)
            {
                [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
            }else
            {
                [self moveAnimationWithDirection:SideBarShowDirectionRight duration:MoveAnimationDuration];
            }
        }else
        {
            if (fabs(currentTranslate)<ContentOffset-ContentMinOffset) {
                [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
                
            }else if(currentTranslate>ContentOffset-ContentMinOffset)
            {
                
                [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
                
            }else
            {
                [self moveAnimationWithDirection:SideBarShowDirectionRight duration:MoveAnimationDuration];
            }
        }
        
        
	}
    
    
}
- (void)moveAnimationWithDirection:(SideBarShowDirection)direction duration:(float)duration
{
    void (^animations)(void) = ^{
		switch (direction) {
            case SideBarShowDirectionNone:
            {
                self.contentView.transform  = CGAffineTransformMakeTranslation(0, 0);
            }
                break;
            case SideBarShowDirectionLeft:
            {
                self.contentView.transform  = CGAffineTransformMakeTranslation(ContentOffset, 0);
            }
                break;
            case SideBarShowDirectionRight:
            {
                self.contentView.transform  = CGAffineTransformMakeTranslation(-ContentOffset, 0);
            }
                break;
            default:
                break;
        }
	};
    void (^complete)(BOOL) = ^(BOOL finished) {
        self.contentView.userInteractionEnabled = YES;
        self.navBackView.userInteractionEnabled = YES;
        
        if (direction == SideBarShowDirectionNone) {
            
            if (tapGestureRecognizer) {
                [self.contentView removeGestureRecognizer:tapGestureRecognizer];
                tapGestureRecognizer = nil;
            }
            sideBarShowing = NO;
            
            
        }else
        {
            [self contentViewAddTapGestures];
            sideBarShowing = YES;
        }
        currentTranslate = self.contentView.transform.tx;
	};
    self.contentView.userInteractionEnabled = NO;
    self.navBackView.userInteractionEnabled = NO;
    [UIView animateWithDuration:duration animations:animations completion:complete];
}
- (void)contentViewAddTapGestures
{
    if (tapGestureRecognizer) {
        [self.contentView   removeGestureRecognizer:tapGestureRecognizer];
        tapGestureRecognizer = nil;
    }
    
    tapGestureRecognizer = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(tapOnContentView:)];
    [self.contentView addGestureRecognizer:tapGestureRecognizer];
}
- (void)tapOnContentView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
