//
//  AnimalMainCell.h
//  PayPupApp
//
//  Created by Jeffrey Linwood on 9/28/13.
//  Copyright (c) 2013 Jeff Linwood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimalMainCell : UITableViewCell <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *pagingScrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
- (IBAction)changePage:(id)sender;

@end
