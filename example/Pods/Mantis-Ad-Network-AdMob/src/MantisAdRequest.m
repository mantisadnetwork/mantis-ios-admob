#import "MantisAdRequest.h"
#import "MantisContext.h"
#import "MantisAdResponse.h"

@implementation MantisAdRequest

-(void)exec:(NSArray*)zones context:(MantisContext*)context userContext:(MantisUserContext*)userContext callback:( void( ^ )( MantisAdResponse*) )callback
{
    NSURL *URL = [NSURL URLWithString:@"http://mantodea.mantisadnetwork.com/mobile/ads"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *data = @{
        @"trackable": [NSNumber numberWithBool:[userContext isTrackable]],
        @"mobileUUID": [userContext getId],
        @"latitude": [NSNumber numberWithFloat:[userContext getLatitude]],
        @"longitude": [NSNumber numberWithFloat:[userContext getLongitude]],
        @"mobileSdk": [NSNumber numberWithBool:YES],
        @"zones": zones,
        @"propertyId": [context getPropertyId]
    };
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:nil];
    NSString* jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    
    [request setHTTPBody: [jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
         if (error)
         {
             callback(nil);
             return;
         }
        
        NSError *jsonError = nil;
        NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if(jsonError != nil){
            callback(nil);
            return;
        }
        
        callback([[MantisAdResponse alloc] init:parsedObject]);
    }];
    
    [task resume];
};
                                 
@end