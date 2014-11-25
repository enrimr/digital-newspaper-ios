//
//  CEMNewsViewController.h
//  elmundo
//
//  Created by Enrique Ismael Mendoza Robaina on 24/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CEMNewsViewController : UITableViewController

@property (strong, nonatomic) NSArray *tableElements;
@property (nonatomic) BOOL backButton;

- (id)initWithTitle:(NSString *)aTitle
               news:(NSArray *)arrayOfNews
         backButton:(BOOL)showBackButton
              style:(UITableViewStyle)aStyle;

@end
