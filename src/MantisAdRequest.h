#import "MantisAdResponse.h"
#import "MantisContext.h"

@interface MantisAdRequest : NSObject
{
    
}

-(void)exec:(NSArray*)zones context:(MantisContext*)context callback:( void( ^ )( MantisAdResponse*) )callback;

@end