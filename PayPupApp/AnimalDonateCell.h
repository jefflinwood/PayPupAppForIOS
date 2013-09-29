//
//  AnimalDonateCell.h
//  PayPupApp
//
//  Created by Jeffrey Linwood on 9/28/13.
//  Copyright (c) 2013 Jeff Linwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlatUIKit.h"


@interface AnimalDonateCell : UITableViewCell
@property (strong, nonatomic) IBOutlet FUIButton *donateButton;
@property (strong, nonatomic) IBOutlet UIProgressView *donateProgressView;
@property (strong, nonatomic) IBOutlet UILabel *donationLabel;
@property (strong, nonatomic) IBOutlet UILabel *donationReasonLabel;

@end
