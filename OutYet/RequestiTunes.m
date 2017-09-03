//
//  RequestiTunes.m
//  OutYet
//
//  Created by martin on 03.09.17.
//  Copyright © 2017 martinlist. All rights reserved.
//

#import "RequestiTunes.h"

@implementation RequestiTunes

@synthesize album;
@synthesize track;
@synthesize artist;

- (id)initWithArtistName:(NSString *)a withTrackName:(NSString *)t {
    // Call the NSObject's init method.
    self = [super init];
    
    // Did it return something non-nil?
    if (self) {
        
        // Set the artist and track name.
        artist = [NSMutableString stringWithString: a];
        track = [NSMutableString stringWithString: t];
    }
    // Create query string.
    NSString *queryURL = [self createQueryURL];
    NSString *response = [self getDataFrom:queryURL];
    [self analyseContentOf:response];
    
    // Return a pointer to the new object.
    return self;
}

- (NSString*)createQueryURL {
    // Append artist and track names.
    NSMutableString *query = [[NSMutableString alloc] initWithString:artist];
    [query appendString:@"+"];
    [query appendString:track];
    
    // Repace whitespaces by '+' and return array.
    NSString *queryString = [query stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    // Append query string to iTunes URL.
    NSMutableString *queryURL = [NSMutableString stringWithFormat:@"https://itunes.apple.com/search?term="];
    [queryURL appendString:queryString];
    
    return queryURL;
}

- (NSString *)getDataFrom:(NSString *)queryURL {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:queryURL]];
    
    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", queryURL, (long)[responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

- (void)analyseContentOf:(NSString *)response {
    // Parse json data.
    NSData* jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    
    NSNumber *resultCount = [dict objectForKey:@"resultCount"];
    if ([resultCount isNotEqualTo:@0]) {
        BOOL alreadyOut = NO;
        NSArray *results = [dict objectForKey:@"results"];
        for (NSDictionary *result in results) {
            
            // Check if results match the input.
            if ([[result objectForKey:@"artistName"] localizedStandardContainsString:[self artist]] && [[result objectForKey:@"trackName"] localizedStandardContainsString:[self track]]) {
                alreadyOut = YES;
                track = [result objectForKey:@"trackName"];
                artist = [result objectForKey:@"artistName"];
                album = [result objectForKey:@"collectionName"];
                [self printResults];
                break;
            }
        }
        if (!alreadyOut) {
            NSLog(@"No track/artist match found on iTunes.");
        }
    }
    else {
        NSLog(@"No results on iTunes.");
    }
}

- (void)printResults {
    NSLog(@"It's already out on iTunes!");
    NSLog(@"- - - - -");
    NSLog(@"Artist: %@", artist);
    NSLog(@"Track: %@", track);
    NSLog(@"Album: %@", album);
    NSLog(@"- - - - -");
}

@end
