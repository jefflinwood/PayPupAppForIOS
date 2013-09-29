//
//  AnimalCell.h
//  PayPupApp
//
//  Created by Jeffrey Linwood on 9/28/13.
//  Copyright (c) 2013 Jeff Linwood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimalCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *animalName;
@property (strong, nonatomic) IBOutlet UIImageView *animal1ImageView;
@property (strong, nonatomic) IBOutlet UIImageView *purpleTriangleImageView;
@property (strong, nonatomic) IBOutlet UILabel *percentageLabel;

@end
