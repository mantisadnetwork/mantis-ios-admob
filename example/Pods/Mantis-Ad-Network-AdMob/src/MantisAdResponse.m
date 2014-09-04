#import "MantisAdResponse.h"
#import "MantisAd.h"

@implementation MantisAdResponse{
    NSMutableDictionary *_ads;
}

-(MantisAdResponse*)init:(NSDictionary*)json
{
    _ads = [[NSMutableDictionary alloc] init];
    
    NSDictionary *ads = [json valueForKey:@"ads"];
    
    for(NSString *key in ads){
        MantisAd *ad = [[MantisAd alloc] init:[ads valueForKey:key]];
        
        [_ads setValue:ad forKey:key];
    }
    
    return self;
}

-(MantisAd*)getAdForZone:(NSString*)zoneName{
    return [_ads valueForKey:zoneName];
}

@end