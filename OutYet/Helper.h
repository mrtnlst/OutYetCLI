//
//  Request.h
//  OutYet
//
//  Created by martin on 30.08.17.
//  Copyright © 2017 martinlist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

+ (NSString*)getDataFrom:(NSString *)url;
//+ (void)processResponseUsingData:(NSData*)data;
//+ (void)getDataFrom:(NSString *)url success:(void (^)(NSString *responseDict))success failure:(void(^)(NSError* error))failure;
+ (NSArray *)getQueryString;
+ (void)removeNewLine:(char *)c;
+ (void)printResults:(NSDictionary *)dict withArray:(NSArray *)array;

@end
