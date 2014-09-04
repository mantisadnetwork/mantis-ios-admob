#import <Foundation/Foundation.h>
#import "GADCustomEventBanner.h"
#import "GADBannerViewDelegate.h"
#import "GADBannerView.h"

@interface MantisMediation : NSObject <GADCustomEventBanner>
{
    UIImageView* mImageView;
    
    NSString* mCurrentAdUrl;
}

@end
