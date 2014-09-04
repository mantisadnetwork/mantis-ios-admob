#import "MantisMediation.h"
#import "GADRequest.h"
#import "MantisContext.h"
#import "MantisAdRequest.h"
#import "MantisAdResponse.h"

@implementation MantisMediation
@synthesize delegate;

-(void)onTapBanner:(UITapGestureRecognizer*)sender
{
    [self.delegate customEventBanner:self clickDidOccurInAd:sender.view];
    [self.delegate customEventBannerWillLeaveApplication:self];
    [self.delegate customEventBannerWillPresentModal:self];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://google.com"]];
}

-(void)setAdViewWithImageData:(NSData*)data url:(NSString*)url
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        mImageView.image = [UIImage imageWithData:data];
        [mImageView setValue:url forKey:url];
        
        [self.delegate customEventBanner:self didReceiveAd:mImageView];
    });
    
    UITapGestureRecognizer* tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBanner:)];
    mImageView.userInteractionEnabled = YES;
    [mImageView addGestureRecognizer:tapRecog];
}

- (void)requestBannerAd:(GADAdSize)adSize
              parameter:(NSString *)zone
                  label:(NSString *)serverLabel
                request:(GADCustomEventRequest *)gadCustomEventRequest
{
    MantisContext* context = [MantisContext init];
    
    MantisAdRequest* request = [MantisAdRequest init];
    
    [request exec:@[zone] context:context callback:^void(MantisAdResponse* response) {
        if(response == nil){
            [self.delegate customEventBanner:self didFailAd:nil];
            
            return;
        }
        
        MantisAd *ad = [response getAdForZone:zone];
        
        if(ad == nil){
            [self.delegate customEventBanner:self didFailAd:nil];
            
            return;
        }
        
        mImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [ad getWidth], [ad getHeight])];
        
        NSData* savedData = [[NSUserDefaults standardUserDefaults] objectForKey:[ad getImage]];
        
        if (savedData)
        {
            [self setAdViewWithImageData:savedData url:[ad getUrl]];
        }
        else
        {
            NSURL *imageUrl = [[NSURL alloc] initWithString:[ad getImage]];
            
            [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:imageUrl] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
             {
                 if (error)
                 {
                     [self.delegate customEventBanner:self didFailAd:error];
                     return;
                 }
                 
                 [[NSUserDefaults standardUserDefaults] setObject:data forKey:[ad getImage]];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 [self setAdViewWithImageData:data url:[ad getUrl]];
             }];
        }
    }];
}

@end