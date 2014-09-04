#import "MantisMediation.h"
#import "GADRequest.h"
#import "MantisContext.h"
#import "MantisAdRequest.h"
#import "MantisAd.h"
#import "MantisAdResponse.h"
#import "MantisUserContext.h"

@implementation MantisMediation{
    MantisAd *_ad;
}

@synthesize delegate;

-(void)onTapBanner:(UITapGestureRecognizer*)sender
{
    [self.delegate customEventBanner:self clickDidOccurInAd:sender.view];
    [self.delegate customEventBannerWillLeaveApplication:self];
    [self.delegate customEventBannerWillPresentModal:self];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[_ad getUrl]]];
}

-(void)setAdViewWithImageData:(NSData*)data url:(NSString*)url
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        mImageView.image = [UIImage imageWithData:data];
        //[mImageView setValue:url forKey:url];
        
        [self.delegate customEventBanner:self didReceiveAd:mImageView];
    });
    
    UITapGestureRecognizer* tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBanner:)];
    mImageView.userInteractionEnabled = YES;
    [mImageView addGestureRecognizer:tapRecog];
}

- (void)requestBannerAd:(GADAdSize)adSize
              parameter:(NSString *)zone
                  label:(NSString *)serverLabel
                request:(GADCustomEventRequest *)event
{
    MantisAdRequest* request = [[MantisAdRequest alloc] init];
    MantisUserContext* userContext = [[MantisUserContext alloc ]init];
    
    if ([event userLatitude]) {
        [userContext setLatitude:[event userLatitude]];
    }
    
    if ([event userLongitude]) {
        [userContext setLongitude:[event userLongitude]];
    }
    
    [request exec:@[zone] context:[MantisContext instance] userContext:userContext callback:^void(MantisAdResponse* response) {
        if(response == nil){
            [self.delegate customEventBanner:self didFailAd:nil];
            
            return;
        }
        
        _ad = [response getAdForZone:zone];
        
        if(_ad == nil){
            [self.delegate customEventBanner:self didFailAd:nil];
            
            return;
        }
        
        mImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [_ad getWidth], [_ad getHeight])];
        
        NSData* savedData = [[NSUserDefaults standardUserDefaults] objectForKey:[_ad getImage]];
        
        if (savedData)
        {
            [self setAdViewWithImageData:savedData url:[_ad getUrl]];
        }
        else
        {
            NSURL *imageUrl = [[NSURL alloc] initWithString:[_ad getImage]];
            
            [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:imageUrl] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
             {
                 if (error)
                 {
                     [self.delegate customEventBanner:self didFailAd:error];
                     return;
                 }
                 
                 [[NSUserDefaults standardUserDefaults] setObject:data forKey:[_ad getImage]];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 [self setAdViewWithImageData:data url:[_ad getUrl]];
             }];
        }
    }];
}

@end