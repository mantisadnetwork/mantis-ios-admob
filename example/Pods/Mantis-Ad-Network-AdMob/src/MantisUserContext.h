#import <UIKit/UIKit.h>

@interface MantisUserContext : NSObject
{
    
}

-(BOOL)isTrackable;
-(NSString*)getId;

-(void)setLatitude:(CGFloat)setLatitude;
-(CGFloat)getLatitude;

-(void)setLongitude:(CGFloat)setLongitude;
-(CGFloat)getLongitude;

@end