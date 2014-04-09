//
//  LeftViewController.m
//  SwipeToTransferDemo
//
//  Created by lijiangang on 13-4-18.
//  Copyright (c) 2013年 lijiangang. All rights reserved.
//

#import "LeftViewController.h"
#import "ViewController.h"
@interface LeftViewController ()

@end

@implementation LeftViewController
{
    NSArray *datalist;
    
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
    datalist = @[@"1",@"2",@"3",@"4",@"5"];
    if ([_delegate respondsToSelector:@selector(leftSideBarSelectWithController:)]) {
        [_delegate leftSideBarSelectWithController:[self subConWithIndex:0]];
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [datalist count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.textLabel.text = [datalist objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (_delegate && [_delegate respondsToSelector:@selector(leftSideBarSelectWithController:)])
     {
         [_delegate leftSideBarSelectWithController:nil];
     }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(UIViewController *)subConWithIndex:(int)index
{
    ViewController *vc=[[ViewController alloc]initWithNibName:@"ViewController_iPhone" bundle:nil];
    return  vc;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
