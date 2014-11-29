//
//  NavigationBarUtils.m
//  cuaQea
//
//  Created by Enrique Mendoza Robaina on 29/11/13.
//  Copyright (c) 2013 Cuaqea SL. All rights reserved.
//

#import "CQANavigationBarUtils.h"

@implementation CQANavigationBarUtils

- (void) setTitleLabel:(NSString *)title controller:(UIViewController *)controller{
    // Cargamos el title bar
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 200, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleLabel setTextColor:[UIColor whiteColor]];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.text = title;
    [titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [titleView addSubview:titleLabel];
    controller.navigationItem.titleView = titleView;
}

- (void) backButtonClick:(UINavigationController *)navigationController{
    
    [navigationController popViewControllerAnimated:YES];
    
    if([[navigationController viewControllers] count] > 3){
        navigationController.viewControllers = @[[[navigationController viewControllers] objectAtIndex:0], [[navigationController viewControllers] objectAtIndex:1], [[navigationController viewControllers] lastObject]];
    }
}
@end
