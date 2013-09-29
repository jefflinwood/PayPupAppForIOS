//
//  AnimalViewController.m
//  PayPupApp
//
//  Created by Jeffrey Linwood on 9/28/13.
//  Copyright (c) 2013 Jeff Linwood. All rights reserved.
//

#import "AnimalViewController.h"

#import <AFNetworking/AFNetworking.h>

#import "AnimalDonateCell.h"
#import "AnimalMainCell.h"
#import "AnimalStoryCell.h"
#import "AppDelegate.h"

#import "SVWebViewController.h"


@interface AnimalViewController ()
@property (nonatomic, strong) UIImageView *primaryImageView;
@property (nonatomic, strong) UIWebView *sizingWebView;
@property (nonatomic, assign) CGFloat webViewHeight;
@end

@implementation AnimalViewController


- (MSClient*) client {
    AppDelegate *appDelegate = (AppDelegate*) [UIApplication sharedApplication].delegate;
    return appDelegate.client;
}


#pragma mark UITableViewControllerDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        AnimalMainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnimalMainCell"];
        return cell.frame.size.height;
    }
    if (indexPath.row == 1) {
        AnimalDonateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnimalDonateCell"];
        return cell.frame.size.height;
    }
    if (indexPath.row == 2) {
        return self.webViewHeight;
    }
    
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        AnimalMainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnimalMainCell"];
        cell.pageControl.numberOfPages = 3;
        
        
        cell.pagingScrollView.contentSize = CGSizeMake(cell.pagingScrollView.frame.size.width * 3, cell.pagingScrollView.frame.size.height);
        if (self.animal[@"image1url"] != nil && self.animal[@"image1url"] != [NSNull null]) {
            CGRect frame = cell.pagingScrollView.bounds;
            self.primaryImageView = [[UIImageView alloc] initWithFrame:frame];
            NSURL *imageURL = [NSURL URLWithString:self.animal[@"image1url"]];
            [self.primaryImageView setImageWithURL:imageURL placeholderImage:nil];
            self.primaryImageView.contentMode = UIViewContentModeScaleAspectFit;
            self.primaryImageView.backgroundColor = [UIColor blackColor];
            [cell.pagingScrollView addSubview:self.primaryImageView];
        }
        if (self.animal[@"image3url"] != nil && self.animal[@"image3url"] != [NSNull null]) {
            CGRect frame = cell.pagingScrollView.bounds;
            frame.origin.x = frame.origin.x + frame.size.width * 2;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            NSURL *imageURL = [NSURL URLWithString:self.animal[@"image3url"]];
            [imageView setImageWithURL:imageURL placeholderImage:nil];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.backgroundColor = [UIColor blackColor];
            [cell.pagingScrollView addSubview:imageView];
        } else {
            cell.pagingScrollView.contentSize = CGSizeMake(cell.pagingScrollView.frame.size.width * 2, cell.pagingScrollView.frame.size.height);
            cell.pageControl.numberOfPages = 2;
        }
        if (self.animal[@"image2url"] != nil && self.animal[@"image2url"] != [NSNull null]) {
            CGRect frame = cell.pagingScrollView.bounds;
            frame.origin.x = frame.origin.x + frame.size.width;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            NSURL *imageURL = [NSURL URLWithString:self.animal[@"image2url"]];
            [imageView setImageWithURL:imageURL placeholderImage:nil];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.backgroundColor = [UIColor blackColor];
            [cell.pagingScrollView addSubview:imageView];
        } else {
            cell.pagingScrollView.contentSize = CGSizeMake(cell.pagingScrollView.frame.size.width * 1, cell.pagingScrollView.frame.size.height);
            cell.pageControl.numberOfPages = 1;
        }

        
        
        
        return cell;
    }
    if (indexPath.row == 1) {
        AnimalDonateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnimalDonateCell"];
        
        
        cell.donateButton.buttonColor = [UIColor turquoiseColor];
        cell.donateButton.shadowColor = [UIColor greenSeaColor];
        cell.donateButton.shadowHeight = 3.0f;
        cell.donateButton.cornerRadius = 6.0f;
        cell.donateButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
        [cell.donateButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        [cell.donateButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
        
        [cell.donateProgressView configureFlatProgressViewWithTrackColor:[UIColor silverColor]
                                                  progressColor:[UIColor midnightBlueColor]];
        
        
        NSNumber *fundingGoal = self.animal[@"fundingGoal"];
        NSNumber *currentFunding = self.animal[@"currentFunding"];
        
        if (fundingGoal != nil && fundingGoal != [NSNull null] && currentFunding != nil && currentFunding != [NSNull null]) {
            
            int percentage =  roundf( 100.0f * [currentFunding floatValue] / [fundingGoal floatValue]);
            cell.donateProgressView.progress = percentage / 100.0f;
            
            cell.donationLabel.text = [NSString stringWithFormat:@"Raised $%d out of $%d",[currentFunding intValue],[fundingGoal intValue]];
            
            cell.donationReasonLabel.text = [NSString stringWithFormat:@"Help %@ with %@!",self.animal[@"name"],self.animal[@"fundingReason"]];
            
            //cell.percentageLabel.text = [NSString stringWithFormat:@"%d%%",percentage];
            
            
            
        } else {
            cell.donationReasonLabel.text = [NSString stringWithFormat:@"Help %@ with %@",self.animal[@"name"],@"a Donation!"];
        }
        

        
        return cell;
    }
    if (indexPath.row == 2) {
        AnimalStoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnimalStoryCell"];
        cell.webView.scrollView.scrollEnabled = NO;
        NSString *uri = [NSString stringWithFormat:@"http://www.austinpetsalive.org%@",self.animal[@"url"]];
        [cell.webView loadHTMLString:self.animal[@"story"] baseURL:[NSURL URLWithString:uri]];
        return cell;
    }

    
    return nil;
}


- (void) share:(id)sender {
    NSString *textToShare = [NSString stringWithFormat:@"I want to share %@ the dog from Austin Pets Alive with you!",self.animal[@"name"]];
    NSString *uri = [NSString stringWithFormat:@"http://www.austinpetsalive.org%@",self.animal[@"url"]];
    NSURL *urlToShare = [NSURL URLWithString:uri];
    UIImage *imageToShare = self.primaryImageView.image;
    NSArray *itemsToShare = [[NSArray alloc] initWithObjects:textToShare, urlToShare, imageToShare, nil];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes = [[NSArray alloc] initWithObjects: UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypePostToWeibo, nil];
    [self presentViewController:activityVC animated:YES completion:nil];

}

#pragma mark UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = self.animal[@"name"];
    self.webViewHeight = 2000;
    
    /*
    self.sizingWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 1500)];
    self.sizingWebView.tag = 999;
    self.sizingWebView.delegate = self;
    [self.sizingWebView loadHTMLString:self.animal[@"story"] baseURL:nil];*/
    
    /*self.navigationItem.rightBarButtonItem = [UIBarButtonItem alloc] initWithBarButtonSystemItem:UIB target:<#(id)#> action:<#(SEL)#>*/
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
        

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donate:(id)sender {
    
    
    // Create a PayPalPayment
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = [[NSDecimalNumber alloc] initWithString:@"5.00"];
    payment.currencyCode = @"USD";
    payment.shortDescription = [NSString stringWithFormat:@"Donation for %@",self.animal[@"name"]];
    
    // Check whether payment is processable.
    if (!payment.processable) {
        // If, for example, the amount was negative or the shortDescription was empty, then
        // this payment would not be processable. You would want to handle that here.
    }
    
    
    // Start out working with the test environment! When you are ready, remove this line to switch to live.
    [PayPalPaymentViewController setEnvironment:PayPalEnvironmentNoNetwork];
    
    // Provide a payerId that uniquely identifies a user within the scope of your system,
    // such as an email address or user ID.
    NSString *aPayerId = @"jlinwood@gmail.com";
    
    // Create a PayPalPaymentViewController with the credentials and payerId, the PayPalPayment
    // from the previous step, and a PayPalPaymentDelegate to handle the results.
    PayPalPaymentViewController *paymentViewController;
    paymentViewController = [[PayPalPaymentViewController alloc] initWithClientId:@"PAYPAL_CLIENT_ID"
                                                                    receiverEmail:@"PAYPAL_RECEIVER_EMAIL"
                                                                          payerId:aPayerId
                                                                          payment:payment
                                                                         delegate:self];
    
    // Present the PayPalPaymentViewController.
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

#pragma mark - UIWebViewDelegate methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (webView.tag == 999) {
        return YES;
    }
    NSURL *URL = request.URL;
    if ([@"www.austinpetsalive.org" isEqualToString:URL.host]) {
        return YES;
    }
    SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
    [self.navigationController pushViewController:webViewController animated:YES];
    return NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (webView.tag == 999) {
        CGRect frame = webView.frame;
        frame.size.height = 100;
        webView.frame = frame;
        CGSize sizeThatFits = [webView sizeThatFits:CGSizeZero];
        if (floor(sizeThatFits.height) != floor(self.webViewHeight)) {
            self.webViewHeight = sizeThatFits.height;

            [self.tableView reloadData];
        }
    }
}


#pragma mark - PayPalPaymentDelegate methods

- (void)payPalPaymentDidComplete:(PayPalPayment *)completedPayment {
    // Payment was processed successfully; send to server for verification and fulfillment.
    [self verifyCompletedPayment:completedPayment];
    
    // Dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel {
    // The payment was canceled; dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Payment complete methods


- (void)verifyCompletedPayment:(PayPalPayment *)completedPayment {
    // Send the entire confirmation dictionary
    NSData *confirmation = [NSJSONSerialization dataWithJSONObject:completedPayment.confirmation
                                                           options:0
                                                             error:nil];
    
    int currentFunding = [self.animal[@"currentFunding"] intValue];
    currentFunding += 5;
    
    MSTable *animalsTable = [[self client] tableWithName:@"animals"];
    NSDictionary *dog = @{@"id":self.animal[@"id"],
                          @"currentFunding": [NSNumber numberWithInt:currentFunding]};
    [animalsTable update:dog completion:^(NSDictionary *item, NSError *error) {
        [animalsTable readWithId:self.animal[@"id"] completion:^(NSDictionary *item, NSError *error) {
            self.animal = item;
            [self.tableView reloadData];
            
            NSString *message = [NSString stringWithFormat:@"%@ thanks you for your donation!",self.animal[@"name"]];
            
            FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"PayPup"
                                                                  message:message
                                                                 delegate:nil cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
            alertView.titleLabel.textColor = [UIColor cloudsColor];
            alertView.titleLabel.font = [UIFont boldFlatFontOfSize:14];
            alertView.messageLabel.textColor = [UIColor cloudsColor];
            alertView.messageLabel.font = [UIFont flatFontOfSize:24];
            alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
            alertView.alertContainer.backgroundColor = [UIColor midnightBlueColor];
            alertView.defaultButtonColor = [UIColor cloudsColor];
            alertView.defaultButtonShadowColor = [UIColor asbestosColor];
            alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
            alertView.defaultButtonTitleColor = [UIColor asbestosColor];
            [alertView show];
            
        }];
    }];
    
    
    // Send confirmation to your server; your server should verify the proof of payment
    // and give the user their goods or services. If the server is not reachable, save
    // the confirmation and try again later.
}
@end
