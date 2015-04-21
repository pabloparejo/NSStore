//
//  PARStoreViewController.h
//  chineseStore
//
//  Created by Pablo Parejo Camacho on 28/3/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductReusableView.h"

@interface PARStoreViewController : UIViewController

@property (nonatomic, strong) NSArray *model;

- (instancetype) initWithModel:(NSArray *)model;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic)  ProductReusableView *selectedCell;
@end
