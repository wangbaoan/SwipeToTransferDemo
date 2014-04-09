//
//  ViewController.m
//  SwipeToTransferDemo
//
//  Created by lijiangang on 13-4-17.
//  Copyright (c) 2013年 lijiangang. All rights reserved.
//

#import "ViewController.h"
#import "TheSecondViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableArray *screenShot;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    image.backgroundColor = [UIColor yellowColor];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(130, 7, 60, 30)];
    lab.text = @"first";
    lab.textColor = [UIColor redColor];
    lab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:image];
    [self.view addSubview:lab];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"firstView";
 //   self.view.userInteractionEnabled=YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    screenShot =[[NSMutableArray alloc]init];
    [screenShot addObject:[self capture]];
      
}
- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}


- (IBAction)PushToNext:(id)sender {
    TheSecondViewController *vc = [[TheSecondViewController alloc]init];
       vc.screenShotsList = screenShot;
    [self.navigationController pushViewController:vc animated:YES];
  
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
