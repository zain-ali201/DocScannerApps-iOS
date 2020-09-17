//
//  ImageObject.h
//  Document Scanner
//
//  Created by Apple on 11/09/2020.
//  Copyright © 2020 kazuh1ko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageObject : NSObject

@property(nonatomic,retain) NSString *imgName;
@property(nonatomic,retain) UIImage *img;

@end

NS_ASSUME_NONNULL_END
