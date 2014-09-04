#import "ViewController.h"
#import "MantisContext.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[MantisContext instance] setPropertyId:@"xxx"];
    
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    bannerView_.adUnitID = @"ca-app-pub-xxx";
    bannerView_.rootViewController = self;
    
    [self.view addSubview:bannerView_];
    
    [bannerView_ loadRequest:[GADRequest request]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
