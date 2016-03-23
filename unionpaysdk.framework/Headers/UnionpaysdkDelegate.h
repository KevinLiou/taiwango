//
//  unionpaysdkDelegate.h
//  unionpaysdk
//
//  Created by jess on 2016/3/05.
//  Copyright © 2016年 jess. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UnionpaysdkDelegate <NSObject>

@optional
-(void)IPaymentIsSuccess:(BOOL)IsSuccess;




@end
