//
//  TipMessage.h
//  StatusbarScroll
//
//  Created by as on 15/4/14.
//  Copyright (c) 2015年 as. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TipMessage : NSObject

+(TipMessage *) Tip;

@property (nonatomic, retain) NSString *tipMessage;
@property (nonatomic) NSTimeInterval Delay;


@end
