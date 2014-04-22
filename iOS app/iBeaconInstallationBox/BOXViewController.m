//
//  BOXViewController.m
//  iBeaconInstallationBox
//
//  Created by Danny Holmes on 4/10/14.
//  Copyright (c) 2014 edu.EMDM.LSU. All rights reserved.
//

#import "BOXViewController.h"

@interface BOXViewController ()

@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) NSURL *url;

@property (nonatomic) int oldBeaconMajor;

///////////
////// Temporary: for Testing
////// later, delete this, the call at the bottom of this page, and the buttons in both storyboards

- (IBAction)toWebVC:(id)sender;

///////////

@end

@implementation BOXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self initRegion];
    [self locationManager:self.locationManager didStartMonitoringForRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)initRegion {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"edu.EMDM.LSU"];
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
                        //NSLog(@"Beacon Found");
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
                        //NSLog(@"Left Region");
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    
    CLBeacon *beacon = [[CLBeacon alloc] init];
    beacon = [beacons firstObject]; //maybe lastObject?
                        //NSLog(@"%@",beacons);
    
    int foundBeaconMajor = [beacon.major intValue];
                        //NSLog(@"%d found new major",foundBeaconMajor);
                        //NSLog(@"%d this was the old major",self.oldBeaconMajor);
    
    if (foundBeaconMajor == self.oldBeaconMajor) {
        
                        //NSLog(@"found the same beacon");
        
    } else {
        
        if (self.oldBeaconMajor == 0) {
                        //NSLog(@"first time finding a beacon");
            self.oldBeaconMajor = foundBeaconMajor;
            [self whichBeacon:foundBeaconMajor];
            
        } else {
            
            self.oldBeaconMajor = foundBeaconMajor;
                        //NSLog(@"%d changing to new major",foundBeaconMajor);
                        //NSLog(@"%d setting this major to be the old major",self.oldBeaconMajor);
            [self dismissViewControllerAnimated:NO completion:^{
                        //NSLog(@"dismissing viewcontroller, and loading the new one with major %d", foundBeaconMajor);
                [self whichBeacon:foundBeaconMajor];
            }];
        }
    }
}

-(void)whichBeacon:(int)newMajor {
                        //NSLog(@"setting URL to load based on which beacon found");
    
    
    if (newMajor == 10) {
        self.url = [[NSURL alloc] initWithString:@"http://www.google.com"];
                        //NSLog(@"the beacon major is %d, and the url is %@",new, self.url);
    }
    
    if (newMajor == 20) {
        self.url = [[NSURL alloc] initWithString:@"http://www.bing.com"];
                        //NSLog(@"the beacon major is %d, and the url is %@",new, self.url);
    }
    
    if (newMajor == 10043) {
        self.url = [[NSURL alloc] initWithString:@"http://www.yahoo.com"];
                        //NSLog(@"the beacon major is %d, and the url is %@",new, self.url);
    }
    
    if (newMajor == 15492) {
        self.url = [[NSURL alloc] initWithString:@"http://www.ask.com"];
                        //NSLog(@"the beacon major is %d, and the url is %@",new, self.url);
    }
                        //NSLog(@"going to prepareForSegue");
    float delayInSeconds = 1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self performSegueWithIdentifier:@"toWebVC" sender:self];
    });
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    WebVC *controller = [segue destinationViewController];
                        //NSLog(@"prepare for segue to (controller): %@",controller);
    controller.url = self.url;
                        //NSLog(@"prepare for segue with (url): %@",controller.url);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

///////////
////// Temporary: for Testing

- (IBAction)toWebVC:(id)sender {
    self.url = [[NSURL alloc] initWithString:@"http://www.yahoo.com"];
                        //NSLog(@"button pressed url: %@",self.url);
    
    float delayInSeconds = 1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self performSegueWithIdentifier:@"toWebVC" sender:self];
    });
                        //NSLog(@"perform segue GO");
}

@end