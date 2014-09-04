//
//  ViewController.m
//  sample
//
//  Created by Paris Holley on 9/4/14.
//  Copyright (c) 2014 MANTIS Ad Network. All rights reserved.
//

#import "ViewController.h"
#import "MantisContext.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[MantisContext instance] setPropertyId:@"XXXXX"];
    
    // Create a view of the standard size at the top of the screen.
    // Available AdSize constants are explained in GADAdSize.h.
    // Specify the ad unit ID.
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    bannerView_.adUnitID = @"ca-app-pub-XXXXXXX";
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = self;
    [self.view addSubview:bannerView_];
    
    [bannerView_ loadRequest:[GADRequest request]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
