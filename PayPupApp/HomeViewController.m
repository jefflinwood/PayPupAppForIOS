//
//  HomeViewController.m
//  PayPupApp
//
//  Created by Jeffrey Linwood on 9/28/13.
//  Copyright (c) 2013 Jeff Linwood. All rights reserved.
//

#import "HomeViewController.h"

#import <AFNetworking/AFNetworking.h>

#import "FlatUIKit.h"

#import "AnimalCell.h"
#import "AppDelegate.h"


@interface HomeViewController ()
@property (nonatomic, strong) NSArray *animals;
- (MSClient*) client;
@end

@implementation HomeViewController

- (MSClient*) client {
    AppDelegate *appDelegate = (AppDelegate*) [UIApplication sharedApplication].delegate;
    return appDelegate.client;
}

#pragma mark UICollectionViewDataSource methods

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *animal = self.animals[indexPath.row];
    
    AnimalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnimalCell" forIndexPath:indexPath];
    cell.animalName.text = animal[@"name"];
    NSString *image1URI = animal[@"image1url"];
    [cell.animal1ImageView setImageWithURL:[NSURL URLWithString:image1URI] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    NSNumber *fundingGoal = animal[@"fundingGoal"];
    NSNumber *currentFunding = animal[@"currentFunding"];
    
    if (fundingGoal != nil && fundingGoal != [NSNull null] && currentFunding != nil && currentFunding != [NSNull null]) {
        cell.purpleTriangleImageView.hidden = NO;
        cell.percentageLabel.hidden = NO;
        
        int percentage =  roundf( 100.0f * [currentFunding floatValue] / [fundingGoal floatValue]);
        cell.percentageLabel.text = [NSString stringWithFormat:@"%d%%",percentage];
        
        
        
    } else {
        cell.purpleTriangleImageView.hidden = YES;
        cell.percentageLabel.hidden = YES;
        cell.percentageLabel.text = @"";
    }
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.animals count];
}

#pragma mark UICollectionViewDelegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma  mark UIViewController methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UICollectionViewCell class]]) {
        if ([segue.identifier isEqualToString:@"AnimalDetail"]) {
            if ([segue.destinationViewController respondsToSelector:@selector(setAnimal:)]) {
                NSIndexPath *indexPath = [self.collectionView indexPathsForSelectedItems][0];
                NSDictionary *animal = self.animals[indexPath.row];

                [segue.destinationViewController performSelector:@selector(setAnimal:)
                                                      withObject:animal];
            }
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"PayPup";
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor midnightBlueColor]];
        
}

- (void) viewWillAppear:(BOOL)animated {
    
    //load up all of the animals in the database
    MSTable *animalsTable = [[self client] tableWithName:@"animals"];
    [animalsTable readWithCompletion:^(NSArray *items, NSInteger totalCount, NSError *error) {
        self.animals = items;
        [self.collectionView reloadData];
    }];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
