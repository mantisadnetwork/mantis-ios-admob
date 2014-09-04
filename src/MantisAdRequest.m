#import "MantisAdRequest.h"
#import "MantisContext.h"
#import "MantisAdResponse.h"

@implementation MantisAdRequest

-(void)exec:(NSArray*)zones context:(MantisContext*)context callback:( void( ^ )( MantisAdResponse*) )callback
{
    NSURL *URL = [NSURL URLWithString:@"http://mantodea.mantisadnetwork.com/mobile/ads"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *data = @{
        //@"title": @"This is the title",
        //@"trackable": [NSNumber numberWithBool:YES],
        //@"mobileUUID": @"123",
        //@"screen": @"Screen!",
        //@"age": [NSNumber numberWithInt:123],
        //@"latitude": [NSNumber numberWithInt:123],
        //@"longitude": [NSNumber numberWithInt:123],
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