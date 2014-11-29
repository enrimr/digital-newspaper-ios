//
//  CEMNewsCollectionViewController.h
//  elmundo
//
//  Created by Enrique Ismael Mendoza Robaina on 25/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKLCubeViewController.h"

@interface CEMNewsCollectionViewController : UICollectionViewController<UIActionSheetDelegate, GKLCubeViewControllerDelegate>

@property (strong, nonatomic) NSArray *tableElements;
@property (nonatomic) BOOL backButton;

- (id)initWithTitle:(NSString *)aTitle
           articles:(NSArray *)arrayOfArticles
         backButton:(BOOL)showBackButton;

@end
