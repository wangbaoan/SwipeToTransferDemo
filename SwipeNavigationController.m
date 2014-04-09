//
//  SwipeNavigationController.m
//  SwipeToTransferDemo
//
//  Created by lijiangang on 13-4-17.
//  Copyright (c) 2013年 lijiangang. All rights reserved.
//
#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]
#import "SwipeNavigationController.h"
#import <QuartzCore/QuartzCore.h>

@interface SwipeNavigationController ()

@property (nonatomic,retain) UIView *backgroundView;
@property (nonatomic,retain) NSMutableArray *screenShotsList;

@end

@implementation SwipeNavigationController
{
    CGPoint startTouchPoint;
    BOOL isBackMoving;
    BOOL isMoving;
    BOOL canDragBack;
    UIView *blackMask;
      UIImageView *lastScreenShotView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _screenShotsList = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 //   [self.screenShotsList addObject:[self capture]];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
 //   [self.screenShotsList removeLastObject];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBarHidden = YES;
	// Do any additional setup after loading the view.
    
}
/*
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
     if (self.viewControllers.count <= 1 ) return;
    isMoving = NO;
    isBackMoving = NO;
    startTouchPoint = [((UITouch *)[touches anyObject])locationInView:KEY_WINDOW];
    
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
   // [self.screenShotsList removeLastObject];
    
    return [super popViewControllerAnimated:animated];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
 
    [super pushViewController:viewController animated:YES];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
        if (self.viewControllers.count <=1 ) return;
    
      CGPoint moveTouch = [((UITouch *)[touches anyObject])locationInView:KEY_WINDOW];
    if (!isMoving)
    {
       if (moveTouch.x - startTouchPoint.x > 10)
       {
           isMoving = YES;
           if (!self.backgroundView)
           {
               CGRect frame = self.view.frame;
               
               self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
               [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
               blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
               blackMask.backgroundColor = [UIColor blackColor];
               [self.backgroundView addSubview:blackMask];
           }
           if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
           
           UIImage *lastScreenShot = [self.screenShotsList lastObject];
           lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
           [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];

       }
   
    

    }

    

    if (isMoving) {
        
        [self moveViewWithX:moveTouch.x - startTouchPoint.x];
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    
    CGPoint endTouch = [((UITouch *)[touches anyObject])locationInView:KEY_WINDOW];
    
    if (endTouch.x - startTouchPoint.x >50)
    {
        if ([self.viewControllers count] <= 1) return;

        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:320.0f];
        }completion:^(BOOL finished) {
            [self popViewControllerAnimated:NO];
            CGRect frame = self.view.frame;
            frame.origin.x = 0;
            self.view.frame = frame;
            isMoving = NO;
        }];
    }
       else
    {
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            isMoving =NO;
        }];
    }
    
}

-(void)moveViewWithX:(CGFloat)x
{
    x = x>320?320:x;
    x = x<0?0:x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    
    float scale = (x/6400)+0.95;
    float alpha = 0.4 - (x/800);
    
    lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    blackMask.alpha = alpha;
}
- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    NSLog(@"navi touch cancel");
    
    
    [super touchesCancelled:touches withEvent:event];
    
    if (self.viewControllers.count <= 1) return;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self moveViewWithX:0];
    } completion:^(BOOL finished) {
        isMoving = NO;
    }];
}
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
