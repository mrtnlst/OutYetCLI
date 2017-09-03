//
//  main.m
//  OutYet
//
//  Created by martin on 30.08.17.
//  Copyright © 2017 martinlist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Helper.h"
#import "RequestiTunes.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // Create query string.
        NSArray *array = [Helper getQueryParameters];

        // Create iTunes request.
        __unused RequestiTunes  *itunesRequest = [[RequestiTunes alloc] initWithArtistName:[array objectAtIndex:0]
                                                                             withTrackName:[array objectAtIndex:1]];
    }
    return 0;
}

