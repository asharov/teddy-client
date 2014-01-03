//
//  TTTimeProvider.h
//  TeddyTrip
//
//  Created by Jaakko Kangasharju on 03/01/14.
//
//

#import <Foundation/Foundation.h>

@protocol TTTimeProviderDelegate <NSObject>

- (void)timeDidChange:(NSDate *)currentTime;

@end

@interface TTTimeProvider : NSObject

@property (weak) id<TTTimeProviderDelegate> delegate;

- (NSDate *)currentTime;

@end
