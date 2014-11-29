//
//  CEMLaunchViewController.m
//  elmundo
//
//  Created by Enrique Ismael Mendoza Robaina on 24/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import "CEMLaunchViewController.h"
#import "CEMArticle.h"
#import "CEMAd.h"
#import "CEMNewsCollectionViewController.h"
#import "GKLCubeViewController.h"
#import "CEMNewsViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface CEMLaunchViewController ()
{
    NSArray *socialArticlesArray;
    // Location
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSString *location;
}

@end

@implementation CEMLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Posición
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    
    socialArticlesArray = [[NSArray alloc] init];
    
    if ([CEMSettings getChannels] == nil){
        [[CEMElMundoApi alloc] channels:@"userId" calledBy:self withSuccess:@selector(channelsDidEnd:) andFailure:@selector(channelsFailure:)];
    } else {
        [self goToChannels:[CEMSettings getChannels]];
        /*[[CEMElMundoApi alloc] newsByChannel:@"social"
                                      userId:@"userId"
                                    calledBy:self
                                 withSuccess:@selector(newsByChannelDidEnd:)
                                  andFailure:@selector(newsByChannelFailure:)];*/
    }
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:
                                                                        [UIColor colorWithRed:117/255.0f
                                                                                        green:125/255.0f
                                                                                         blue:144/255.0f
                                                                                        alpha:1.0f]};
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:122/255.0f
                                                                        green:213/255.0f
                                                                         blue:180/255.0f
                                                                        alpha:1.0f];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_spinner startAnimating];
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.navigationController.navigationItem.hidesBackButton = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_spinner stopAnimating];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationItem.hidesBackButton = YES;
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

-(void)channelsDidEnd:(id)result
{
    NSLog(@"channelsDidEnd");

    //NSMutableArray *articles = [[NSArray arrayWithArray:(NSArray *)result] mutableCopy];
    //[articles addObjectsFromArray:articles];
    
    [CEMSettings setChannels:result];
    
    [[CEMElMundoApi alloc] newsByChannel:@"social" userId:@"userId" calledBy:self withSuccess:@selector(newsByChannelDidEnd:) andFailure:@selector(newsByChannelFailure:)];
    

}

-(void)channelsFailure:(id)result
{
    NSLog(@"channelsFailure");
}

-(void)newsByChannelDidEnd:(id)result{
    socialArticlesArray = (NSArray *)result;
    [self goToChannels:result];
}

-(void)newsByChannelFailure:(id)result{
    NSLog(@"newsByChannelFailure");
    [self goToChannels:result];
}

-(void)goToChannels:(NSArray *)arrayOfChannels{
    
    GKLCubeViewController *cubeViewController = [[GKLCubeViewController alloc] initWithNibName:nil bundle:nil];

    CEMNewsCollectionViewController *articlesVC = [[CEMNewsCollectionViewController alloc] initWithTitle:@"El Mundo"
                                                                                                articles:arrayOfChannels
                                                                                              backButton:NO];
    CEMNewsViewController *socialCategoryVC = [[CEMNewsViewController alloc] initWithTitle:@"Mi mundo"
                                                                                    news:socialArticlesArray
                                                                                backButton:YES
                                                                                   style:UITableViewStylePlain];
    [cubeViewController addCubeSideForChildController:articlesVC];
    [cubeViewController addCubeSideForChildController:socialCategoryVC];
    
    [[self navigationController] pushViewController:cubeViewController animated:YES];
}

#pragma mark Location manager
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    location = NSLocalizedString(@"No location", nil);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        NSLog([NSString stringWithFormat:@"Longitude: %.8f", currentLocation.coordinate.longitude]);
        NSLog([NSString stringWithFormat:@"Latitude: %.8f", currentLocation.coordinate.latitude]);
    }
    
    // Stop Location Manager
    [locationManager stopUpdatingLocation];
    
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        //NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            
            //            NSLog(@"%@",[NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@ - Locality: %@, Sublocality: %@",
            //                   placemark.subThoroughfare, placemark.thoroughfare,
            //                   placemark.postalCode, placemark.locality,
            //                   placemark.administrativeArea,
            //                   placemark.country,
            //                   placemark.locality,
            //                   placemark.subLocality]);
            
            location = [NSString stringWithFormat:@"%@ (%@)",placemark.locality, placemark.country];
            location = [NSString stringWithString:location];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
}

@end
