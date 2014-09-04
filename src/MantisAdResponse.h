#import "MantisAd.h"

@interface MantisAdResponse
{
    
}

-(MantisAdResponse*)init:(NSDictionary*)json;
-(MantisAd*)getAdForZone:(NSString*)zoneName;

@end