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

+ (void)removeNewLine:(char *)c {
    if ((strlen(c)>0) && (c[strlen (c) - 1] == '\n'))
        c[strlen (c) - 1] = '\0';
}

+ (NSArray *)getQueryParameters {
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

@end
