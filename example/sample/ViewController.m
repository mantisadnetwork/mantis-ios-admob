//
//  ViewController.m
//  sample
//
//  Created by Paris Holley on 9/4/14.
//  Copyright (c) 2014 MANTIS Ad Network. All rights reserved.
//

#import "ViewController.h"
#import "MantisMediation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[MantisContext setPropertyId:@"53422cdc8e92f89afbf09d5d"];
    
    // Create a view of the standard size at the top of the screen.
    // Available AdSize constants are explained in GADAdSize.h.
    // Specify the ad unit ID.
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    bannerView_.adUnitID = @"ca-app-pub-6526362092043393/3064142865";
    
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
