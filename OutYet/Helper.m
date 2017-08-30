//
//  Request.m
//  OutYet
//
//  Created by martin on 30.08.17.
//  Copyright © 2017 martinlist. All rights reserved.
//

#import "Helper.h"
#define MAX_NAME_SZ 50

@implementation Helper

//+ (void)getDataFrom:(NSString *)url success:(void (^)(NSString *))success failure:(void(^)(NSError* error))failure {
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//        [request setHTTPMethod:@"GET"];
//        [request setURL:[NSURL URLWithString:url]];
//
//    NSLog(@"Request reply: %@", url);
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
//    {
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//         NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
//        if(httpResponse.statusCode == 200) {
//            NSLog(@"Request reply: %@", requestReply);
//            success(requestReply);
//        }
//        else {
//            NSLog(@"Error");
//        }
//    }];
//    [dataTask resume];
//
//}
+ (NSString *)getDataFrom:(NSString *)url {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];

    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;

    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];

    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", url, (long)[responseCode statusCode]);
        return nil;
    }

    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

+ (void)removeNewLine:(char *)c {
    if ((strlen(c)>0) && (c[strlen (c) - 1] == '\n'))
        c[strlen (c) - 1] = '\0';
}

+ (NSString *)getQueryString {
    // Read chars with fgets.
    char *artistName = malloc(MAX_NAME_SZ);
    char *trackName = malloc(MAX_NAME_SZ);;
    NSLog(@"Artist: ");
    fgets(artistName, MAX_NAME_SZ, stdin);
    NSLog(@"Track: ");
    fgets(trackName, MAX_NAME_SZ, stdin);
    
    // Remove new line.
    [self removeNewLine:artistName];
    [self removeNewLine:trackName];
    //    removeNewLine(artistName);
//    removeNewLine(trackName);
    
    // Create NSMutableStrings from chars.
    NSMutableString *artist = [NSMutableString stringWithCString:artistName encoding:1];
    NSMutableString *track = [NSMutableString stringWithCString:trackName encoding:1];
    
    // Create query string.
    NSMutableString *query = [[NSMutableString alloc]initWithString:artist];
    [query appendString:@"+"];
    [query appendString:track];
    
    // Repace whitespaces by '+'.
    return  [query stringByReplacingOccurrencesOfString:@" " withString:@"+"];
}

+ (void)printResults:(NSDictionary *)dict {
    NSArray *results = [dict objectForKey:@"results"];
    for (NSDictionary *result in results) {
        NSLog(@"Artist: %@",[result objectForKey:@"artistName"]);
        NSLog(@"Track: %@",[result objectForKey:@"trackName"]);
        NSLog(@"Album: %@",[result objectForKey:@"collectionName"]);
        NSLog(@"- - - - -");
    }
}

@end
