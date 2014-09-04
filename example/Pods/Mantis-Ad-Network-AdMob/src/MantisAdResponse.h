#import "MantisAd.h"

@interface MantisAdResponse : NSObject
{
    
}

-(MantisAdResponse*)init:(NSDictionary*)json;
-(MantisAd*)getAdForZone:(NSString*)zoneName;

@end