//
//  AppDelegate.h
//  PayPupApp
//
//  Created by Jeffrey Linwood on 9/28/13.
//  Copyright (c) 2013 Jeff Linwood. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) MSClient *client;
@property (strong, nonatomic) UIWindow *window;

@end
