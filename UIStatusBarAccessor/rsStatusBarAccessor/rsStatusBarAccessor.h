//
//  rsStatusBarAccessor.h
//  testWeak
//
//  Created by Radif Sharafullin on 3/7/12.
//  Copyright (c) 2012 Radif Sharafullin. All rights reserved.
//
// Released under MIT license

#import <Foundation/Foundation.h>

@interface rsStatusBarAccessor : NSObject
+(rsStatusBarAccessor *)sharedInstance;
-(UIView *)viewForClassName:(NSString *)className;
-(NSString *)recursiveDescription;

@end
