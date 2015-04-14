//
//  StatusbarTip.h
//  StatusbarScroll
//
//  Created by as on 15/4/13.
//  Copyright (c) 2015年 as. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TipMessage.h"
@interface StatusbarTip : NSObject

-(void)PushTip:(TipMessage *) tip;
-(void)RunQueued;

@end
