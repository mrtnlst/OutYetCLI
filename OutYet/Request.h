//
//  Request.h
//  OutYet
//
//  Created by martin on 03.09.17.
//  Copyright © 2017 martinlist. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Request <NSObject>

@property (readonly) NSMutableString *artist;
@property (readonly) NSString *album;
@property (readonly) NSMutableString *track;

- (id)initWithArtistName:(NSString *)a withTrackName:(NSString *)t;
- (NSString*)createQueryURL;
- (NSString*)getDataFrom:(NSString *)queryURL;
- (void)analyseContentOf:(NSString *)response;
- (void)printResults;

@end
