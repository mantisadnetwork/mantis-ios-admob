#import "MantisContext.h"

static NSString* propertyId;

@implementation MantisContext

-(void)setPropertyId:(NSString*)propertyId
{
    propertyId = [NSString stringWithString:propertyId];
}

-(NSString*)getPropertyId
{
    return propertyId;
}

@end