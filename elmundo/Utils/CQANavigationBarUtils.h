//
//  NavigationBarUtils.h
//  cuaQea
//
//  Created by Enrique Mendoza Robaina on 29/11/13.
//  Copyright (c) 2013 Cuaqea SL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CQANavigationBarUtils : NSObject

- (void) setTitleLabel:(NSString *)title controller:(UIViewController *)controller;

- (void) backButtonClick:(UINavigationController *)navigationController;
    
@end
