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

+ (NSArray *)getQueryString {
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

    // Create NSMutableStrings from chars.
    NSMutableString *artist = [NSMutableString stringWithCString:artistName encoding:1];
    NSMutableString *track = [NSMutableString stringWithCString:trackName encoding:1];
    
    // Create query string.
    NSMutableString *query = [[NSMutableString alloc]initWithString:artist];
    [query appendString:@"+"];
    [query appendString:track];
    
    // Repace whitespaces by '+' and return array.
    return [[NSArray alloc] initWithObjects:artist, track, [query stringByReplacingOccurrencesOfString:@" " withString:@"+"], nil];
}

+ (void)printResults:(NSDictionary *)dict withArray:(NSArray *)array {
    BOOL alreadyOut = NO;
    NSArray *results = [dict objectForKey:@"results"];
    for (NSDictionary *result in results) {
        
        // Check if results match the input.
        if ([[result objectForKey:@"artistName"] localizedStandardContainsString:[array objectAtIndex:0]] && [[result objectForKey:@"trackName"] localizedStandardContainsString:[array objectAtIndex:1]]) {
            alreadyOut = YES;
            NSLog(@"It's already out on iTunes!");
            NSLog(@"- - - - -");
            NSLog(@"Artist: %@",[result objectForKey:@"artistName"]);
            NSLog(@"Track: %@",[result objectForKey:@"trackName"]);
            NSLog(@"Album: %@",[result objectForKey:@"collectionName"]);
            NSLog(@"- - - - -");
            break;
        }
    }
    if (!alreadyOut) {
        NSLog(@"No track/artist match found on iTunes.");
    }
    
}

@end
