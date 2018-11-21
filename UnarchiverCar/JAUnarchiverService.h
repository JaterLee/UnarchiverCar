//
//  JAUnarchiverService.h
//  UnarchiverCar
//
//  Created by Jater on 2018/11/21.
//  Copyright © 2018年 Jater. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JAUnarchiverService : NSObject

- (void)exportCarFileAtPath:(NSString *)carFilePath toExportPath:(NSString *)exportPath;

@end

NS_ASSUME_NONNULL_END
