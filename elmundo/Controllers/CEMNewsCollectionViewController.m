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
    if (self = [super initWithNibName:nil bundle:nil]) {
        _tableElements = arrayOfArticles;
        _backButton = showBackButton;
        self.title = aTitle;
        /*UITabBarItem* item = [[UITabBarItem alloc] initWithTitle:nil
                                                           image:[UIImage imageNamed:@"ic_TabBarHome"]
                                                   selectedImage:[UIImage imageNamed:@"ic_TabBarHome"]];
        self.tabBarItem = item;
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);*/
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
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (![_tableElements isEqual:[NSNull alloc]]){
        return (int)[_tableElements count];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
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

@end
