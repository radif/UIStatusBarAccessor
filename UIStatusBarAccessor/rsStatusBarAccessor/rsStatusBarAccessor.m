//
//  rsStatusBarAccessor.m
//  testWeak
//
//  Created by Radif Sharafullin on 3/7/12.
//  Copyright (c) 2012 Radif Sharafullin. All rights reserved.
//
// Released under MIT license

#import "rsStatusBarAccessor.h"
NSArray * _UIWindowVisible();

UIView * subviewWithClass(UIView *view, Class subviewClass){
    
    NSArray *subviews=view.subviews;
    for (UIView *subview in subviews) 
        if ([subview isKindOfClass:subviewClass]) 
            return subview;
        else {
            UIView * retVal= subviewWithClass(subview, subviewClass);
            if (retVal) return retVal;
        }
    
    return nil;
}

@implementation rsStatusBarAccessor{
 UIStatusBarWindow * _statusBarWindow;
}

static rsStatusBarAccessor * _sharedInstance=nil;
+(rsStatusBarAccessor *)sharedInstance{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance=_sharedInstance?_sharedInstance:[self new];
    });
    
    return _sharedInstance;
}
-(id)init{
    self=[super init];
    if (self) {
        _statusBarWindow=nil;
        Class windowClass=NSClassFromString(@"UIStatusBarWindow");

        NSArray *windows=(NSArray *) _UIWindowVisible();
        for (id win in windows) 
            if ([win isKindOfClass:[windowClass class]]) {
                _statusBarWindow=(UIStatusBarWindow *)win;
                break;
            }
        
        
    }
    return self;
}


-(UIView *)viewForClassName:(NSString *)className{
    Class viewClass=NSClassFromString(className);
    if (!viewClass) return nil;
    if ([_statusBarWindow isKindOfClass:viewClass]) 
        return (UIView *)_statusBarWindow;
    return subviewWithClass((UIView *)_statusBarWindow, viewClass);
}
-(NSString *)recursiveDescription{
    return [_statusBarWindow valueForKey:@"recursiveDescription"];
}
@end
