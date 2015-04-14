//
//  ViewController.m
//  StatusbarScroll
//
//  Created by as on 15/4/13.
//  Copyright (c) 2015年 as. All rights reserved.
//

#import "ViewController.h"
#import "StatusbarTip.h"

@interface ViewController ()
{
    StatusbarTip *tip;
    NSInteger i;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView * background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 60)];
    [background setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:background];
    


}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"aaa");
    if(tip == nil)
        tip = [[StatusbarTip alloc] init];
    i = 0;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onButtonAction:(id)sender {
    TipMessage *tt = [TipMessage Tip];
    tt.tipMessage = @"Test Meesage No1";
    tt.Delay  = 2;
    i++;
    [tip PushTip:tt];
    TipMessage *tt1 = [TipMessage Tip];
    tt1.tipMessage = @"Test Meesage No2";
    tt1.Delay  = 2;
    i++;
    [tip PushTip:tt1];
    TipMessage *tt2 = [TipMessage Tip];
    tt2.tipMessage = @"Test Meesage No3";
    tt2.Delay  = 2;
    i++;
    [tip PushTip:tt2];
    
}
@end
