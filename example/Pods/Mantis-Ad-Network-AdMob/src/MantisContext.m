#import "MantisContext.h"

@implementation MantisContext

@synthesize _propertyId;

+ (id)instance {
    static MantisContext *context = nil;
    
    @synchronized(self) {
        if (context == nil){
            context = [[self alloc] init];
        }
    }
    
    return context;
}

-(void)setPropertyId:(NSString*)propertyId
{
    _propertyId = propertyId;
}

-(NSString*)getPropertyId
{
    return _propertyId;
}

@end