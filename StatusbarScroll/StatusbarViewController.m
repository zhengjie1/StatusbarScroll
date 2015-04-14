//
//  StatusbarViewController.m
//  StatusbarScroll
//
//  Created by as on 15/4/13.
//  Copyright (c) 2015年 as. All rights reserved.
//

#import "StatusbarViewController.h"

@interface StatusbarViewController ()
{
    UIView *statusView;
}
@end

@implementation StatusbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    statusView = [[UIView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - [[UIScreen mainScreen] bounds].size.width * 2/5, 0, [[UIScreen mainScreen] bounds].size.width * 3/5, 20)];
//    [statusView setBackgroundColor:[UIColor redColor]];
//    [self.view addSubview:statusView];
//    [statusViewController.view setBackgroundColor:[UIColor redColor]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewWillLayoutSubviews
{
    self.view.frame = CGRectMake(0, 0, 50, 50);
}

@end
