//
//  CEMNewsCollectionViewController.m
//  elmundo
//
//  Created by Enrique Ismael Mendoza Robaina on 25/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import "CEMNewsCollectionViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CEMNewsViewController.h"

@interface CEMNewsCollectionViewController (){
    NSString *selectedChannelName;
    BOOL isLoadingChannel;
    NSMutableArray *moreChannels;
    UIActivityIndicatorView *spinnerActual;
}

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
        _tableElements =  arrayOfArticles;
        isLoadingChannel = NO;
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
    
    [self checkIfIsUserChannel];
    
    [self.collectionView reloadData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_02_actionbar_logo"]];
    self.parentViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:logo];
    
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_02_actionbar_search"]
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:nil];
    [search setImageInsets:UIEdgeInsetsMake(0.0, -2.5, 0, -75)];
    
    UIBarButtonItem *profile = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_02_actionbar_profile"]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:nil];
    [profile setImageInsets:UIEdgeInsetsMake(0.0, -2.5, 0, -35)];
    
    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_02_actionbar_options"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:nil];
    [menu setImageInsets:UIEdgeInsetsMake(0.0, -2.5, 0, 5)];
    
    self.parentViewController.navigationItem.rightBarButtonItems = @[menu, profile, search];
    
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
        
        [cell setBackgroundView:imageView];
    } else {
        // Image
        NSURL *imageUrl = [NSURL URLWithString:[item objectForKey:@"image"]];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  cell.frame.size.width,
                                                                  cell.frame.size.height)];

        // Set user image with cache
        [imageView sd_setImageWithURL:imageUrl
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     NSLog(@"Cargada");
                                 }];
        
        // Channel title
        [cell setBackgroundColor:[UIColor grayColor]];
    
        float fontSize = 12.0;
        float bottom = 0;
        if (cell.frame.size.width > 205) {
            fontSize += 6;
        } else if (cell.frame.size.width > 95) {
            fontSize += 3;
            bottom = 4;
        } else {
            bottom = 10;
        }
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10,
                                                               cell.frame.size.height - 32 + bottom,
                                                               cell.frame.size.width - 10,
                                                               30)];
        [label setTextColor:[UIColor whiteColor]];
    
        [label setText:NSLocalizedString([item objectForKey:@"channel"],nil)];
    
        [label setFont:[UIFont fontWithName:@"MuseoSans-700" size:fontSize]];
        [label setNumberOfLines:1];
        [label sizeToFit];
        [label setLineBreakMode:NSLineBreakByTruncatingTail];
  
        // Image
        UIImageView *backgroundTitle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_03_topic_gradient"]];
        [backgroundTitle setFrame:CGRectMake(0, cell.frame.size.height - 50, cell.frame.size.width, 50)];
        
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [spinner setFrame:CGRectMake(10, 10, 20, 20)];
        [spinner setHidden:YES];
        
        [cell addSubview:spinner];
        [cell addSubview:backgroundTitle];
        [cell addSubview:label];
        
        [cell setBackgroundView:imageView];
    }
    
    return cell;
}

- (void)buttonClicked:(id)sender
{
    NSLog(@"button clicked");
    UIButton *button = (UIButton *)sender;
    int buttonId = [button tag];
    NSLog([NSString stringWithFormat:@"%d", buttonId]);
}

#pragma mark <UICollectionViewDelegate>


// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}



// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return YES;
}


- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
}*/


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
    }
    return CGSizeMake(92, 92);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    /*CEMNewsViewController *newsVC = [[CEMNewsViewController alloc] initWithTitle:NSLocalizedString(selectedChannelName, nil)
                                                                            news:nil
                                                                      backButton:YES
                                                                           style:UITableViewStylePlain];
    
    [self.navigationController pushViewController:newsVC animated:YES];*/
    NSLog([NSString stringWithFormat:@"%d", indexPath.item]);
    if (indexPath.item == [_tableElements count]-1){
        NSLog(@"Agregar categoria");
        [self selectChannels:self];
    } else {
        if (!isLoadingChannel){
            for (UIView *subview in [[collectionView cellForItemAtIndexPath:indexPath] subviews])
            {
                if([subview isKindOfClass:[UIActivityIndicatorView class]]){
                    spinnerActual = subview;
                    [spinnerActual setHidden:NO];
                    [spinnerActual startAnimating];
                }
            }
            isLoadingChannel = YES;
            //NSLog([NSString stringWithFormat:@"%d", indexPath.row]);
            selectedChannelName = [[_tableElements objectAtIndex:indexPath.row] objectForKey:@"channel"];
            [[CEMElMundoApi alloc] newsByChannel:selectedChannelName
                                  userId:@"userId"
                                calledBy:self
                             withSuccess:@selector(newsByChannelDidEnd:)
                              andFailure:@selector(newsByChannelFailure:)];
        }
    }
}

-(void)newsByChannelDidEnd:(id)result{
    NSLog(@"newsByChannelDidEnd");
    isLoadingChannel = NO;
    [spinnerActual setHidden:YES];
    [spinnerActual stopAnimating];
    CEMNewsViewController *newsVC = [[CEMNewsViewController alloc] initWithTitle:NSLocalizedString(selectedChannelName, nil)
                                                                            news:result
                                                                      backButton:YES
                                                                           style:UITableViewStylePlain];
    
    [self.navigationController pushViewController:newsVC animated:YES];
}

- (void)newsByChannelFailure:(id)result{
    NSLog(@"newsByChannelFailure");
    isLoadingChannel = NO;
    [spinnerActual setHidden:YES];
    [spinnerActual stopAnimating];
}

-(void)checkIfIsUserChannel{
    NSMutableArray *tableElementsMutable = [_tableElements mutableCopy];
    NSArray *myChannels = [CEMSettings getMyChannels];
    moreChannels = [[NSMutableArray alloc] init];
    for (NSDictionary * channel in _tableElements) {
        if ([myChannels indexOfObject:[channel objectForKey:@"channel"]] == NSIntegerMax){
            [tableElementsMutable removeObject:channel];
            [moreChannels addObject:channel];
        }
    }
    
    // Adds add button if user has not loaded all channels
    if (![CEMSettings areAllChannelsLoaded]) {
        [tableElementsMutable addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                             @"", @"channel",
                             @"ic_03_topic_add", @"image", nil]];
    }
    
    _tableElements = tableElementsMutable;
}

- (void)selectChannels:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Choose a new channel", nil) delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    for (NSDictionary *channel in moreChannels) {
        [sheet addButtonWithTitle:[channel objectForKey:@"channel"]];
    }
    sheet.cancelButtonIndex = [sheet addButtonWithTitle:NSLocalizedString(@"Cancel", nil)];
    
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    if (![window.subviews containsObject:self.view]) {
        [sheet showInView:window];
    } else {
        [sheet showInView:self.view];
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        [CEMSettings addChannel:[[moreChannels objectAtIndex:buttonIndex] objectForKey:@"channel"]];
        NSMutableArray *newArray = [_tableElements mutableCopy];
        NSDictionary *buttonAdd = [_tableElements lastObject];
        [newArray removeObject:buttonAdd];
        [newArray addObject:[moreChannels objectAtIndex:buttonIndex]];
        [moreChannels removeObject:[moreChannels objectAtIndex:buttonIndex]];
        [newArray addObject:buttonAdd];
        _tableElements = newArray;
        [self.collectionView reloadData];
        [[CQAAlerts alloc] showInTopViewWithMessage:NSLocalizedString(@"¡Nuevo canal añadido!", nil)
                                              color:[UIColor colorWithRed:122/255.0f
                                                                    green:213/255.0f
                                                                     blue:180/255.0f
                                                                    alpha:1.0f]
                                          fontColor:[UIColor darkGrayColor]
                                           position:nil
                                               time:ALERT_TIME_LONG];
    }
}


@end
