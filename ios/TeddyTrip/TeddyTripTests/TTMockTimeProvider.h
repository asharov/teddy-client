//
//  TTMockTimeProvider.h
//  TeddyTrip
//
//  Created by Jaakko Kangasharju on 03/01/14.
//
//

#import <Foundation/Foundation.h>
#import "TTTimeProvider.h"

@interface TTMockTimeProvider : TTTimeProvider

- (void)advance:(uint32_t)milliseconds;

@end
