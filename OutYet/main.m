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
        NSArray *array = [Helper getQueryParameters];
         
        // Create query url.
        NSMutableString *queryURL = [NSMutableString stringWithFormat:@"https://itunes.apple.com/search?term="];
        [queryURL appendString:[array objectAtIndex:2]];
        
        // Send request and receive data.
        NSString *response = [Helper getDataFrom:queryURL];

        // Parse json data.
        NSData* jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
        
        // Check for results.
        NSNumber *resultCount = [dict objectForKey:@"resultCount"];
        if ([resultCount isNotEqualTo:@0]) {
            [Helper printResults:dict withArray:array];
        }
        else {
            NSLog(@"No results on iTunes.");
        }
    }
    return 0;
}

