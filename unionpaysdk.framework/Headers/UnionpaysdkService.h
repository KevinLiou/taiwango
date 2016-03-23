//
//  unionpaysdkService.h
//  unionpaysdk
//
//  Created by jess on 2016/2/22.
//  Copyright © 2016年 jess. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UnionpaysdkService : NSObject
+(UnionpaysdkService *) getInstance;

+(void) InitWithKey:(NSString *)key andScode:(NSString *)scode andIsRace:(BOOL)isRace;

+(UIViewController *) CreateWebView:(id)delegate withOrderId:(NSString*)orderId andAmount:(double)amount andMemo:(NSString*)memo andPayCallBackUrl:(NSString*)payCallPayBackUrl;

@end