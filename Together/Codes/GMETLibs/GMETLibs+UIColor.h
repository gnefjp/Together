//
//  GMETLibs+UIColor.h
//  Together
//
//  Created by Gnef_jp on 13-4-25.
//  Copyright (c) 2013年 GMET. All rights reserved.
//


static inline UIColor* GMETColorRGBMake(NSInteger r, NSInteger g, NSInteger b)
{
    return [UIColor colorWithRed:(r / 255.0)
                           green:(g / 255.0)
                            blue:(b / 255.0)
                           alpha:1.0];
}
