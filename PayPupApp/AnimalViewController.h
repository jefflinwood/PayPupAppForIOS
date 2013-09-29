//
//  AnimalViewController.h
//  PayPupApp
//
//  Created by Jeffrey Linwood on 9/28/13.
//  Copyright (c) 2013 Jeff Linwood. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PayPalMobile.h"


@interface AnimalViewController : UITableViewController <PayPalPaymentDelegate, UIWebViewDelegate>


- (IBAction)donate:(id)sender;


@property (nonatomic, strong) NSDictionary *animal;
@end
