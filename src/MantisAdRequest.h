#import "MantisAdResponse.h"
#import "MantisContext.h"
#import "MantisUserContext.h"

@interface MantisAdRequest : NSObject
{
    
}

-(void)exec:(NSArray*)zones context:(MantisContext*)context userContext:(MantisUserContext*)userContext callback:( void( ^ )( MantisAdResponse*) )callback;

@end