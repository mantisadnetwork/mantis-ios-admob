#import "MantisUserContext.h"
#import <AdSupport/ASIdentifierManager.h>
#import <UIKit/UIKit.h>

@implementation MantisUserContext{
    CGFloat _latitude;
    CGFloat _longitude;
}

-(BOOL)isTrackable{
    return [ASIdentifierManager sharedManager].isAdvertisingTrackingEnabled;
}

-(NSString*)getId{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

-(void)setLatitude:(CGFloat)latitude{
    _latitude = latitude;
}

-(CGFloat)getLatitude{
    return _latitude;
}

-(void)setLongitude:(CGFloat)longitude{
    _longitude = longitude;
}

-(CGFloat)getLongitude{
    return _longitude;
}

@end