//
//  CEMArticleViewController.h
//  elmundo
//
//  Created by Enrique Ismael Mendoza Robaina on 29/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CEMArticleViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) NSDictionary *model;
@property (nonatomic) BOOL backButton;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *articleCreator;
@property (weak, nonatomic) IBOutlet UILabel *articleDate;
@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet UITextView *articleText;
@property (weak, nonatomic) IBOutlet UIButton *articleVoteButton;
@property (weak, nonatomic) IBOutlet UIView *categoriesView;
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;

- (IBAction)voteArticle:(id)sender;
- (IBAction)viewComments:(id)sender;

- (id)initWithTitle:(NSString *)aTitle
            article:(NSDictionary *)anArticle
         backButton:(BOOL)showBackButton
              style:(UITableViewStyle)aStyle;

@end
