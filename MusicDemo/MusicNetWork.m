//
//  MusicNetWork.m
//  MusicDemo
//
//  Created by thanh tung on 12/10/15.
//  Copyright © 2015 thanh tung. All rights reserved.
//

#import "MusicNetWork.h"
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#define BASE_URL @"https://www.nhaccuatui.com"
#import "TFHpple.h"
#import "MusicObject.h"

@interface MusicNetWork()
@property (nonatomic, strong) AFHTTPRequestOperationManager *httpRequestOperationManager;

@end
@implementation MusicNetWork
+(instancetype)shareManager {
    static MusicNetWork*musicNetwork = nil;
    static dispatch_once_t dispatchOnce;
    dispatch_once(&dispatchOnce, ^{
        musicNetwork = [self new];
    });
    return musicNetwork;
}
-(id)init {
    if (self = [super init]) {
        _httpRequestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:nil];
    }
    return self;
}
-(void) GetMusicFromLink:(NSString*) url OnComplete:(void(^)(NSArray *items))completedMethod fail:(void(^)())failMethod{
    NSError * error;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url] options:NSDataReadingUncached  error:&error];
    //NSData *data2 = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:url] options:NSDataReadingUncached error:&error];
    if (error) {
        failMethod();
    }
    NSMutableArray * allItems = [NSMutableArray new];
    
    TFHpple * tutorialPaser = [TFHpple hppleWithHTMLData:data];
    
    NSString * tutorialQueryString = @"//div[@class='box_resource_slide']/ul/li";
    NSArray *nodes = [tutorialPaser searchWithXPathQuery:tutorialQueryString];
    for (TFHppleElement * element in nodes) {
        TFHppleElement * elementBox_info_field = [element firstChildWithClassName:@"box_info_field"];
        
        TFHppleElement * elementA = [elementBox_info_field firstChildWithTagName:@"a"];
        NSString *linkMusicDetail = [elementA objectForKey:@"href"]; // get link music
        TFHppleElement * elementH3 = [elementBox_info_field firstChildWithClassName:@"h3"];
        NSString * nameMusic = [elementH3.children[0] content]; // get music name
        
        TFHppleElement *elementH4 = [elementBox_info_field firstChildWithClassName:@"list_name_singer"];
        TFHppleElement *elementH4_A = [elementH4 firstChildWithTagName:@"a"];
        NSString * nameSinger = elementH4_A.content; // get singer name
        
    
        NSString * urlImage = [[elementA firstChildWithTagName:@"img"] objectForKey:@"src"]; // get url image;
        
        TFHppleElement * elementSpan_views = [elementBox_info_field firstChildWithTagName:@"span"];
        NSString * viewsMusic = elementSpan_views.content;


//        NSString * date = elementDate.content;
//        date = [date stringByReplacingOccurrencesOfString:@"\n" withString:@""];

        
        MusicObject *musicObj = [[MusicObject alloc] initWithName:nameMusic andUrlImage:urlImage andSingerName:nameSinger andViewMusic:viewsMusic andLinkDetail:linkMusicDetail];
                            
        [allItems addObject:musicObj];
    }
    completedMethod(allItems);
}
@end

