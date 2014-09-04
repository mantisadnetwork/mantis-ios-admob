@interface MantisContext : NSObject
{
    NSString *_propertyId;
}

@property (nonatomic, retain) NSString *_propertyId;

-(void)setPropertyId:(NSString*)propertyId;
-(NSString*)getPropertyId;
+ (id)instance;

@end