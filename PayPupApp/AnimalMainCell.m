//
//  AnimalMainCell.m
//  PayPupApp
//
//  Created by Jeffrey Linwood on 9/28/13.
//  Copyright (c) 2013 Jeff Linwood. All rights reserved.
//

#import "AnimalMainCell.h"

@implementation AnimalMainCell

//code from http://www.iosdevnotes.com/2011/03/uiscrollview-paging/
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.pagingScrollView.frame.size.width;
    int page = floor((self.pagingScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

//code from http://www.iosdevnotes.com/2011/03/uiscrollview-paging/
- (IBAction)changePage:(id)sender {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.pagingScrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.pagingScrollView.frame.size;
    [self.pagingScrollView scrollRectToVisible:frame animated:YES];
}
@end
