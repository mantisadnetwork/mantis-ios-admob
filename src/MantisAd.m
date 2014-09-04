#import "MantisAd.h"

@implementation MantisAd{
    NSString *_image;
    NSString *_url;
    int _width;
    int _height;
}

-(MantisAd*)init:(NSDictionary*)json
{
    _image = [json valueForKey:@"image"];
    _url = [json valueForKey:@"url"];
    _width = [[json objectForKey:@"width"] intValue];
    _height = [[json objectForKey:@"height"] intValue];
    
    return self;
}

-(NSString*)getImage{
    return _image;
}

-(NSString*)getUrl{
    return _url;
}

-(int)getWidth{
    return _width;
}

-(int)getHeight{
    return _height;
}

@end