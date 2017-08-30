//
//  main.m
//  OutYet
//
//  Created by martin on 30.08.17.
//  Copyright © 2017 martinlist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Helper.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // Create query string.
        NSString *finalQuery = [Helper getQueryString];
        NSLog(@"Query: %@", finalQuery);
        
        // Create query url.
        NSMutableString *queryURL = [NSMutableString stringWithFormat:@"https://itunes.apple.com/search?term="];
        [queryURL appendString:finalQuery];
        
        // Send request and receive data.
        NSString *response = [Helper getDataFrom:queryURL];
        
//        [Helper getDataFrom:queryURL success:^(NSString *responseDict ) {
//            // Parse json data.
//            NSData* jsonData = [responseDict dataUsingEncoding:NSUTF8StringEncoding];
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
//
//            // Check for results.
//            NSNumber *resultCount = [dict objectForKey:@"resultCount"];
//            if ([resultCount isNotEqualTo:@0]) {
//                [Helper printResults:dict];
//            }
//            else {
//                NSLog(@"No results.");
//            }
//        } failure:^(NSError *error) {
//            NSLog(@"%@",error);
//        }];

        // Parse json data.
        NSData* jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
        
        // Check for results.
        NSNumber *resultCount = [dict objectForKey:@"resultCount"];
        if ([resultCount isNotEqualTo:@0]) {
            [Helper printResults:dict];
        }
        else {
            NSLog(@"No results.");
        }
    }
    return 0;
}

