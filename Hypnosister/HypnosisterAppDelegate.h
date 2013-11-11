//
//  HypnosisterAppDelegate.h
//  Hypnosister
//
//  Created by Alan Sparrow on 11/9/13.
//  Copyright (c) 2013 Alan Sparrow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HypnosisView.h"
#import "LogoView.h"

@interface HypnosisterAppDelegate : UIResponder <UIApplicationDelegate, UIScrollViewDelegate>
{
    HypnosisView *view;
    LogoView *logoView;
}

@property (strong, nonatomic) UIWindow *window;

@end
