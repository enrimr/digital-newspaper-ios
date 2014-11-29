//
//  CEMCreatorsCollectionCollectionViewController.h
//  elmundo
//
//  Created by Enrique Ismael Mendoza Robaina on 29/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKLCubeViewController.h"

@interface CEMCreatorsCollectionCollectionViewController : UICollectionViewController<UIActionSheetDelegate, GKLCubeViewControllerDelegate>

@property (strong, nonatomic) NSArray *tableElements;
@property (nonatomic) BOOL backButton;

- (id)initWithTitle:(NSString *)aTitle
           creators:(NSArray *)arrayOfCreators
         backButton:(BOOL)showBackButton;
@end
