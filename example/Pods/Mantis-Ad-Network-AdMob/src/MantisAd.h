@interface MantisAd : NSObject
{
    
}

-(NSString*)getImage;
-(NSString*)getUrl;
-(int)getWidth;
-(int)getHeight;
-(MantisAd*)init:(NSDictionary*)json;

@end