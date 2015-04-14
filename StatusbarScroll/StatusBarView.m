//
//  StatusBarView.m
//  StatusbarScroll
//
//  Created by as on 15/4/13.
//  Copyright (c) 2015年 as. All rights reserved.
//

#import "StatusBarView.h"
@interface StatusBarView()
{
    UIImageView *backgroundView;
    
    UIView * BatteryView;
    
    UIImageView * Battery_Border;
    UIImageView * Battery_Level;
    UIImageView * Battery_Charging;
    
    UILabel * tipView;
    UILabel * showTipView;
}
@end

@implementation StatusBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)ChangeBackground
{
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(viewImage.CGImage, self.frame);
    UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);

    if(backgroundView == nil)
    {
        backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:backgroundView];
        
        UIDevice *device = [UIDevice currentDevice];
        device.batteryMonitoringEnabled = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(batteryLevelChanged:) name:@"UIDeviceBatteryLevelDidChangeNotification" object:device];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(batteryStateChanged:) name:@"UIDeviceBatteryStateDidChangeNotification" object:device];
        float batteryLevel = ABS([device batteryLevel]);
        
        BatteryView = [[UIView alloc] initWithFrame:self.bounds];
        
        Battery_Border = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 30, 5, 25, 10)];
        Battery_Border.image = [UIImage imageNamed:@"Icon_White_Battery_Border"];
        [BatteryView addSubview:Battery_Border];
        
        Battery_Level = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 28.5, 6.5, 19.8 * batteryLevel, 7.2)];
        if(batteryLevel<0.2)
        {
            Battery_Level.image = [UIImage imageNamed:@"Icon_Red_Battery_Level"];
        }else{
            Battery_Level.image = [UIImage imageNamed:@"Icon_White_Battery_Level"];
        }
        [BatteryView addSubview:Battery_Level];
        
        [self addSubview:BatteryView];
        
        Battery_Charging = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 11, 5, 6, 10)];
        Battery_Charging.image = [UIImage imageNamed:@"Icon_White_Battery_Charging"];
        
        if([[UIDevice currentDevice] batteryState] == 2)
        {
            [BatteryView addSubview:Battery_Charging];
            Battery_Border.center = CGPointMake(Battery_Border.center.x - 9, Battery_Border.center.y);
            Battery_Level.center = CGPointMake(Battery_Level.center.x - 9, Battery_Level.center.y);
        }
        
        tipView = [[UILabel alloc] initWithFrame:self.bounds];
        tipView.center = CGPointMake(tipView.center.x-5, -10);
        tipView.textAlignment = NSTextAlignmentRight;
        tipView.textColor = [UIColor whiteColor];
        tipView.font = [UIFont boldSystemFontOfSize:12];
        showTipView = [[UILabel alloc] initWithFrame:self.bounds];
        showTipView.center = CGPointMake(showTipView.center.x-5, showTipView.center.y);
        showTipView.textAlignment = NSTextAlignmentRight;
        showTipView.textColor = [UIColor whiteColor];
        showTipView.font = [UIFont boldSystemFontOfSize:12];
        showTipView.hidden = YES;
        [self addSubview:tipView];
        [self addSubview:showTipView];

    }
    backgroundView.image = thumbScale;
}

- (void)setTip:(NSString *) tip
{
    tipView.text = tip;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        tipView.transform = CGAffineTransformMakeTranslation(0, 20);
        
        BatteryView.transform = CGAffineTransformMakeTranslation(0, 10);
        BatteryView.alpha = 0;
        if(!showTipView.hidden)
        {
            showTipView.transform = CGAffineTransformMakeTranslation(0, 10);
            showTipView.alpha = 0;
        }
    } completion:^(BOOL finished) {
        tipView.transform = CGAffineTransformMakeTranslation(0,0);
        showTipView.text = tip;
        showTipView.hidden = NO;
        showTipView.transform = CGAffineTransformMakeTranslation(0, 0);
        showTipView.alpha = 1;
    }];
}

-(void) endTip
{
    BatteryView.transform = CGAffineTransformMakeTranslation(0, -20);
    BatteryView.alpha = 1;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        BatteryView.transform = CGAffineTransformMakeTranslation(0, 0);
        
        if(!showTipView.hidden)
        {
            showTipView.transform = CGAffineTransformMakeTranslation(0, 10);
            showTipView.alpha = 0;
        }
    } completion:^(BOOL finished) {
        tipView.transform = CGAffineTransformMakeTranslation(0,0);
        showTipView.hidden = YES;
        showTipView.transform = CGAffineTransformMakeTranslation(0, 0);
        showTipView.alpha = 1;
    }];
}

- (void)batteryLevelChanged:(id)sender
{
    UIDevice *device = [UIDevice currentDevice];
    float batteryLevel = ABS([device batteryLevel]);
    if(batteryLevel<0.2)
    {
        Battery_Level.image = [UIImage imageNamed:@"Icon_Red_Battery_Level"];
    }
    Battery_Level.frame = CGRectMake(self.frame.size.width - 28.5, 6.5, 19.8 * batteryLevel, 7.2);

}

-(void)batteryStateChanged:(id)sender
{
    if([[UIDevice currentDevice] batteryState] == 2)
    {
        [BatteryView addSubview:Battery_Charging];
        Battery_Border.center = CGPointMake(Battery_Border.center.x - 9, Battery_Border.center.y);
        Battery_Level.center = CGPointMake(Battery_Level.center.x - 9, Battery_Level.center.y);
    }else{
        if([Battery_Charging superview] != nil)
        {
            Battery_Border.center = CGPointMake(Battery_Border.center.x + 9, Battery_Border.center.y);
            Battery_Level.center = CGPointMake(Battery_Level.center.x + 9, Battery_Level.center.y);
        
            [Battery_Charging removeFromSuperview];
        }

    }
}
@end
