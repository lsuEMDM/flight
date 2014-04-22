//
//  WebVC.m
//  iBeaconInstallationBox
//
//  Created by Danny Holmes on 4/10/14.
//  Copyright (c) 2014 edu.EMDM.LSU. All rights reserved.
//

#import "WebVC.h"

@interface WebVC ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebVC

@synthesize url;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
                            //NSLog(@"loaded the new viewcontroller with the url: %@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
                            //NSLog(@"sending url request: %@",request);
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
