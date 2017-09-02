//
//  Request.h
//  OutYet
//
//  Created by martin on 02.09.17.
//  Copyright © 2017 martinlist. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Request

@property (readonly) NSString *artist;
@property (readonly) NSString *album;
@property (readonly) NSString *trackName;

@end
