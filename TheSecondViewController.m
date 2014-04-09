//
//  TheSecondViewController.m
//  SwipeToTransferDemo
//
//  Created by lijiangang on 13-4-17.
//  Copyright (c) 2013年 lijiangang. All rights reserved.
//
#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]

#import "TheSecondViewController.h"
#import "touchTableView.h"
#import <QuartzCore/QuartzCore.h>

@interface TheSecondViewController ()
@property (nonatomic,retain) UIView *backgroundView;
@end

@implementation TheSecondViewController
{
    CGPoint startTouchPoint;
    BOOL isBackMoving;
    BOOL isMoving;
    BOOL canDragBack;
    UIView *blackMask;
    UIImageView *lastScreenShotView;
    NSString *tempString;
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
    self.navigationController.navigationBarHidden = YES;

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.screenShotsList removeLastObject];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"SecondView";
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    image.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:image];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(130, 7, 60, 30)];
    lab.text = @"second";
    lab.textColor = [UIColor redColor];
    lab.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:lab];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(7, 7, 40, 25)];

    [btn setTitle:@"back" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor redColor]];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view from its nib.
    _myTable = [[touchTableView alloc]initWithFrame:CGRectMake(0, 44, 320, 416)];
    _myTable.delegate = self;
    _myTable.touchDelegate = self;
    _myTable.dataSource = self;
    [self.view addSubview: _myTable];

}
-(void)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *cellID = @"indexItemCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] ;
    }
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
   [cell addGestureRecognizer:recognizer];
    cell.textLabel.text=[NSString stringWithFormat:@"%d",indexPath.row];
    return cell;

}
-(BOOL)canBecomeFirstResponder
{
    return YES;
}
- (void)longPress:(UILongPressGestureRecognizer *)recognizer {
     	    if (recognizer.state == UIGestureRecognizerStateBegan) {
         	        UITableViewCell *cell = (UITableViewCell *)recognizer.view;
                tempString= cell.textLabel.text;
         	        [cell becomeFirstResponder];
        
         	        UIMenuItem *flag = [[UIMenuItem alloc] initWithTitle:@"复制"action:@selector(Copy:)];
                
         	        UIMenuItem *approve = [[UIMenuItem alloc] initWithTitle:@"删除"action:@selector(Delete:)];
            
        	        UIMenuItem *deny = [[UIMenuItem alloc] initWithTitle:@"分享"action:@selector(share:)];
        
         	        UIMenuController *menu = [UIMenuController sharedMenuController];
         	        [menu setMenuItems:[NSArray arrayWithObjects:flag, approve, deny, nil]];
         	        [menu setTargetRect:cell.frame inView:cell.superview];
         	        [menu setMenuVisible:YES animated:YES];
        	    }
     	}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)Copy:(id)sender
{
    NSLog(@"you select %@",tempString);
}
-(void)Delete:(id)sender
{
    
}
-(void)share:(id)sender
{
    
}
- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    _myTable.scrollEnabled=NO;
    [super touchesBegan:touches withEvent:event];
    if(self.navigationController.viewControllers.count <= 1) return;

isMoving = NO;
isBackMoving = NO;
startTouchPoint = [((UITouch *)[touches anyObject])locationInView:KEY_WINDOW];
    
}

  //  

- (void)tableView:(UITableView *)tableView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _myTable.scrollEnabled = YES;
    [super touchesCancelled:touches withEvent:event];
    if (self.navigationController.viewControllers.count <= 1) return;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self moveViewWithX:0];
    } completion:^(BOOL finished) {
        isMoving = NO;
    }];

  //  [super touchesCancelled: touches withEvent:event];
}
- (void)tableView:(UITableView *)tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _myTable.scrollEnabled = YES;
     [super touchesEnded:touches withEvent:event];
    CGPoint endTouch = [((UITouch *)[touches anyObject])locationInView:KEY_WINDOW];
    
    if (endTouch.x - startTouchPoint.x >50)
    {
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:320.0f];
        }completion:^(BOOL finished) {
            [self.navigationController popViewControllerAnimated:NO];
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
- (void)tableView:(UITableView *)tableView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
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
        
              [UIView animateWithDuration:0.3 animations:^{
                   [self moveViewWithX:moveTouch.x - startTouchPoint.x];

        } completion:^(BOOL finished) {
            
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
