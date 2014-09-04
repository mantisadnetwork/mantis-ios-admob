#import "MantisAdResponse.h"

@implementation MantisAdResponse{
    NSMutableDictionary *_ads;
}

-(MantisAdResponse*)init:(NSDictionary*)json
{
    NSDictionary *ads = [json valueForKey:@"ads"];
    
    for(NSString *key in ads){
        MantisAd *ad = [MantisAd init json:[ads valueForKey:key]];
        
        [_ads setValue:ad forKey:key];
    }
    
}

-(MantisAd*)getAdForZone:(NSString*)zoneName{
    return [_ads valueForKey zoneName];
}

@end