//
//  StatusbarTip.m
//  StatusbarScroll
//
//  Created by as on 15/4/13.
//  Copyright (c) 2015年 as. All rights reserved.
//
#import "AppDelegate.h"

#import "StatusbarTip.h"
#import "StatusBarView.h"
#import "StatusbarViewController.h"


@interface StatusbarTip()
{
    UIWindow *statusWindow;
    UIWindow *mainWindow;
    
    NSMutableArray * queuedTips;
    StatusBarView *statusView;
    StatusbarViewController * statusViewController;
    BOOL isRun;
}
@end

@implementation StatusbarTip

- (id)init
{
    if (self = [super init])
    {
        isRun = NO;
        mainWindow = [[UIApplication sharedApplication] keyWindow];
        id rootView = [mainWindow rootViewController];

        statusView = [[StatusBarView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - [[UIScreen mainScreen] bounds].size.width * 2/5, 0, [[UIScreen mainScreen] bounds].size.width * 2/5, 20)];
        [statusView ChangeBackground];

        statusWindow = [[UIWindow alloc] initWithFrame:[[UIApplication sharedApplication] statusBarFrame]];
        statusWindow.windowLevel = UIWindowLevelStatusBar;
//        statusWindow.rootViewController = statusViewController;
        [statusWindow addSubview:statusView];
        [statusWindow makeKeyAndVisible];
        statusWindow.hidden = NO;
        
        [statusView setBackgroundColor:[UIColor redColor]];
        
        [mainWindow makeKeyAndVisible];
        [mainWindow setRootViewController:rootView];
        
        queuedTips = [[NSMutableArray alloc] init];

    }
    return self;
}

-(void)PushTip:(TipMessage *) tip
{
    [queuedTips insertObject:tip atIndex:0];
    
    if(isRun)
        return;
    
    [self RunQueued];
}

-(void)RunQueued
{
    TipMessage *tip = [queuedTips lastObject];
    if(tip == nil)
    {
        if(isRun)
        {
            [statusView endTip];
        }
        isRun = NO;
        return;
    }
    isRun = YES;

    [queuedTips removeLastObject];
    [statusView setTip:tip.tipMessage];
    [self performSelector:@selector(RunQueued) withObject:nil afterDelay:[tip Delay] + 1];

}

@end
