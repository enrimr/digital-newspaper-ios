//
//  CEMNewsViewController.m
//  elmundo
//
//  Created by Enrique Ismael Mendoza Robaina on 24/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import "CEMNewsViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CEMArticleTableViewCell.h"
#import "CEMArticleTableViewCellSmall.h"
#import "CQATimeUtils.h"
#import "CQANavigationBarUtils.h"
#import "CEMArticleViewController.h"

@interface CEMNewsViewController (){
}
@end

@implementation CEMNewsViewController

- (id)initWithTitle:(NSString *)aTitle
               news:(NSArray *)arrayOfNews
             backButton:(BOOL)showBackButton
                  style:(UITableViewStyle)aStyle
{
    if (self = [super initWithStyle:aStyle]) {
        _tableElements = arrayOfNews;
        _backButton = showBackButton;
        self.title = aTitle;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
        self.navigationItem.title = self.title;
        
        //ic_TabNavBlueArrowNav
        self.navigationItem.leftBarButtonItem =
        [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_TabNavBlueArrowNav"]
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(backButtonClick)];
        
        UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_02_actionbar_search"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:nil];
        [search setImageInsets:UIEdgeInsetsMake(0.0, -2.5, 0, -40)];
        
        UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_02_actionbar_options"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:nil];
        [menu setImageInsets:UIEdgeInsetsMake(0.0, -2.5, 0, 5)];
        
        self.navigationItem.rightBarButtonItems = @[menu, search];
    if ([self.title isEqualToString:@"Mi mundo"]){
        [[CEMElMundoApi alloc] newsByChannel:@"social"
                                      userId:@"userId"
                                    calledBy:self
                                 withSuccess:@selector(newsByChannelDidEnd:)
                                  andFailure:@selector(newsByChannelFailure:)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (![_tableElements isEqual:[NSNull alloc]]){
        return (int)[_tableElements count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *item = [_tableElements objectAtIndex:indexPath.item];
    
    
    
    if (indexPath.row == 0){
        NSString *cellId = @"articleMain";
        
        // Declaramos el tipo de celda CQACuaqTableViewCell para que la tabla lo entienda y lo conozca
        [tableView registerNib:[UINib nibWithNibName:@"CEMArticleTableViewCell" bundle:nil] forCellReuseIdentifier:cellId];
        
        // Reutilizaremos una celda del mismo identificador cellId
        CEMArticleTableViewCell *cell = (CEMArticleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (!cell) {
            // En caso de que no se pudiera reutilizar, creamos una nueva
            cell = [[CEMArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:cellId];
        }
        
        NSString *imageUrlString = nil;
        NSArray *arrayOfImages = (NSArray *)[item objectForKey:@"images"];
        int imagesCount = 0;
        if (arrayOfImages == nil || [arrayOfImages count] == 0){
            arrayOfImages = nil;
            [cell.articleImage setImage:[UIImage imageNamed:@"imageBackground"]];
        } else {
            imagesCount = (int)[arrayOfImages count];
            imageUrlString = [arrayOfImages objectAtIndex:0];
            [cell.articleImage sd_setImageWithURL:[NSURL URLWithString:imageUrlString]
                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                            NSLog(@"Cargada");
                                        }];
        }

        
        [cell.articleTitle setText:[item objectForKey:@"title"]];
        
        // Calculamos el timestamp
        NSTimeInterval dateToday = [[NSDate date] timeIntervalSince1970];
        NSString *time = [NSString stringWithFormat:@"%@",[item objectForKey:@"publicationDate"]];
        NSString *time10 = [time substringToIndex:10];
        int timeInt = [time10 intValue];
        int difference = dateToday - timeInt;
        [cell.articleDate setText:[CQATimeUtils getTimeString:difference]];
        
        return cell;
    } else {
        NSString *cellId = @"articleSmall";
        
        // Declaramos el tipo de celda CQACuaqTableViewCell para que la tabla lo entienda y lo conozca
        [tableView registerNib:[UINib nibWithNibName:@"CEMArticleTableViewCellSmall" bundle:nil] forCellReuseIdentifier:cellId];
        
        // Reutilizaremos una celda del mismo identificador cellId
        CEMArticleTableViewCellSmall *cell = (CEMArticleTableViewCellSmall *)[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (!cell) {
            // En caso de que no se pudiera reutilizar, creamos una nueva
            cell = [[CEMArticleTableViewCellSmall alloc]initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:cellId];
        }
        
        NSString *imageUrlString = nil;
        NSArray *arrayOfImages = (NSArray *)[item objectForKey:@"images"];
        int imagesCount = 0;
        if (arrayOfImages == nil || [arrayOfImages count] == 0){
            arrayOfImages = nil;
            [cell.articleImage setImage:[UIImage imageNamed:@"imageBackground"]];
        } else {
            imagesCount = (int)[arrayOfImages count];
            imageUrlString = [arrayOfImages objectAtIndex:0];
            [cell.articleImage sd_setImageWithURL:[NSURL URLWithString:imageUrlString]
                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                            NSLog(@"Cargada");
                                        }];
        }
        
        // Mostramos el texto
        NSString *textString = (NSString *)[item objectForKey:@"text"];
        if ([textString length] >= 150) {
            textString = [textString substringToIndex:149];
        }
        [cell.articleText setText:[self stringByStrippingHTML:textString]];
        [cell.articleText setFont:[UIFont fontWithName:@"MuseoSans-700" size:12.0]];
        [cell.articleText setTextColor:[UIColor lightGrayColor]];
        
        [cell.articleTitle setText:[item objectForKey:@"title"]];
        
        // Calculamos el timestamp
        NSTimeInterval dateToday = [[NSDate date] timeIntervalSince1970];
        NSString *time = [NSString stringWithFormat:@"%@",[item objectForKey:@"publicationDate"]];
        NSString *time10 = [time substringToIndex:10];
        int timeInt = [time10 intValue];
        int difference = dateToday - timeInt;
        [cell.articleDate setText:[CQATimeUtils getTimeString:difference]];
        
        return cell;
    }
    
    // Configure the cell...
    
    return nil;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    NSDictionary *article = [_tableElements objectAtIndex:indexPath.item];
    CEMArticleViewController *detailViewController = [[CEMArticleViewController alloc]
                                                      initWithTitle:[article objectForKey:@"title"]
                                                      article:article
                                                      backButton:YES
                                                      style:UITableViewStylePlain];
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0 && indexPath.row == 0) {
        return 220.0;
    }
    // "Else"
    return 114;
}

- (void) backButtonClick {
    NSLog(@"backButtonClick local");
    [[CQANavigationBarUtils alloc] backButtonClick:self.navigationController];
}

-(NSString *) stringByStrippingHTML:(NSString *)s {
    NSRange r;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

- (void)newsByChannelDidEnd:(id)result{
    _tableElements = (NSArray *)result;
    [self.tableView reloadData];
}

-(void)newsByChannelFailure:(id)result{
    NSLog(@"newsByChannelFailure");
}

-(void)cubeViewDidUnhide
{

    self.parentViewController.navigationItem.title = self.title;
    [[CEMElMundoApi alloc] newsByChannel:@"social"
                                  userId:@"userId"
                                calledBy:self
                             withSuccess:@selector(newsByChannelDidEnd:)
                              andFailure:@selector(newsByChannelFailure:)];
    
    self.parentViewController.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[[UIImage alloc] init]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:nil];
    
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_02_actionbar_search"]
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:nil];
    [search setImageInsets:UIEdgeInsetsMake(0.0, -2.5, 0, -40)];
    
    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_02_actionbar_options"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:nil];
    [menu setImageInsets:UIEdgeInsetsMake(0.0, -2.5, 0, 5)];
    
    self.parentViewController.navigationItem.rightBarButtonItems = @[menu, search];
}

@end
