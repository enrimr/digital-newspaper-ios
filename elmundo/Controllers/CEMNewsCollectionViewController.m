//
//  CEMNewsCollectionViewController.m
//  elmundo
//
//  Created by Enrique Ismael Mendoza Robaina on 25/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import "CEMNewsCollectionViewController.h"

@interface CEMNewsCollectionViewController ()

@end

@implementation CEMNewsCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (id)initWithTitle:(NSString *)aTitle
           articles:(NSArray *)arrayOfArticles
         backButton:(BOOL)showBackButton
{
    
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //flowLayout.itemSize = CGSizeMake(200, 200);
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    if (self = [super initWithCollectionViewLayout:flowLayout]) {
        _backButton = showBackButton;
        NSMutableArray *arrayWithAdd = [NSMutableArray arrayWithArray:arrayOfArticles];
        [arrayWithAdd addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                 @"", @"channel",
                                 @"addButton", @"image", nil]];
        _tableElements = [NSArray arrayWithArray:arrayWithAdd];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
    [self.collectionView reloadData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoLaunch"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:logo];
    
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_TabNavMainSearch"]
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:nil];
    [search setImageInsets:UIEdgeInsetsMake(0.0, -2.5, 0, -75)];
    
    UIBarButtonItem *profile = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_UserProfileSettings"]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:nil];
    [profile setImageInsets:UIEdgeInsetsMake(0.0, -2.5, 0, -35)];
    
    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_Settings"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:nil];
    [menu setImageInsets:UIEdgeInsetsMake(0.0, -2.5, 0, 5)];
    
    self.navigationItem.rightBarButtonItems = @[menu, profile, search];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (![_tableElements isEqual:[NSNull alloc]]){
        return (int)[_tableElements count];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                           forIndexPath:indexPath];
    
    NSDictionary *item = [_tableElements objectAtIndex:indexPath.row];
    
    // Clean the subviews
    for (UIView *subview in [cell subviews])
    {
        [subview removeFromSuperview];
    }
    
    // Configure the cell
    UIImageView *imageView;
    if (indexPath.row == (int)[_tableElements count]-1){
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[item objectForKey:@"image"]]];
    } else {
        // Image
        NSURL *imageUrl = [NSURL URLWithString:[item objectForKey:@"image"]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        /*UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                           0,
                                                                           cell.frame.size.width,
                                                                           cell.frame.size.height)];*/
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:imageData]];
    
        // Channel title
        [cell setBackgroundColor:[UIColor grayColor]];
    
        float fontSize = 14.0;
        float bottom = 0;
        if (cell.frame.size.width > 205) {
            fontSize += 6;
        } else if (cell.frame.size.width > 95) {
            fontSize += 3;
            bottom = 4;
        } else {
            bottom = 8;
        }
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10,
                                                               cell.frame.size.height - 32 + bottom,
                                                               cell.frame.size.width - 10,
                                                               30)];
        [label setTextColor:[UIColor whiteColor]];
    
        [label setText:NSLocalizedString([item objectForKey:@"channel"],nil)];
    
        [label setFont:[UIFont fontWithName:@"MuseoSans-700" size:fontSize]];
        [label setNumberOfLines:0];
        [label sizeToFit];
        [label setLineBreakMode:NSLineBreakByTruncatingTail];
  
        // Image
        /*UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
         0,
         cell.frame.size.width,
         cell.frame.size.height)];*/
        UIImageView *backgroundTitle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"boxTitle-small"]];
        [backgroundTitle setFrame:CGRectMake(0, cell.frame.size.height - 50, cell.frame.size.width, 50)];
        
        [cell addSubview:backgroundTitle];
        [cell addSubview:label];
    
        
    }
    
    [cell setBackgroundView:imageView];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0){
        return CGSizeMake(300, 150);
    } else if (indexPath.row == 1){
        return CGSizeMake(200, 92);
    } else if (indexPath.row == 2){
        return CGSizeMake(90, 92);
    } else if (indexPath.row == 3){
        return CGSizeMake(145, 92);
    } else if (indexPath.row == 4){
        return CGSizeMake(145, 92);
    } else if (indexPath.row == 4){
        return CGSizeMake(92, 92);
    } else if (indexPath.row == 4){
        return CGSizeMake(195, 92);
    }/* else if (indexPath.row % 3 == 0){
        return CGSizeMake(100, 100);
    } else if (indexPath.row % 3 == 1) {
        return CGSizeMake(200, 100);
    } else if (indexPath.row % 3 == 2) {
        return CGSizeMake(200, 200);
    }*/
    return CGSizeMake(92, 92);
}

@end
