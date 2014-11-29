//
//  CEMArticleTableViewCell.h
//  elmundo
//
//  Created by Enrique Ismael Mendoza Robaina on 29/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CEMArticleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet UILabel *articleDate;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UILabel *socialCount;
@property (weak, nonatomic) IBOutlet UILabel *lastHour;

@end
